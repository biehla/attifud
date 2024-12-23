## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Track window resolution. Relevant only in WINDOW_MODE_WINDOWED display mode.
class_name ConfigurationVideoResolution
extends Node

var options: LinkedMap
var disabled: bool = false


## web cannot change resolution
func _ready() -> void:
	if OS.has_feature("web"):
		disabled = true

	_init_options()
	load_resolution()


func get_resolution() -> Vector2i:
	return get_tree().get_root().size


func get_saved_index() -> int:
	var resolution: Vector2i = ConfigStorageSettingsVideo.get_resolution_option_value()
	return options.find_key_index_by_value(resolution)


func get_option_index() -> int:
	var resolution: Vector2i = get_resolution()
	var index: int = options.find_key_index_by_value(resolution)
	if index == -1:
		index = get_saved_index()
	return index


func set_option_index(index: int) -> void:
	var resolution: Vector2i = options.get_value_at(index)
	_set_resolution(resolution)
	ConfigStorageSettingsVideo.set_resolution_option_value(resolution)


func load_resolution() -> void:
	var resolution: Vector2i = ConfigStorageSettingsVideo.get_resolution_option_value()
	_set_resolution(resolution)


func refresh_resolution() -> int:
	var resolution: Vector2i = get_resolution()
	var index: int = options.find_key_index_by_value(resolution)
	if index != -1:
		ConfigStorageSettingsVideo.set_resolution_option_value(resolution)
	else:
		index = get_saved_index()
	return index


func _set_resolution(resolution: Vector2i) -> void:
	if disabled:
		return
	if resolution == get_resolution():
		return
	if DisplayServer.window_get_mode() != DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
		return

	get_tree().get_root().size = resolution

	SignalBus.configuration_display_size_changed.emit()


func _init_options() -> void:
	options = LinkedMap.new()

	_init_option("480p - 854 x 480", Vector2i(854, 480))
	_init_option("720p - 1280 x 720", Vector2i(1280, 720))
	_init_option("1080p - 1920 x 1080", Vector2i(1920, 1080))
	_init_option("1440p - 2560 x 1440", Vector2i(2560, 1440))
	_init_option("2160p - 3840 x 2160", Vector2i(3840, 2160))
	_init_option("4320p - 7680 x 4320", Vector2i(7680, 4320))


func _init_option(label: String, resolution: Vector2i) -> void:
	options.add(label, resolution)
