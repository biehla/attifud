## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Attach to parent whose children are [Control] nodes to which this will apply.
## Set export variables to get a desired animation effect. (Inherited from [Motion].)
## Use [add_motion] func to increment scale. It will start returning to the original over time.
class_name ScaleMotion
extends Motion

@export var center_pivot: bool = true


func _ready() -> void:
	super.initialize(Control)

	if center_pivot:
		for target: Control in targets:
			target.resized.connect(_on_resized.bind(target))
			_on_resized(target)


func _motion_transform(target: Node) -> void:
	target.scale = _original_target_value[target] * motion_factor


func _get_target_original_value(target: Node) -> Variant:
	return target.scale


func _on_resized(target: Control) -> void:
	target.pivot_offset = target.size / 2
