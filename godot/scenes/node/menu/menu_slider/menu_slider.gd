## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Localized slider with accessibility buttons that emit a global signal.
@tool
class_name MenuSlider
extends MarginContainer

@export var id: MenuSliderEnum.ID = MenuSliderEnum.ID.UNKNOWN

@export var label: String:
	set(value):
		label = value
		_refresh_label()

var _last_value: float

@onready var label_label: Label = %LabelLabel
@onready var value_label: Label = %ValueLabel

@onready var h_slider: HSliderExpand = %HSliderExpand
@onready var decrement_slider_button: Button = %DecrementSliderButton
@onready var decrement_step_slider_button: Button = %DecrementStepSliderButton
@onready var increment_slider_button: Button = %IncrementSliderButton
@onready var increment_step_slider_button: Button = %IncrementStepSliderButton


func _ready() -> void:
	_connect_signals()
	_refresh_label()
	set_value()


func set_value(value: float = 0) -> void:
	_last_value = value
	h_slider.value = value
	_refresh_value()


func _refresh_label() -> void:
	if label_label == null:
		label_label = %LabelLabel
	label_label.text = TranslationServerWrapper.translate(label)


func _refresh_value() -> void:
	value_label.text = str(int(h_slider.value))


func _connect_signals() -> void:
	if Engine.is_editor_hint():
		return

	SignalBus.language_changed.connect(_on_language_changed)

	h_slider.value_changed.connect(_on_slider_value_changed)
	decrement_slider_button.pressed.connect(_on_slider_value_added.bind(-10.0))
	decrement_step_slider_button.pressed.connect(_on_slider_value_added.bind(-1.0))
	increment_slider_button.pressed.connect(_on_slider_value_added.bind(10.0))
	increment_step_slider_button.pressed.connect(_on_slider_value_added.bind(1.0))


func _on_language_changed(_locale: String) -> void:
	_refresh_label()


func _on_slider_value_changed(value: float) -> void:
	_on_slider_value_added(h_slider.value - value)


func _on_slider_value_added(increment: float) -> void:
	var value: float = min(h_slider.max_value, max(h_slider.min_value, h_slider.value + increment))
	if value == _last_value:
		return

	Log.debug("%s: menu slider ID '%s' value changed." % [name, MenuSliderEnum.ID.keys()[id]])

	_last_value = value
	if h_slider.value != value:
		h_slider.value = value
	_refresh_value()

	if id == null or id == MenuSliderEnum.ID.UNKNOWN:
		return
	SignalBus.menu_slider_value_changed.emit(id, value, self)
