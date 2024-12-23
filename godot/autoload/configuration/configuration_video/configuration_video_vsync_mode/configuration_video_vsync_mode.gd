## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Track vsync mode.
## [br][br]
## Compatibility renderer does not support all modes.
## Some combinations of drivers and OS do not support all modes (fallback to ENABLED).
class_name ConfigurationVideoVsyncMode
extends Node

var options: LinkedMap
var disabled_options: Dictionary
var _compatibility_disabled_options: Dictionary


func _ready() -> void:
	_init_options()
	load_vsync_mode()


func get_vsync_mode() -> int:
	return DisplayServer.window_get_vsync_mode()


func get_saved_index() -> int:
	var vsync_mode: int = ConfigStorageSettingsVideo.get_vsync_mode_option_value()
	return options.find_key_index_by_value(vsync_mode)


func get_option_index() -> int:
	var vsync_mode: int = get_vsync_mode()
	var index: int = options.find_key_index_by_value(vsync_mode)
	if index == -1:
		index = get_saved_index()
	return index


func set_option_index(index: int) -> void:
	var vsync_mode: int = options.get_value_at(index)
	_set_vsync_mode(vsync_mode)
	ConfigStorageSettingsVideo.set_vsync_mode_option_value(vsync_mode)


func load_vsync_mode() -> void:
	var vsync_mode: int = ConfigStorageSettingsVideo.get_vsync_mode_option_value()
	_set_vsync_mode(vsync_mode)


func _set_vsync_mode(vsync_mode: int) -> void:
	if vsync_mode != get_vsync_mode():
		DisplayServer.window_set_vsync_mode(vsync_mode)


func _init_options() -> void:
	options = LinkedMap.new()
	_compatibility_disabled_options = {}

	_init_option("MENU_OPTIONS_DISABLED", DisplayServer.VSyncMode.VSYNC_DISABLED, false)
	_init_option("MENU_OPTIONS_ENABLED", DisplayServer.VSyncMode.VSYNC_ENABLED, false)
	_init_option("MENU_OPTIONS_ADAPTIVE", DisplayServer.VSyncMode.VSYNC_ADAPTIVE, true)
	_init_option("MENU_OPTIONS_FAST", DisplayServer.VSyncMode.VSYNC_MAILBOX, true)

	disabled_options = {}
	if ProjectSettings.get_setting("rendering/renderer/rendering_method") == "gl_compatibility":
		disabled_options = _compatibility_disabled_options


func _init_option(label: String, vsync_mode: int, compatibility_disabled: bool) -> void:
	options.add(label, vsync_mode)
	_compatibility_disabled_options[label] = compatibility_disabled
