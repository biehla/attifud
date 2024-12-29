## Original File MIT License Copyright (c) 2024 TinyTakinTeller
extends MarginContainer

const DELETE_DIALOG_LABEL: String = "MENU_OPTIONS_KEYBINDS_DELETE_DIALOG_LABEL"
const KEYBIND_DIALOG_TITLE: String = "MENU_OPTIONS_KEYBINDS_KEYBIND_DIALOG_TITLE"
const CONFIRM_LABEL: String = "MENU_LABEL_CONFIRM_BUTTON_YOU"
const CANCEL_LABEL: String = "MENU_LABEL_CANCEL_YOU"

var _action_handler: ActionHandler = ActionHandler.new()

var _keybinds_action: StringName
var _keybinds_input: InputEvent

@onready var keybinds_map_margin_container: MarginContainer = %KeybindsMapMarginContainer
@onready var menu_keybinds: MenuKeybinds = %MenuKeybinds

@onready var menu_unbind_dialog: ConfirmationDialog = %MenuUnbindDialog
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

	menu_keybind_dialog.title_label.text = (
		TranslationServerWrapper.translate(KEYBIND_DIALOG_TITLE) % [item_text]
	)
	menu_keybind_dialog.ok_button_text = TranslationServerWrapper.translate(CONFIRM_LABEL)
	menu_keybind_dialog.cancel_button_text = TranslationServerWrapper.translate(CANCEL_LABEL)
	var relative_size: Vector2i = MathUtils.scale_v2i(keybinds_map_margin_container.size, 0.75, 0.5)
	menu_keybind_dialog.popup_centered(relative_size)


func _on_keybind_item_input_interacted(
	action: StringName, input: InputEvent, item_text: String, parent_item_text: String
) -> void:
	_keybinds_action = action
	_keybinds_input = input

	menu_unbind_dialog.dialog_text = (
		TranslationServerWrapper.translate(DELETE_DIALOG_LABEL) % [parent_item_text, item_text]
	)
	menu_unbind_dialog.ok_button_text = TranslationServerWrapper.translate(CONFIRM_LABEL)
	menu_unbind_dialog.cancel_button_text = TranslationServerWrapper.translate(CANCEL_LABEL)
	menu_unbind_dialog.popup_centered(Vector2i(1, 1))


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
