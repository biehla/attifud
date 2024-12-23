## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name ConfigStorageSettingsVideo

const SETTINGS_VIDEO_SECTION: String = "SettingsVideo"

const DISPLAY_MODE_KEY: String = "DisplayMode"
const RESOLUTION_KEY: String = "Resolution"
const VSYNC_MODE_KEY: String = "VSyncMode"
const FPS_LIMIT_KEY: String = "FPSLimit"
const FPS_COUNT_KEY: String = "FPSCount"
const ANTI_ALIAS_KEY: String = "AntiAlias"

const DEFAULT_DISPLAY_MODE: int = DisplayServer.WindowMode.WINDOW_MODE_WINDOWED
const DEFAULT_RESOLUTION: Vector2i = Vector2i(1280, 720)
const DEFAULT_VSYNC_MODE: int = DisplayServer.VSyncMode.VSYNC_ENABLED
const DEFAULT_FPS_LIMIT: int = 0
const DEFAULT_FPS_COUNT: bool = false
const DEFAULT_ANTI_ALIAS: int = 0


static func get_display_mode_option_value() -> int:
	return ConfigStorage.get_config(SETTINGS_VIDEO_SECTION, DISPLAY_MODE_KEY, DEFAULT_DISPLAY_MODE)


static func get_resolution_option_value() -> Vector2i:
	return ConfigStorage.get_config(SETTINGS_VIDEO_SECTION, RESOLUTION_KEY, DEFAULT_RESOLUTION)


static func get_vsync_mode_option_value() -> int:
	return ConfigStorage.get_config(SETTINGS_VIDEO_SECTION, VSYNC_MODE_KEY, DEFAULT_VSYNC_MODE)


static func get_fps_limit_option_value() -> int:
	return ConfigStorage.get_config(SETTINGS_VIDEO_SECTION, FPS_LIMIT_KEY, DEFAULT_FPS_LIMIT)


static func get_fps_count_enabled() -> bool:
	return ConfigStorage.get_config(SETTINGS_VIDEO_SECTION, FPS_COUNT_KEY, DEFAULT_FPS_COUNT)


static func get_anti_alias_option_value() -> int:
	return ConfigStorage.get_config(SETTINGS_VIDEO_SECTION, ANTI_ALIAS_KEY, DEFAULT_ANTI_ALIAS)


static func set_display_mode_option_value(display_mode: int) -> void:
	ConfigStorage.set_config(SETTINGS_VIDEO_SECTION, DISPLAY_MODE_KEY, display_mode)


static func set_resolution_option_value(resolution: Vector2i) -> void:
	ConfigStorage.set_config(SETTINGS_VIDEO_SECTION, RESOLUTION_KEY, resolution)


static func set_vsync_mode_option_value(vsync_mode: int) -> void:
	ConfigStorage.set_config(SETTINGS_VIDEO_SECTION, VSYNC_MODE_KEY, vsync_mode)


static func set_fps_limit_option_value(fps_limit: int) -> void:
	ConfigStorage.set_config(SETTINGS_VIDEO_SECTION, FPS_LIMIT_KEY, fps_limit)


static func set_fps_count_enabled(fps_count: bool) -> void:
	ConfigStorage.set_config(SETTINGS_VIDEO_SECTION, FPS_COUNT_KEY, fps_count)


static func set_anti_alias_option_value(anti_alias: int) -> void:
	ConfigStorage.set_config(SETTINGS_VIDEO_SECTION, ANTI_ALIAS_KEY, anti_alias)


static func delete() -> void:
	ConfigStorage.erase_section(SETTINGS_VIDEO_SECTION)
