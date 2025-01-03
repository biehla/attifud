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
## If target is not focusable, searches among their children until a valid ancestor is found.
@export var recursive: bool = false
## Will trigger on ready() method called instead of on _ready() method override.
@export var manual: bool = false

var _ready_called: bool = false


func _ready() -> void:
	if not manual:
		ready()


func ready() -> void:
	if _ready_called:
		Log.warn("Ready already called.")
		return
	_ready_called = true

	if target == null:
		target = _get_focusable_control_child(self.get_parent())

	if target == null:
		Log.warn("Could not find focusable target for parent: ", self.get_parent().name)
		return

	_connect_signals()
	_grab_focus.call_deferred()


func _grab_focus() -> void:
	if target.is_visible_in_tree():
		target.grab_focus()


func _get_focusable_control_child(node: Node) -> Control:
	for child: Node in node.get_children(true):
		if is_instance_of(child, Control):
			if (child as Control).focus_mode != Control.FocusMode.FOCUS_NONE:
				return child
		if recursive:
			var focusable: Node = _get_focusable_control_child(child)
			if focusable != null:
				return focusable
	return null


func _connect_signals() -> void:
	get_viewport().connect("gui_focus_changed", _on_gui_focus_changed)
	target.visibility_changed.connect(_on_visibility_changed)


func _on_visibility_changed() -> void:
	_grab_focus.call_deferred()


func _on_gui_focus_changed(control: Control) -> void:
	if remember_last_focus and get_parent() == control.get_parent() and target != control:
		target = control
