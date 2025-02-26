## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Track vsync mode.
## [br][br]
## Compatibility renderer does not support all modes.
## Some combinations of drivers and OS do not support all modes (fallback to ENABLED).
## [br][br]
## NOTE: Maybe this script could be easier to re-use if refactored such that:
## - Some methods were to be inherited from a base class "ConfigurationDropdownOption" or similar.
class_name ConfigurationVideoVsyncMode
extends Node
# This class is responsible for saving, loading and applying (possible) option values of "vsync".

# A "dropdown" option type is tracked by [LinkedMap] and each value corresponds to a dropdown index.
# The "vsync" option values are [int] and represent the [DisplayServer.VSyncMode] enum values.
# The possible values are defined in [_init_options] function.
var options: LinkedMap

# some platforms do not support all "vsync" option values so we track that in "disabled_options"
# example: "_compatibility_disabled_options" tracks values unsupported in compatibility render mode
var disabled_options: Dictionary
var _compatibility_disabled_options: Dictionary


# load and apply the saved option value at startup
# (after initializing possible option values and checking for disabled option values)
func _ready() -> void:
	_init_options()
	load_vsync_mode()


# get current option value
func get_vsync_mode() -> int:
	return DisplayServer.window_get_vsync_mode()


# get dropdown index of the saved option value
func get_saved_index() -> int:
	var vsync_mode: int = ConfigStorageSettingsVideo.get_vsync_mode_option_value()
	return options.find_key_index_by_value(vsync_mode)


# get dropdown index of the current option value
func get_option_index() -> int:
	var vsync_mode: int = get_vsync_mode()
	var index: int = options.find_key_index_by_value(vsync_mode)
	if index == -1:
		index = get_saved_index()
	return index


# apply and save option (player picked a new value based on selected corresponding dropdown index)
func set_option_index(index: int) -> void:
	var vsync_mode: int = options.get_value_at(index)
	_set_vsync_mode(vsync_mode)
	ConfigStorageSettingsVideo.set_vsync_mode_option_value(vsync_mode)


# used to load and apply the saved option value
func load_vsync_mode() -> void:
	var vsync_mode: int = ConfigStorageSettingsVideo.get_vsync_mode_option_value()
	_set_vsync_mode(vsync_mode)


# apply the given option value
func _set_vsync_mode(vsync_mode: int) -> void:
	if vsync_mode != get_vsync_mode():
		DisplayServer.window_set_vsync_mode(vsync_mode)


# define possible option values and their names
func _init_options() -> void:
	options = LinkedMap.new()
	_compatibility_disabled_options = {}

	_init_option("MENU_OPTIONS_DISABLED", DisplayServer.VSyncMode.VSYNC_DISABLED, false)
	_init_option("MENU_OPTIONS_ENABLED", DisplayServer.VSyncMode.VSYNC_ENABLED, false)
	_init_option("MENU_OPTIONS_ADAPTIVE", DisplayServer.VSyncMode.VSYNC_ADAPTIVE, true)
	_init_option("MENU_OPTIONS_FAST", DisplayServer.VSyncMode.VSYNC_MAILBOX, true)

	# platforms using "gl_compatibility" rendering method do not support some vsync option values
	# i.e. VSYNC_ADAPTIVE and VSYNC_MAILBOX are not supported on platforms using "gl_compatibility"
	disabled_options = {}
	if ProjectSettings.get_setting("rendering/renderer/rendering_method") == "gl_compatibility":
		disabled_options = _compatibility_disabled_options


# define a new possible option value, its name ("label"), if it is disabled for compatibility or not
func _init_option(label: String, vsync_mode: int, compatibility_disabled: bool) -> void:
	options.add(label, vsync_mode)
	_compatibility_disabled_options[label] = compatibility_disabled
