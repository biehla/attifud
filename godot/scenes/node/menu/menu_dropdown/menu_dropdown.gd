## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Localized option button that emits a global signal.
@tool
class_name MenuDropdown
extends MarginContainer

@export var id: MenuDropdownEnum.ID = MenuDropdownEnum.ID.UNKNOWN

@export var label: String:
	set(value):
		label = value
		_refresh_label()

@export var option_padding: int = 3

var _options: Array[String]
var _disabled_options: Dictionary
var _hide_disabled: bool

@onready var label_label: Label = %LabelLabel

@onready var option_button: OptionButton = %OptionButton


func _ready() -> void:
	_connect_signals()
	_refresh_label()


func init_options(
	options: Array[String], disabled_options: Dictionary = {}, hide_disabled: bool = false
) -> void:
	_options = options
	_disabled_options = disabled_options
	_hide_disabled = hide_disabled
	_refresh_options()


func set_option(index: int = -1) -> void:
	option_button.select(index)


func _refresh_size() -> void:
	option_button.get_popup().visible = false


func _refresh_options() -> void:
	option_button.clear()
	for option: String in _options:
		var is_disabled: bool = _disabled_options.get(option, false)
		var localized_text: String = TranslationServerWrapper.translate(option)
		if is_disabled and _hide_disabled:
			continue
		option_button.add_item(StringUtils.add_padding(localized_text, option_padding))
		var item_index: int = option_button.item_count - 1
		option_button.set_item_disabled(item_index, is_disabled)


func _refresh_label() -> void:
	if label_label == null:
		label_label = %LabelLabel
	label_label.text = TranslationServerWrapper.translate(label)


func _connect_signals() -> void:
	if Engine.is_editor_hint():
		return

	SignalBus.language_changed.connect(_on_language_changed)

	option_button.item_selected.connect(_on_option_button_item_selected)

	get_tree().get_root().connect("size_changed", _on_root_size_changed)


func _on_language_changed(_locale: String) -> void:
	_refresh_label()
	_refresh_options()


func _on_option_button_item_selected(index: int) -> void:
	Log.debug("%s: menu dropdown ID '%s' idx '%s'." % [name, MenuDropdownEnum.ID.keys()[id], index])

	if id == null or id == MenuDropdownEnum.ID.UNKNOWN:
		return
	SignalBus.menu_dropdown_option_selected.emit(id, index, self)


func _on_root_size_changed() -> void:
	call_deferred("_refresh_size")
