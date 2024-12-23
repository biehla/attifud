## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Track anti-alias (MSAA / FXAA).
## TODO: If needed, make FXAA a separate option and add more graphics options (TAA, VRS, HDR, ...).
class_name ConfigurationVideoAntiAliasMode
extends Node

const ANTI_ALIAS_FXAA: int = -1

var options: LinkedMap
var disabled: bool


func _ready() -> void:
	if ProjectSettings.get_setting("rendering/renderer/rendering_method") == "gl_compatibility":
		disabled = true

	_init_options()
	load_anti_alias()


func is_fxaa() -> bool:
	return (
		get_root_viewport().screen_space_aa == Viewport.ScreenSpaceAA.SCREEN_SPACE_AA_FXAA
		and get_root_viewport().msaa_2d == Viewport.MSAA.MSAA_DISABLED
		and get_root_viewport().msaa_3d == Viewport.MSAA.MSAA_DISABLED
	)


func get_root_viewport() -> Viewport:
	return get_viewport()


func get_anti_alias() -> int:
	if is_fxaa():
		return ANTI_ALIAS_FXAA
	return get_root_viewport().msaa_2d  # get_root_viewport().msaa_3d


func get_saved_index() -> int:
	var anti_alias: int = ConfigStorageSettingsVideo.get_anti_alias_option_value()
	return options.find_key_index_by_value(anti_alias)


func get_option_index() -> int:
	var anti_alias: int = get_anti_alias()
	var index: int = options.find_key_index_by_value(anti_alias)
	if index == -1:
		index = get_saved_index()
	return index


func set_option_index(index: int) -> void:
	var anti_alias: int = options.get_value_at(index)
	_set_anti_alias(anti_alias)
	ConfigStorageSettingsVideo.set_anti_alias_option_value(anti_alias)


func load_anti_alias() -> void:
	var anti_alias: int = ConfigStorageSettingsVideo.get_anti_alias_option_value()
	_set_anti_alias(anti_alias)


func _set_anti_alias(anti_alias: int) -> void:
	if disabled:
		return
	if anti_alias == get_anti_alias():
		return

	if anti_alias == ANTI_ALIAS_FXAA:
		get_root_viewport().screen_space_aa = Viewport.ScreenSpaceAA.SCREEN_SPACE_AA_FXAA
		get_root_viewport().msaa_2d = Viewport.MSAA.MSAA_DISABLED
		get_root_viewport().msaa_3d = Viewport.MSAA.MSAA_DISABLED
	else:
		get_root_viewport().screen_space_aa = Viewport.ScreenSpaceAA.SCREEN_SPACE_AA_DISABLED
		get_root_viewport().msaa_2d = anti_alias as Viewport.MSAA
		get_root_viewport().msaa_3d = anti_alias as Viewport.MSAA


func _init_options() -> void:
	options = LinkedMap.new()

	_init_option("MENU_OPTIONS_DISABLED", Viewport.MSAA.MSAA_DISABLED)
	_init_option("FXAA", ANTI_ALIAS_FXAA)
	_init_option("MSAA 2X", Viewport.MSAA.MSAA_2X)
	_init_option("MSAA 4X", Viewport.MSAA.MSAA_4X)
	_init_option("MSAA 8X", Viewport.MSAA.MSAA_8X)


func _init_option(label: String, vsync: int) -> void:
	options.add(label, vsync)
