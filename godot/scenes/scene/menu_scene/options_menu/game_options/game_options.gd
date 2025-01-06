## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Manages game options.
extends MarginContainer

var _action_handler: ActionHandler = ActionHandler.new()

@onready var autosave_menu_toggle: MenuToggle = %AutosaveMenuToggle
@onready var number_format_menu_dropdown: MenuDropdown = %NumberFormatMenuDropdown


func _ready() -> void:
	_connect_signals()
	_init_menu_nodes()
	_init_action_handler()
	_load_game_options()


func _load_game_options() -> void:
	var autosave_enabled: bool = Configuration.game.autosave.get_enabled()
	var number_format_option_index: int = Configuration.game.number_format.get_option_index()

	autosave_menu_toggle.set_value(autosave_enabled)
	number_format_menu_dropdown.set_option(number_format_option_index)


func _init_action_handler() -> void:
	_action_handler.set_register_type("MenuDropdown")
	_action_handler.register_action(
		MenuDropdownEnum.ID.NUMBER_FORMAT, _action_number_format_menu_dropdown
	)

	_action_handler.set_register_type("MenuToggle")
	_action_handler.register_action(MenuToggleEnum.ID.AUTOSAVE, _action_autosave_menu_toggle)

	_action_handler.set_register_type("MenuButton")
	_action_handler.register_action(MenuButtonEnum.ID.OPTIONS_MENU_RESET, _action_reset_menu_button)


func _action_number_format_menu_dropdown(index: int) -> void:
	Configuration.game.number_format.set_option_index(index)


func _action_autosave_menu_toggle(enabled: bool) -> void:
	Configuration.game.autosave.set_enabled(enabled)


func _action_reset_menu_button() -> void:
	if not is_visible_in_tree():
		return

	Configuration.game.reset()
	_load_game_options()


func _init_menu_nodes() -> void:
	_init_number_format_menu_dropdown()


func _init_number_format_menu_dropdown() -> void:
	var number_formats: Array[String] = Configuration.game.number_format.options.get_keys()
	number_format_menu_dropdown.init_options(number_formats)


func _connect_signals() -> void:
	SignalBus.menu_dropdown_option_selected.connect(_on_menu_dropdown_option_selected)
	SignalBus.menu_toggle_value_changed.connect(_on_menu_toggle_value_changed)
	SignalBus.menu_button_pressed.connect(_on_menu_button_pressed)


func _on_menu_dropdown_option_selected(
	id: MenuDropdownEnum.ID, index: int, _source: MenuDropdown
) -> void:
	_action_handler.handle_action_args("MenuDropdown", id, self, [index])


func _on_menu_toggle_value_changed(
	id: MenuToggleEnum.ID, enabled: bool, _source: MenuToggle
) -> void:
	_action_handler.handle_action_args("MenuToggle", id, self, [enabled])


func _on_menu_button_pressed(id: MenuButtonEnum.ID, _source: MenuButtonClass) -> void:
	_action_handler.handle_action("MenuButton", id, self)
