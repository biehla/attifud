## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Makes HSlider expand in the same way as ProgressBar expands to fill the parent control.
## [br][br]
## Modifies the theme override. If not found at node level, will look at the inherited theme.
@tool
class_name HSliderExpand
extends HSlider

const THEME_OVERRIDE_PROPERTY: String = "theme_override_styles/slider"
const THEME_INHERITED_PROPERTY: String = "HSlider/styles/slider"

@export var expand_factor: float = 1.0:
	set(value):
		expand_factor = value
		_refresh_size()

var _parent_control: Control


func _ready() -> void:
	_connect_signals()


func _refresh_size() -> void:
	if _parent_control == null:
		return

	var override_slider: StyleBox = self.get(THEME_OVERRIDE_PROPERTY) as StyleBox
	if override_slider != null:
		return _resize_slider(override_slider)

	var inherited_theme: Theme = NodeUtils.get_inherited_theme(self)
	if inherited_theme == null:
		return

	var theme_slider: StyleBox = inherited_theme.get(THEME_INHERITED_PROPERTY) as StyleBox
	if theme_slider != null:
		override_slider = theme_slider.duplicate()
		self.set(THEME_OVERRIDE_PROPERTY, override_slider)
		return _resize_slider(override_slider)


func _resize_slider(slider: StyleBox) -> void:
	slider.content_margin_top = int(float(_parent_control.size.y) * expand_factor / 2)
	slider.content_margin_bottom = int(float(_parent_control.size.y) * expand_factor / 2)


func _connect_signals() -> void:
	if _parent_control != null:
		return

	var parent: Node = get_parent()
	if parent != null and is_instance_of(parent, Control):
		_parent_control = parent as Control
		_parent_control.resized.connect(_on_parent_control_resized)


func _on_parent_control_resized() -> void:
	_refresh_size()
