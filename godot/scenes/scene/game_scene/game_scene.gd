## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name GameScene
extends Control

@export_group("Menu Scene")
@export var scene_id: String = "menu_scene"
@export var scene_manager_options_id: String = "fade_play"

var _action_handler: ActionHandler = ActionHandler.new()

@onready var game_content: GameContent = %GameContent
@onready var pause_menu: PauseMenu = %PauseMenu
@onready var options_menu: OptionsMenu = %OptionsMenu


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("game_pause"):
		if get_tree().paused:
			if pause_menu.visible:
				_action_continue_menu_button()
			else:
				_action_options_back_menu_button()
		else:
			_action_game_pause_menu_button()


func _ready() -> void:
	_connect_signals()
	_init_nodes()

	LogWrapper.debug(self, "Ready.")


func _init_nodes() -> void:
	_init_action_handler()


func _init_action_handler() -> void:
	_action_handler.set_register_type("MenuButton")
	_action_handler.register_actions(
		{
			MenuButtonEnum.ID.GAME_PAUSE: _action_game_pause_menu_button,
			MenuButtonEnum.ID.PAUSE_MENU_CONTINUE: _action_continue_menu_button,
			MenuButtonEnum.ID.PAUSE_MENU_OPTIONS: _action_options_menu_button,
			MenuButtonEnum.ID.PAUSE_MENU_LEAVE: _action_leave_menu_button,
			MenuButtonEnum.ID.PAUSE_MENU_QUIT: _action_quit_menu_button,
			MenuButtonEnum.ID.OPTIONS_MENU_BACK: _action_options_back_menu_button
		}
	)


func _action_game_pause_menu_button() -> void:
	game_content.visible = true
	pause_menu.visible = true
	options_menu.visible = false
	get_tree().paused = true
	LogWrapper.debug(name, "Game paused.")


func _action_continue_menu_button() -> void:
	game_content.visible = true
	pause_menu.visible = false
	options_menu.visible = false
	get_tree().paused = false
	game_content.control_grab_focus.grab_focus()
	LogWrapper.debug(name, "Game unpaused.")


func _action_options_menu_button() -> void:
	game_content.visible = false
	pause_menu.visible = false
	options_menu.visible = true


func _action_options_back_menu_button() -> void:
	game_content.visible = true
	pause_menu.visible = true
	options_menu.visible = false


func _action_leave_menu_button() -> void:
	_action_continue_menu_button()
	process_mode = PROCESS_MODE_DISABLED
	Data.exit_save_file()
	SceneManagerWrapper.change_scene("back", scene_manager_options_id)


func _action_quit_menu_button() -> void:
	get_tree().quit()


func _connect_signals() -> void:
	SignalBus.menu_button_pressed.connect(_on_menu_button_pressed)


func _on_menu_button_pressed(id: MenuButtonEnum.ID, _source: MenuButtonClass) -> void:
	_action_handler.handle_action("MenuButton", id, self)
