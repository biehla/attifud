## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name ConfigStorageSettingsVideo

const SETTINGS_VIDEO_SECTION: String = "SettingsVideo"

const DISPLAY_MODE_KEY: String = "DisplayMode"

const DEFAULT_DISPLAY_MODE: int = 0


static func get_display_mode_option_index() -> int:
	return ConfigStorage.get_config(SETTINGS_VIDEO_SECTION, DISPLAY_MODE_KEY, DEFAULT_DISPLAY_MODE)


static func set_display_mode_option_index(display_mode: int) -> void:
	ConfigStorage.set_config(SETTINGS_VIDEO_SECTION, DISPLAY_MODE_KEY, display_mode)


static func delete() -> void:
	ConfigStorage.erase_section(SETTINGS_VIDEO_SECTION)
