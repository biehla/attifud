## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Track keybinds.
class_name ConfigurationControlsKeybinds
extends Node

const INTERNAL_INPUT_PREFIX: StringName = &"ui_"
const EXPOSED_INTERNAL_INPUTS: Array[StringName] = [
	&"ui_right",
	&"ui_left",
	&"ui_up",
	&"ui_down",
	&"ui_accept",
	&"ui_select",
	&"ui_cancel",
	&"ui_focus_next",
	&"ui_focus_prev"
]


func _ready() -> void:
	load_keybinds()


## hide actions with internal input prefix unless they are listed as exposed internal inputs
func is_exposed_action(action: StringName) -> bool:
	return not action.begins_with(INTERNAL_INPUT_PREFIX) or (action in EXPOSED_INTERNAL_INPUTS)


func get_keybind_actions() -> Array[StringName]:
	var actions: Array[StringName] = InputMap.get_actions().filter(
		func(action: String) -> bool: return is_exposed_action(action)
	)
	return actions


func get_keybind_events(action: StringName) -> Array[InputEvent]:
	return InputMap.action_get_events(action)


func add_keybind_event(action: String, event: InputEvent) -> void:
	if event == null:
		return
	_modify_keybind(action, event, true)
	ConfigStorageSettingsControls.add_keybind(action, event)


func remove_keybind_event(action: String, event: InputEvent) -> void:
	if event == null:
		return
	_modify_keybind(action, event, false)
	ConfigStorageSettingsControls.remove_keybind(action, event)


func load_keybinds() -> void:
	InputMap.load_from_project_settings()
	var keybinds: Dictionary = ConfigStorageSettingsControls.get_keybinds()
	for action: StringName in keybinds:
		var action_inputs: Dictionary = keybinds[action]
		for input: InputEvent in action_inputs:
			var bind: bool = action_inputs[input]
			_modify_keybind(action, input, bind)


## bind or unbind input event to action name
func _modify_keybind(action: StringName, input: InputEvent, bind: bool) -> void:
	if bind and not InputMap.action_has_event(action, input):
		InputMap.action_add_event(action, input)
	if not bind and InputMap.action_has_event(action, input):
		InputMap.action_erase_event(action, input)
