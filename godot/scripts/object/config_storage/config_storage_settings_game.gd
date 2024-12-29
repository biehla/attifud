## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name ConfigStorageSettingsGame

const SETTINGS_GAME_SECTION: String = "SettingsGame"

const AUTOSAVE_ENABLED_KEY: String = "AutosaveEnabled"

const DEFAULT_ENABLED: bool = true


static func get_autosave_enabled() -> bool:
	return ConfigStorage.get_config(SETTINGS_GAME_SECTION, AUTOSAVE_ENABLED_KEY, DEFAULT_ENABLED)


static func set_autosave_enabled(enabled: bool) -> void:
	ConfigStorage.set_config(SETTINGS_GAME_SECTION, AUTOSAVE_ENABLED_KEY, enabled)


static func delete() -> void:
	ConfigStorage.erase_section(SETTINGS_GAME_SECTION)
