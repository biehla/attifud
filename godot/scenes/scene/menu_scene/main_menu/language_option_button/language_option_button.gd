## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name LanguageOptionButton
extends OptionButton


func _ready() -> void:
	_connect_signals()
	_init_options()
	_refresh_size()


func _refresh_size() -> void:
	self.get_popup().max_size.y = get_viewport().size.y - self.size.y - 32
	self.get_popup().visible = false


func _init_options() -> void:
	var locale_text: LinkedMap = Configuration.locale.get_locale_text()
	var current_locale: String = TranslationServer.get_locale()
	var current_index: int = -1
	self.clear()
	for locale: String in locale_text.get_keys():
		self.add_item(locale_text.get_value(locale))
		if locale == current_locale:
			current_index = self.item_count - 1
	self.select(current_index)


func _connect_signals() -> void:
	self.item_selected.connect(_on_language_option_button_item_select)
	get_tree().get_root().connect("size_changed", _on_root_size_changed)


func _on_language_option_button_item_select(index: int) -> void:
	var locale_text: LinkedMap = Configuration.locale.get_locale_text()
	var locale: String = locale_text.get_key_at(index)
	Configuration.locale.set_locale(locale)


func _on_root_size_changed() -> void:
	call_deferred("_refresh_size")
