## Modified File MIT License Copyright (c) 2024 TinyTakinTeller
## Original File MIT License Copyright (c) 2022-present Marek Belski
class_name MenuKeybindDialog
extends ConfirmationDialog

signal keybinds_input_recorded(input: InputEvent)

const LISTENING_TEXT: String = "MENU_OPTIONS_KEYBINDS_LISTENING_TEXT"
const FOCUS_HERE_TEXT: String = "MENU_OPTIONS_KEYBINDS_FOCUS_HERE_TEXT"
const CONFIRM_INPUT_TEXT: String = "MENU_OPTIONS_KEYBINDS_CONFIRM_INPUT_TEXT"

var _last_input_event: InputEvent
var _last_input_text: String
var _listening: bool = false
var _confirming: bool = false

@onready var title_label: Label = %TitleLabel
@onready var input_label: Label = %InputLabel
@onready var input_text_edit: TextEdit = %InputTextEdit

@onready var delay_timer: Timer = %DelayTimer


func _ready() -> void:
	_connect_signals()
	_init_components()


func _init_components() -> void:
	self.get_ok_button().focus_neighbor_top = input_text_edit.get_path()
	self.get_cancel_button().focus_neighbor_top = input_text_edit.get_path()


func _is_recordable_input(event: InputEvent) -> bool:
	return (
		event != null
		and (
			event is InputEventKey
			or event is InputEventMouseButton
			or event is InputEventJoypadButton
			or (event is InputEventJoypadMotion and abs(event.axis_value) > 0.5)
		)
		and event.is_pressed()
	)


func _record_input_event(event: InputEvent) -> void:
	_last_input_text = InputEventConsts.get_text(event)
	if _last_input_text.is_empty():
		return
	_last_input_event = event
	input_label.text = _last_input_text
	self.get_ok_button().disabled = false

	keybinds_input_recorded.emit(event)


func _start_listening() -> void:
	input_text_edit.placeholder_text = " " + TranslationServerWrapper.translate(LISTENING_TEXT)
	_listening = true
	delay_timer.start()


func _stop_listening() -> void:
	input_text_edit.placeholder_text = " " + TranslationServerWrapper.translate(FOCUS_HERE_TEXT)
	_listening = false
	_confirming = false


func _input_matches_last(event: InputEvent) -> bool:
	return _last_input_text == InputEventConsts.get_text(event)


func _is_mouse_input(event: InputEvent) -> bool:
	return event is InputEventMouse


func _input_confirms_choice(event: InputEvent) -> bool:
	return _confirming and not _is_mouse_input(event) and _input_matches_last(event)


func _should_process_input_event(event: InputEvent) -> bool:
	return _listening and _is_recordable_input(event) and delay_timer.is_stopped()


func _should_confirm_input_event(event: InputEvent) -> bool:
	return not _is_mouse_input(event)


func _focus_on_ok() -> void:
	get_ok_button().grab_focus()


func _process_input_event(event: InputEvent) -> void:
	if not _should_process_input_event(event):
		return
	if _input_confirms_choice(event):
		_confirming = false
		_focus_on_ok.call_deferred()
		return
	_record_input_event(event)
	if _should_confirm_input_event(event):
		_confirming = true
		delay_timer.start()
		input_text_edit.placeholder_text = (
			" " + TranslationServerWrapper.translate(CONFIRM_INPUT_TEXT)
		)


func _connect_signals() -> void:
	input_text_edit.focus_entered.connect(_on_text_edit_focus_entered)
	input_text_edit.focus_exited.connect(_on_input_text_edit_focus_exited)
	input_text_edit.gui_input.connect(_on_input_text_edit_gui_input)
	self.visibility_changed.connect(_on_visibility_changed)


func _on_text_edit_focus_entered() -> void:
	_start_listening.call_deferred()


func _on_input_text_edit_focus_exited() -> void:
	_stop_listening()


func _on_input_text_edit_gui_input(event: InputEvent) -> void:
	input_text_edit.set_deferred("text", "")
	_process_input_event(event)


func _on_visibility_changed() -> void:
	if visible:
		input_label.text = InputEventConsts.NONE
		input_text_edit.grab_focus()
		self.get_ok_button().disabled = true
