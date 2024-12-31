## Original File MIT License Copyright (c) 2024 TinyTakinTeller
extends MarginContainer

var _action_handler: ActionHandler = ActionHandler.new()

var _keybinds_action: StringName
var _keybinds_input: InputEvent

@onready var keybinds_map_margin_container: MarginContainer = %KeybindsMapMarginContainer
@onready var menu_keybinds: MenuKeybinds = %MenuKeybinds

@onready var menu_unbind_dialog: MenuUnbindDialog = %MenuUnbindDialog
@onready var menu_keybind_dialog: MenuKeybindDialog = %MenuKeybindDialog


func _ready() -> void:
	_connect_signals()
	_init_action_handler()


func _init_action_handler() -> void:
	_action_handler.set_register_type("MenuButton")
	_action_handler.register_action(MenuButtonEnum.ID.OPTIONS_MENU_RESET, _action_reset_menu_button)


func _action_reset_menu_button() -> void:
	if not is_visible_in_tree():
		return

	Configuration.controls.reset()
	menu_keybinds.refresh_keybinds()


func _connect_signals() -> void:
	menu_keybinds.action_interacted.connect(_on_keybind_item_action_interacted)
	menu_keybinds.input_interacted.connect(_on_keybind_item_input_interacted)

	menu_unbind_dialog.confirmed.connect(_on_delete_dialog_confirmed)

	menu_keybind_dialog.confirmed.connect(_on_record_dialog_confirmed)
	menu_keybind_dialog.keybinds_input_recorded.connect(_on_keybinds_input_recorded)

	SignalBus.menu_button_pressed.connect(_on_menu_button_pressed)


func _on_keybind_item_action_interacted(action: StringName, item_text: String) -> void:
	_keybinds_action = action
	menu_keybind_dialog.custom_popup(item_text, keybinds_map_margin_container)


func _on_keybind_item_input_interacted(
	action: StringName, input: InputEvent, item_text: String, parent_item_text: String
) -> void:
	_keybinds_action = action
	_keybinds_input = input
	menu_unbind_dialog.custom_popup(parent_item_text, item_text)


func _on_delete_dialog_confirmed() -> void:
	Configuration.controls.keybinds.remove_keybind_event(_keybinds_action, _keybinds_input)
	menu_keybinds.refresh_keybinds()


func _on_record_dialog_confirmed() -> void:
	Configuration.controls.keybinds.add_keybind_event(_keybinds_action, _keybinds_input)
	menu_keybinds.refresh_keybinds()


func _on_keybinds_input_recorded(input: InputEvent) -> void:
	_keybinds_input = input


func _on_menu_button_pressed(id: MenuButtonEnum.ID, _source: MenuButtonClass) -> void:
	_action_handler.handle_action("MenuButton", id, self)
