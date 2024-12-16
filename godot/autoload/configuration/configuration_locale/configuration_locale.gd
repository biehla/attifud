## Original File MIT License Copyright (c) 2024 TinyTakinTeller
##
## Provides a list of locales sorted by their english name text.
class_name ConfigurationLocale
extends Node

const LOCALE_TEXT_KEY: String = "STRING_ID"

var _locale_text_linked_map: LinkedMap = LinkedMap.new()


func _ready() -> void:
	var app_locale: String = ConfigManagerSettingsGeneral.get_app_locale()
	TranslationServer.set_locale(app_locale)

	_init_locales()


func get_locale_text() -> LinkedMap:
	return _locale_text_linked_map


func _init_locales() -> void:
	var current_locale: String = TranslationServer.get_locale()
	for locale: String in TranslationServer.get_loaded_locales():
		TranslationServer.set_locale(locale)
		var text: String = TranslationServer.translate(LOCALE_TEXT_KEY)
		_locale_text_linked_map.add(locale, text)
	TranslationServer.set_locale(current_locale)
	_locale_text_linked_map.sort_by_values()
