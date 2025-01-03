## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Persists data in save files.
## TLDR: Use 'select_save_file' method, then modify variables inside 'meta' and 'game' properties.
## [br][br]
## Each child of type [SaveData] represents a section of the save file and holds data in variables.
## If child is [SaveData.is_metadata()], its data is loaded before selecting a save file.
## Once save file is selected, each child will track and autosave the data in its own variables.
## [br][br]
## On filesystem, save files will be saved as a json representing save data.
## [br][br]
## Save files structure example: [br]
##	data [br]
##		save_1 [br]
##			save_1_meta.data [br]
##			save_1_game.data [br]
##		save_2 [br]
##			save_2_meta.data [br]
##			save_2_game.data [br]
extends Node

## Helps verify the integrity of the file contents. (Exists uniquely at the end of the file.)
const SIGNATURE = "§§§"

@export_category("Configuration")
@export var save_file_count: int = 3
## Save files will be of form "prefix_index_category.data" in directory "data/prefix_index".
@export var save_file_root_folder: String = PathConsts.USER + "data/"
@export var save_file_prefix: String = "save"
@export var save_file_extension: String = "data"
@export var autosave_seconds: int = 5

var selected_index: int = -1

## Save file structure is represented by children of type [SaveData].
var _save_datas: Array[SaveData] = []
## Load only metadata parts of all save files.
## Each element: keys are categories of [SaveData], values are vars dicts of [SaveData].
var _save_files: Array[Dictionary] = []

## Children hold data of currently selected save file.
@onready var meta: MetaSaveData = %MetaSaveData
@onready var game: GameSaveData = %GameSaveData

@onready var autosave_timer: Timer = %AutosaveTimer


func _ready() -> void:
	_connect_signals()

	_init_data_types()
	_init_save_files()
	_init_nodes()

	Log.debug("[DATA] Save files initialized: ", _save_files)


func get_save_files() -> Array[Dictionary]:
	return _save_files


func select_save_file(index: int, load_after_select: bool = true) -> void:
	selected_index = index
	if load_after_select:
		load_save_file()


func load_save_file() -> void:
	if selected_index == -1:
		Log.warn("Load data failed: save file not selected.")
		return
	for save_data: SaveData in _save_datas:
		_system_read_into_or_create(selected_index, save_data)
		save_data.selected_and_loaded(selected_index)


func save_save_file() -> void:
	if selected_index == -1:
		Log.warn("Save data failed: save file not selected.")
		return
	for save_data: SaveData in _save_datas:
		_system_write_from(selected_index, save_data)
		save_data.saved(selected_index)


func _init_nodes() -> void:
	autosave_timer.wait_time = autosave_seconds
	autosave_timer.start()


func _init_save_files() -> void:
	for index: int in range(save_file_count):
		var save_file_dict: Dictionary = _init_save_file(index)
		_save_files.append(save_file_dict)


func _init_save_file(index: int) -> Dictionary:
	var save_file_dict: Dictionary = {}
	for save_data: SaveData in _save_datas:
		var should_load: bool = save_data.is_metadata()
		if should_load:
			_system_read_into_or_create(index, save_data)
			save_file_dict[save_data.get_category()] = save_data.get_as_dict()
		save_data.clear()
	return save_file_dict


func _init_data_types() -> void:
	for child: Node in self.get_children():
		if not is_instance_of(child, SaveData):
			continue
		var save_data: SaveData = child as SaveData
		_save_datas.append(save_data)


## Returns file path to save file with given index (or just folder path if file = false).
func _system_get_save_file_path(index: int, category: String, file: bool = true) -> String:
	var save_file_folder: String = "%s_%s/" % [save_file_prefix, index]
	var filename: String = "%s_%s_%s.%s" % [save_file_prefix, index, category, save_file_extension]
	var path: String = save_file_root_folder + save_file_folder
	if file:
		return path + filename
	return path


func _system_write_from(index: int, save_data: SaveData) -> void:
	var category: String = save_data.get_category()
	var data: Dictionary = save_data.get_as_dict()

	var content: String = JSON.stringify(data)
	content += SIGNATURE

	var path: String = _system_get_save_file_path(index, category)
	var save_file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
	if save_file == null:
		# if cannot open path, create necessary directories then reopen
		var folder_path: String = _system_get_save_file_path(index, category, false)
		DirAccess.make_dir_recursive_absolute(folder_path)
		save_file = FileAccess.open(path, FileAccess.WRITE)
	save_file.store_line(content)
	save_file.close()

	# Log.debug("[DATA] System write: ", path)


## If cannot read save file or its data, create a new save file for given index.
func _system_read_into_or_create(index: int, save_data: SaveData) -> void:
	var success: bool = _system_read_into(index, save_data)
	if not success:
		_system_write_from(index, save_data)
		save_data.saved(index)


## Return false if no data was read (defaults were created), i.e. error or no file found.
func _system_read_into(index: int, save_data: SaveData) -> bool:
	var category: String = save_data.get_category()

	var path: String = _system_get_save_file_path(index, category)
	var save_file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if save_file == null:
		# if loading index for the first time (save file does not exist), it will be created
		save_data.clear(index)
		Log.debug("[DATA] Cannot open (error code: %s) at: " % [FileAccess.get_open_error()], path)
		return false
	var content: String = save_file.get_as_text()
	save_file.close()

	content = _sanitize_content(content)
	content = _system_verify_signature(content)
	var json_object: JSON = _system_parse_json(path, content)
	if json_object == null:
		# unreadable save file contents (this should never happen)
		save_data.clear(index)
		Log.debug("[DATA] Cannot parse (error code: %s) at: " % [FileAccess.get_open_error()], path)
		return false

	var data: Dictionary = json_object.get_data()
	save_data.set_from_dict(data, index)

	Log.debug("[DATA] System read:", path)
	return true


func _system_parse_json(path: String, content: String) -> JSON:
	var json_object: JSON = JSON.new()
	var parse_err: Error = json_object.parse(content)
	if parse_err != Error.OK:
		Log.warn("Failed to parse save file json (error code: %s) at: " % [parse_err], path)
		return null
	return json_object


func _sanitize_content(content: String) -> String:
	content = content.replace("\n", "")
	content = content.replace("\r\n", "")
	content = content.replace("\n\r", "")
	return content


## removes corrupt excess data from end of save file (underlying OS can fumble FileAccess operation)
func _system_verify_signature(content: String) -> String:
	var signature_index: int = content.find(SIGNATURE)
	if signature_index == -1:
		Log.warn("No signature found.")
		return content
	var new_content: String = content.substr(0, signature_index + SIGNATURE.length())
	if content.length() != new_content.length():
		var corrupt_content: String = content.substr(signature_index, content.length())
		Log.warn("Save file corruption detected and corrected: ", corrupt_content)
	new_content = content.replace(SIGNATURE, "")
	return new_content


func _connect_signals() -> void:
	autosave_timer.timeout.connect(_on_autosave_timer_timeout)


func _on_autosave_timer_timeout() -> void:
	if Configuration.game.get_autosave_enabled() and selected_index != -1:
		save_save_file()
