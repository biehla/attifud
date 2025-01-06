## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name GameScene
extends Control

@export_group("Menu Scene")
@export var scene_id: String = "menu_scene"
@export var scene_manager_options_id: String = "fade_play"

var _action_handler: ActionHandler = ActionHandler.new()

@onready var game_button: TextureButton = %GameButton


func _ready() -> void:
	_connect_signals()
	_init_nodes()

	LogWrapper.debug(self, "Ready.")


func _init_nodes() -> void:
	_init_action_handler()


# TODO label gain resource(s) particle effect (queue limit and cumulative particles?)
#
# TODO shortcut toggle buttons bottom-left (audio, format numbers, ... ?)
#
func _init_action_handler() -> void:
	_action_handler.set_register_type("MenuButton")
	_action_handler.register_actions(
		{
			MenuButtonEnum.ID.GAME_PAUSE: _action_game_pause_menu_button,
			MenuButtonEnum.ID.GAME_LEAVE: _action_game_leave_menu_button
		}
	)


func _action_game_pause_menu_button() -> void:
	pass  # TODO pause menu actions and keybind (shortcut) : Esc


func _action_game_leave_menu_button() -> void:
	process_mode = PROCESS_MODE_DISABLED
	Data.exit_save_file()
	SceneManagerWrapper.change_scene("back", scene_manager_options_id)


func _connect_signals() -> void:
	SignalBus.menu_button_pressed.connect(_on_menu_button_pressed)


func _on_menu_button_pressed(id: MenuButtonEnum.ID, _source: MenuButtonClass) -> void:
	_action_handler.handle_action("MenuButton", id, self)
