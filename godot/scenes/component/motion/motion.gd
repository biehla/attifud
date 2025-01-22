## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Base script for all motion components.
## Uses a tween to animate some property of given nodes.
## Override _get_target_original_value and _motion_transform to setup custom property motion.
## NOTE: Maybe it is better to use [AnimationPlayer] instead of tweens.
## [br][br]
## Set export variables to get a desired animation effect.
## Use [add_motion] func to increment property. It will start returning to the original over time.
class_name Motion
extends Node

signal motion_end

@export var target_children: bool = false
@export var targets: Array[Node] = []

@export_category("Motion")
@export var min_motion_factor: float = 1.0
@export var max_motion_factor: float = 1.5
@export var add_motion_default: float = 0.5
@export var motion_duration: float = 0.4

@export_category("Tween")
## See: https://www.reddit.com/r/godot/comments/14gt180
@export var transition_type: Tween.TransitionType = Tween.TransitionType.TRANS_LINEAR
@export var ease_type: Tween.EaseType = Tween.EaseType.EASE_IN

var motion_factor: float = min_motion_factor

var _original_target_value: Dictionary = {}
var _motion_tween: Tween = null


func _ready() -> void:
	initialize(null)


func initialize(target_type: Variant) -> void:
	if target_type == null:
		return
	if _is_targets_empty():
		var filter: Array = get_parent().get_children() if target_children else [get_parent()]
		for child: Node in filter:
			if is_instance_of(child, target_type):
				targets.append(child)
				_original_target_value[child] = _get_target_original_value(child)


func add_motion(motion_factor_increment: float = add_motion_default) -> void:
	if _is_targets_empty():
		LogWrapper.debug(self, "No targets set.")
		return

	if motion_factor_increment > 0:
		motion_factor = min(max_motion_factor, motion_factor + motion_factor_increment)
	else:
		motion_factor = max(min_motion_factor, motion_factor + motion_factor_increment)
	_reset_motion_tween()


func _reset_motion_tween() -> void:
	if _motion_tween != null:
		_motion_tween.kill()
	_motion_tween = create_tween().set_trans(transition_type).set_ease(ease_type)
	_motion_tween.tween_method(
		_motion_tween_method, motion_factor, min_motion_factor, motion_duration
	)
	_motion_tween.tween_callback(_motion_tween_callback)


func _motion_tween_method(factor: float) -> void:
	motion_factor = factor
	for target: Node in targets:
		_motion_transform(target)


func _motion_transform(_target: Node) -> void:
	pass


func _get_target_original_value(_target: Node) -> Variant:
	return null


func _motion_tween_callback() -> void:
	motion_end.emit()


func _is_targets_empty() -> bool:
	return targets == null or targets.is_empty()
