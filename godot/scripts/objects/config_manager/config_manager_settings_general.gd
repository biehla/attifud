## Original File MIT License Copyright (c) 2024 TinyTakinTeller

## Persists general application settings.
class_name ConfigManagerSettingsGeneral
extends Node

const SETTINGS_GENERAL_SECTION: String = "SettingsGeneral"

const APP_LOCALE_KEY: String = "AppLocale"

const DEFAULT_LOCALE: String = "en"


static func get_app_locale() -> String:
	return ConfigManager.get_config(SETTINGS_GENERAL_SECTION, APP_LOCALE_KEY, DEFAULT_LOCALE)


static func set_app_locale(locale: String) -> void:
	ConfigManager.set_config(SETTINGS_GENERAL_SECTION, APP_LOCALE_KEY, locale)
