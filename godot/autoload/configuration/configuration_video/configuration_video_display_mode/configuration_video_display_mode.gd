## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Track display mode.
class_name ConfigurationVideoDisplayMode
extends Node

const WINDOW_MODE_BORDERLESS_WINDOWED: int = -1
const WINDOW_MODE_BORDERLESS_MAXIMIZED: int = -2

var options: LinkedMap
var disabled_options: Dictionary
var _web_disabled_options: Dictionary

var _manual_set: bool = false


func _ready() -> void:
	_connect_signals()
	_init_options()
	load_display_mode()


func is_borderless_windowed() -> bool:
	return (
		DisplayServer.window_get_mode() == DisplayServer.WindowMode.WINDOW_MODE_WINDOWED
		and DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	)


func is_borderless_maximized() -> bool:
	return (
		DisplayServer.window_get_mode() == DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED
		and DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	)


func get_display_mode() -> int:
	if is_borderless_windowed():
		return WINDOW_MODE_BORDERLESS_WINDOWED
	if is_borderless_maximized():
		return WINDOW_MODE_BORDERLESS_MAXIMIZED
	return DisplayServer.window_get_mode()


func get_saved_index() -> int:
	var display_mode: int = ConfigStorageSettingsVideo.get_display_mode_option_value()
	return options.find_key_index_by_value(display_mode)


func get_option_index() -> int:
	var display_mode: int = get_display_mode()
	var index: int = options.find_key_index_by_value(display_mode)
	if index == -1:
		index = get_saved_index()
	return index


func set_option_index(index: int) -> void:
	var display_mode: int = options.get_value_at(index)
	_set_display_mode(display_mode)
	ConfigStorageSettingsVideo.set_display_mode_option_value(display_mode)


func load_display_mode() -> void:
	var display_mode: int = ConfigStorageSettingsVideo.get_display_mode_option_value()
	_set_display_mode(display_mode)


func _reload_display_mode() -> void:
	var option_index: int = get_option_index()
	if option_index == -1:
		return
	if get_option_index() == get_saved_index():
		return
	SignalBus.configuration_display_mode_reloaded.emit(option_index)


func _reload_resolution() -> void:
	var resolution: Vector2i = ConfigStorageSettingsVideo.get_resolution_option_value()
	get_tree().get_root().get_window().size = resolution


func _set_display_mode(window_mode: int) -> void:
	if window_mode == get_display_mode():
		return

	_manual_set = true
	if window_mode == DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		_reload_resolution()
	elif window_mode == DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	elif window_mode == WINDOW_MODE_BORDERLESS_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		_reload_resolution()
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	elif window_mode == WINDOW_MODE_BORDERLESS_MAXIMIZED:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	else:
		DisplayServer.window_set_mode(window_mode)
	_manual_set = false

	SignalBus.configuration_display_size_changed.emit()


func _init_options() -> void:
	options = LinkedMap.new()
	_web_disabled_options = {}

	_init_option("MENU_OPTIONS_WINDOWED", DisplayServer.WindowMode.WINDOW_MODE_WINDOWED, false)
	_init_option("MENU_OPTIONS_MAXIMIZED", DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED, true)
	_init_option("MENU_OPTIONS_FULLSCREEN", DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN, false)
	_init_option("MENU_OPTIONS_BORDERLESS_WINDOWED", WINDOW_MODE_BORDERLESS_WINDOWED, true)
	_init_option("MENU_OPTIONS_BORDERLESS_MAXIMIZED", WINDOW_MODE_BORDERLESS_MAXIMIZED, true)
	_init_option(
		"MENU_OPTIONS_EXCLUSIVE_FULLSCREEN",
		DisplayServer.WindowMode.WINDOW_MODE_EXCLUSIVE_FULLSCREEN,
		true
	)

	disabled_options = {}
	if OS.has_feature("web"):
		disabled_options = _web_disabled_options


func _init_option(label: String, window_mode: int, web_disabled: bool) -> void:
	options.add(label, window_mode)
	_web_disabled_options[label] = web_disabled


func _connect_signals() -> void:
	get_tree().get_root().size_changed.connect(_on_root_size_changed)


func _on_root_size_changed() -> void:
	if not _manual_set:
		_reload_display_mode()
