## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Provides accessibility to keyboard players and controller players.
## [br][br]
## Attach to parent node.
## Set target as first control node child if target is not already set.
## Grabs focus on target control node if visible in tree.
## Remembers new focus on another child and grabs it again when parent becomes visible in tree.
class_name ControlGrabFocus
extends Node

@export var target: Control
@export var remember_last_focus: bool = true


func _ready() -> void:
	if target == null:
		_set_target_to_first_control_child()

	if target == null:
		return

	_connect_signals()
	call_deferred("_grab_focus")


func _grab_focus() -> void:
	if target.is_visible_in_tree():
		target.grab_focus()


func _set_target_to_first_control_child() -> void:
	for child: Node in self.get_parent().get_children():
		if is_instance_of(child, Control):
			target = child
			return


func _connect_signals() -> void:
	get_viewport().connect("gui_focus_changed", _on_gui_focus_changed)
	target.visibility_changed.connect(_on_visibility_changed)


func _on_visibility_changed() -> void:
	call_deferred("_grab_focus")


func _on_gui_focus_changed(control: Control) -> void:
	if remember_last_focus and get_parent() == control.get_parent() and target != control:
		target = control
