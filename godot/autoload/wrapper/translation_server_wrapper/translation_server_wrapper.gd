## Original File MIT License Copyright (c) 2024 TinyTakinTeller
@tool
extends Node

const DEFAULT_EDITOR_LOCALE: String = "en"


func _ready() -> void:
	Log.debug("AUTOLOAD READY: ", name)


## Alternative to tr() that works when ran in @tool scripts in the editor (return key if not found).
## https://github.com/godotengine/godot/issues/46271
func translate(text: String) -> String:
	var localized_text: String
	if Engine.is_editor_hint():
		var translation: Translation = TranslationServer.get_translation_object(
			DEFAULT_EDITOR_LOCALE
		)
		localized_text = translation.get_message(text)
	else:
		localized_text = tr(text)

	if localized_text == "":
		return text
	return localized_text
