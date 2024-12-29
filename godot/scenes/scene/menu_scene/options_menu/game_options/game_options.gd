## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Manages game options.
extends MarginContainer

var _action_handler: ActionHandler = ActionHandler.new()

@onready var autosave_menu_toggle: MenuToggle = %AutosaveMenuToggle


func _ready() -> void:
	_connect_signals()
	_init_action_handler()
	_load_game_options()


func _load_game_options() -> void:
	var autosave_enabled: bool = Configuration.game.get_autosave_enabled()

	autosave_menu_toggle.set_value(autosave_enabled)


func _init_action_handler() -> void:
	_action_handler.set_register_type("MenuToggle")
	_action_handler.register_action(MenuToggleEnum.ID.AUTOSAVE, _action_autosave_menu_toggle)

	_action_handler.set_register_type("MenuButton")
	_action_handler.register_action(MenuButtonEnum.ID.OPTIONS_MENU_RESET, _action_reset_menu_button)


func _action_autosave_menu_toggle(enabled: bool) -> void:
	Configuration.game.set_autosave_enabled(enabled)


func _action_reset_menu_button() -> void:
	if not is_visible_in_tree():
		return

	Configuration.game.reset()
	_load_game_options()


func _connect_signals() -> void:
	SignalBus.menu_toggle_value_changed.connect(_on_menu_toggle_value_changed)
	SignalBus.menu_button_pressed.connect(_on_menu_button_pressed)


func _on_menu_toggle_value_changed(
	id: MenuToggleEnum.ID, enabled: bool, _source: MenuToggle
) -> void:
	_action_handler.handle_action_args("MenuToggle", id, self, [enabled])


func _on_menu_button_pressed(id: MenuButtonEnum.ID, _source: MenuButtonClass) -> void:
	_action_handler.handle_action("MenuButton", id, self)
