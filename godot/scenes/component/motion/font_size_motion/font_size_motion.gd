## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Set export variables to get a desired animation effect.
## Use [add_motion] func to increment font size. It will start returning to the original over time.
class_name FontSizeMotion
extends Motion


func _ready() -> void:
	super.initialize(Control)


func _motion_transform(target: Node) -> void:
	var font_size: int = roundi(_original_target_value[target] * motion_factor)
	ThemeUtils.set_font_size(target, font_size)


func _get_target_original_value(target: Node) -> Variant:
	return ThemeUtils.get_font_size(target)
