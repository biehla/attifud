## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Persists locale application setting.
class_name ConfigStorageSettingsLocale

const SETTINGS_GENERAL_SECTION: String = "SettingsGeneral"

const LOCALE_KEY: String = "Locale"

const DEFAULT_LOCALE: String = "en"


static func get_locale() -> String:
	return ConfigStorage.get_config(SETTINGS_GENERAL_SECTION, LOCALE_KEY, DEFAULT_LOCALE)


static func set_locale(locale: String) -> void:
	ConfigStorage.set_config(SETTINGS_GENERAL_SECTION, LOCALE_KEY, locale)
