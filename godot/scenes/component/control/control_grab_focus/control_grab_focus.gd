## Original File MIT License Copyright (c) 2024 TinyTakinTeller
##
## Provides accessibility to keyboard players and controller players.
##
## Attach to parent node.
## Grabs focus on first control node child if target node is not set.
class_name ControlGrabFocus
extends Node

@export var target: Control


func _ready() -> void:
	if target == null:
		_set_target_to_first_control_child()

	call_deferred("_grab_focus")


func _grab_focus() -> void:
	target.grab_focus()


func _set_target_to_first_control_child() -> void:
	for child: Node in self.get_parent().get_children():
		if is_instance_of(child, Control):
			target = child
			return
