## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Manages global video options. Updates on external video option changes (reloaded signal).
extends MarginContainer

var _action_handler: ActionHandler = ActionHandler.new()

@onready var display_mode_menu_dropdown: MenuDropdown = %DisplayModeMenuDropdown


func _ready() -> void:
	_connect_signals()
	_init_menu_nodes()
	_init_action_handler()
	_load_video_options()


func _load_video_options() -> void:
	Configuration.video.display_mode.load_display_mode()

	var display_mode_option_index: int = Configuration.video.display_mode.get_option_index()

	display_mode_menu_dropdown.set_option(display_mode_option_index)


func _init_action_handler() -> void:
	_action_handler.set_register_type("MenuDropdown")
	_action_handler.register_actions(
		{MenuDropdownEnum.ID.DISPLAY_MODE: _action_display_mode_menu_dropdown}
	)

	_action_handler.set_register_type("MenuButton")
	_action_handler.register_action(MenuButtonEnum.ID.OPTIONS_MENU_RESET, _action_reset_menu_button)


func _action_display_mode_menu_dropdown(index: int) -> void:
	Configuration.video.display_mode.set_option_index(index)


func _action_reset_menu_button() -> void:
	if not is_visible_in_tree():
		return

	Configuration.video.reset()
	_load_video_options()


func _init_menu_nodes() -> void:
	var display_modes: Array[String] = Configuration.video.display_mode.options.get_keys()
	var disabled_options: Dictionary = {}
	if OS.has_feature("web"):
		disabled_options = Configuration.video.display_mode.web_disabled_options
	display_mode_menu_dropdown.init_options(display_modes, disabled_options)


func _connect_signals() -> void:
	SignalBus.display_mode_reloaded.connect(_on_display_mode_reloaded)

	SignalBus.menu_dropdown_option_selected.connect(_on_menu_dropdown_option_selected)
	SignalBus.menu_button_pressed.connect(_on_menu_button_pressed)


func _on_display_mode_reloaded(index: int) -> void:
	display_mode_menu_dropdown.set_option(index)
	Configuration.video.display_mode.set_option_index(index)


func _on_menu_dropdown_option_selected(
	id: MenuDropdownEnum.ID, index: int, _source: MenuDropdown
) -> void:
	_action_handler.handle_action_args("MenuDropdown", id, self, [index])


func _on_menu_button_pressed(id: MenuButtonEnum.ID, _source: MenuButtonClass) -> void:
	_action_handler.handle_action("MenuButton", id, self)
