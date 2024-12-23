## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Track display mode as options index.
class_name ConfigurationVideoDisplayMode
extends Node

const WINDOW_MODE_BORDERLESS_WINDOWED: int = -1
const WINDOW_MODE_BORDERLESS_MAXIMIZED: int = -2

var options: LinkedMap
var web_disabled_options: Dictionary

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


## return -1 if not found
func get_option_index() -> int:
	var display_mode: int = get_display_mode()
	return options.find_key_index_by_value(display_mode)


func set_option_index(index: int) -> void:
	if index != get_option_index():
		var display_mode: int = options.get_value_at(index)
		_set_display_mode(display_mode)
		ConfigStorageSettingsVideo.set_display_mode_option_value(display_mode)


func reset() -> void:
	ConfigStorageSettingsVideo.delete()
	load_display_mode()


func load_display_mode() -> void:
	var display_mode: int = ConfigStorageSettingsVideo.get_display_mode_option_value()
	var index: int = options.find_key_index_by_value(display_mode)
	if index != get_option_index():
		_set_display_mode(display_mode)


func _reload_display_mode() -> void:
	var option_index: int = get_option_index()
	if option_index == -1:
		return
	SignalBus.display_mode_reloaded.emit(option_index)


## Toggles WINDOW_MODE_FULLSCREEN before toggling WINDOW_FLAG_BORDERLESS to adjust unexpected flags
func _set_display_mode(window_mode: int) -> void:
	_manual_set = true
	if window_mode == DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	if window_mode == DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	elif window_mode == WINDOW_MODE_BORDERLESS_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	elif window_mode == WINDOW_MODE_BORDERLESS_MAXIMIZED:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_MAXIMIZED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	else:
		DisplayServer.window_set_mode(window_mode)
	_manual_set = false


func _init_options() -> void:
	options = LinkedMap.new()
	web_disabled_options = {}

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


func _init_option(label: String, window_mode: int, web_disabled: bool) -> void:
	options.add(label, window_mode)
	web_disabled_options[label] = web_disabled


func _connect_signals() -> void:
	if not OS.has_feature("web"):
		get_tree().get_root().connect("size_changed", _on_root_size_changed)


func _on_root_size_changed() -> void:
	if not _manual_set:
		_reload_display_mode()
