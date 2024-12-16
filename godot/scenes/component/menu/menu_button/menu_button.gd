## Original File MIT License Copyright (c) 2024 TinyTakinTeller
##
## Localized button that refreshes text on language selected signal, on click emits pressed signal.
@tool
class_name MenuButtonClass
extends Button

@export var id: String

@export var label: String:
	set(value):
		label = value
		_refresh_label()

@export var padding_spaces: int = 7:
	set(value):
		padding_spaces = value
		_refresh_label()


func _ready() -> void:
	_connect_signals()
	_refresh_label()


func _refresh_label() -> void:
	self.text = _get_button_text()


func _get_button_text() -> String:
	var localized_text: String = TranslationServerWrapper.translate(label)
	return StringUtils.add_padding(localized_text, padding_spaces)


func _connect_signals() -> void:
	if Engine.is_editor_hint():
		return

	self.pressed.connect(_on_button_pressed)

	SignalBus.language_selected.connect(_on_language_selected)


func _on_button_pressed() -> void:
	Log.debug("Button ID '%s' pressed." % id)

	SignalBus.menu_button_pressed.emit(id)


func _on_language_selected(_locale: String) -> void:
	_refresh_label()
