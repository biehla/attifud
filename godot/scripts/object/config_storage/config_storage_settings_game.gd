## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name ConfigStorageSettingsGame

const SETTINGS_GAME_SECTION: String = "SettingsGame"

const AUTOSAVE_ENABLED_KEY: String = "AutosaveEnabled"
const NUMBER_FORMAT_KEY: String = "NumberFormat"
const GAME_MODE_KEY: String = "GameMode"

const DEFAULT_ENABLED: bool = true
const DEFAULT_NUMBER_FORMAT: NumberUtils.NumberFormat = NumberUtils.NumberFormat.DIGITS
const DEFAULT_GAME_MODE: int = 1


static func get_autosave_enabled() -> bool:
	return ConfigStorage.get_config(SETTINGS_GAME_SECTION, AUTOSAVE_ENABLED_KEY, DEFAULT_ENABLED)


static func get_number_format_option_value() -> NumberUtils.NumberFormat:
	return ConfigStorage.get_config(SETTINGS_GAME_SECTION, NUMBER_FORMAT_KEY, DEFAULT_NUMBER_FORMAT)


static func get_game_mode_option_value() -> int:
	return ConfigStorage.get_config(SETTINGS_GAME_SECTION, GAME_MODE_KEY, DEFAULT_GAME_MODE)


static func set_autosave_enabled(enabled: bool) -> void:
	ConfigStorage.set_config(SETTINGS_GAME_SECTION, AUTOSAVE_ENABLED_KEY, enabled)


static func set_number_format_option_value(number_format: NumberUtils.NumberFormat) -> void:
	ConfigStorage.set_config(SETTINGS_GAME_SECTION, NUMBER_FORMAT_KEY, number_format)


static func set_game_mode_option_value(game_mode: int) -> void:
	ConfigStorage.set_config(SETTINGS_GAME_SECTION, GAME_MODE_KEY, game_mode)


static func delete() -> void:
	ConfigStorage.erase_section(SETTINGS_GAME_SECTION)
