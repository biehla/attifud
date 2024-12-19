## Original File MIT License Copyright (c) 2024 TinyTakinTeller
##
## Makes HSlider expand in the same way as ProgressBar expands to fill the parent control.
@tool
class_name HSliderExpand
extends HSlider

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

	var override_slider: StyleBox = self.get("theme_override_styles/slider") as StyleBox
	if override_slider != null:
		return _resize_slider(override_slider)

	var inherited_theme: Theme = NodeUtils.get_inherited_theme(self)
	if inherited_theme == null:
		return

	var theme_slider: StyleBox = inherited_theme.get("HSlider/styles/slider") as StyleBox
	if theme_slider != null:
		override_slider = theme_slider.duplicate()
		self.set("theme_override_styles/slider", override_slider)
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
