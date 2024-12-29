## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Keybinds container that emits signals when interacted with.
class_name MenuKeybinds
extends Tree

signal action_interacted(action: StringName, item_text: String)
signal input_interacted(
	action: StringName, input: InputEvent, item_text: String, parent_item_text: String
)

@export var add_button_texture: Texture2D
@export var sub_button_texture: Texture2D

## Allows mouse user to interact with items on click without needing to click item buttons.
@export var interact_on_click: bool = false
## Allows keyboard and joypad users to interact with items without needing to select item buttons.
@export var interact_on_ui_input: bool = true

var _selected_keybinds_tree_item: TreeItem = null
var _last_focus_metadata: Variant = null


func _process(_delta: float) -> void:
	if interact_on_ui_input:
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_select"):
			_ui_interact()


func _ready() -> void:
	_connect_signals()
	refresh_keybinds()


func refresh_keybinds() -> void:
	self.clear()
	self.create_item()
	var actions: Array[StringName] = Configuration.controls.keybinds.get_keybind_actions()
	for action: StringName in actions:
		var action_keybinds_tree_item: TreeItem = _add_action_to_keybinds_tree(action)
		var inputs: Array[InputEvent] = Configuration.controls.keybinds.get_keybind_events(action)
		for input: InputEvent in inputs:
			_add_input_to_action_keybinds_tree_item(input, action_keybinds_tree_item)


func _get_action_text(action: StringName) -> String:
	action = action.trim_prefix("ui_")
	return action.capitalize()


func _add_action_to_keybinds_tree(action: StringName) -> TreeItem:
	var root_tree_item: TreeItem = self.get_root()
	var action_tree_item: TreeItem = self.create_item(root_tree_item)
	action_tree_item.set_text(0, _get_action_text(action))
	action_tree_item.set_metadata(0, action)
	if _last_focus_metadata is StringName and _last_focus_metadata == action:
		action_tree_item.select(0)
	if add_button_texture != null:
		action_tree_item.add_button(0, add_button_texture)
	return action_tree_item


func _add_input_to_action_keybinds_tree_item(input: InputEvent, tree_item: TreeItem) -> void:
	var input_tree_item: TreeItem = self.create_item(tree_item)
	input_tree_item.set_text(0, InputEventConsts.get_text(input))
	input_tree_item.set_metadata(0, input)
	if _last_focus_metadata is InputEvent and _last_focus_metadata == input:
		input_tree_item.select(0)
	if sub_button_texture != null:
		input_tree_item.add_button(0, sub_button_texture)


func _ui_interact(selected_tree_item: TreeItem = null) -> void:
	if selected_tree_item == null:
		selected_tree_item = self.get_selected()
		if selected_tree_item == null:
			return
	else:
		_selected_keybinds_tree_item = selected_tree_item

	var is_click: bool = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	if (
		(_selected_keybinds_tree_item == selected_tree_item or is_click)
		and (not is_click or interact_on_click)
	):
		Log.debug("Menu tree item: interacted.")
		_ui_interact_tree_item(selected_tree_item)
	else:
		Log.debug("Menu tree item: selected.")
	_selected_keybinds_tree_item = selected_tree_item


func _ui_interact_tree_item(tree_item: TreeItem) -> void:
	var metadata: Variant = tree_item.get_metadata(0)
	if metadata == null:
		return

	if metadata is StringName:
		_last_focus_metadata = metadata

		action_interacted.emit(metadata as StringName, tree_item.get_text(0))
	if metadata is InputEvent:
		var parent_tree_item: TreeItem = tree_item.get_parent()
		var parent_action: StringName = parent_tree_item.get_metadata(0)
		_last_focus_metadata = parent_action

		input_interacted.emit(
			parent_action,
			metadata as InputEvent,
			tree_item.get_text(0),
			parent_tree_item.get_text(0)
		)


func _connect_signals() -> void:
	self.focus_exited.connect(_on_keybinds_tree_focus_exited)
	self.cell_selected.connect(_on_keybinds_tree_cell_selected)
	self.button_clicked.connect(_on_keybinds_tree_button_clicked)


func _on_keybinds_tree_focus_exited() -> void:
	self.deselect_all()
	_selected_keybinds_tree_item = null
	Log.debug("Menu tree item: deselected.")


func _on_keybinds_tree_cell_selected() -> void:
	_ui_interact()


func _on_keybinds_tree_button_clicked(
	item: TreeItem, _column: int, _id: int, _mouse_button_index: int
) -> void:
	_ui_interact(item)
