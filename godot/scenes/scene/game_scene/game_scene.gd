## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Replace "GameContent" child scene with your own. (Keep unique name.)
## You can modify [_after_unpause], [_after_pause], [_after_leave] functions in this script.
## [br][br]
## NOTE: Additional examples: (replace "GameContent" child scene)
## - 2D Incremental Clicker (default): "scenes/scene/game_scene/game_content/game_content.tscn"
## - 3D First Person Controller: "artifacts/example_3d_fp_controller/scenes/.../game_content.tscn"
class_name GameScene
extends Node

@export_group("Menu Scene")
@export var scene: SceneManagerEnum.Scene = SceneManagerEnum.Scene.MENU_SCENE
@export var scene_manager_options_id: String = "fade_play"

var _action_handler: ActionHandler = ActionHandler.new()

@onready var game_content: Node = $GameContent
@onready var pause_menu: PauseMenu = %PauseMenu
@onready var options_menu: OptionsMenu = %OptionsMenu


# Esc key shortcut toggles pause menu or exits from options via back button.
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
	_load_game_content_scene()

	_connect_signals()
	_init_nodes()

	LogWrapper.debug(self, "Ready.")


func _after_pause() -> void:
	if "player" in game_content and game_content.player is Player:
		var player: Player = game_content.player
		player.release_mouse()


func _after_unpause() -> void:
	if "control_grab_focus" in game_content and game_content.control_grab_focus is ControlGrabFocus:
		var control_grab_focus: ControlGrabFocus = game_content.control_grab_focus
		control_grab_focus.grab_focus()

	if "player" in game_content and game_content.player is Player:
		var player: Player = game_content.player
		player.capture_mouse()


func _after_leave() -> void:
	pass


func _load_game_content_scene() -> void:
	game_content.queue_free()

	var game_content_pck: PackedScene = Configuration.game.game_mode.game_content_scene
	var game_content_instance: Node = game_content_pck.instantiate()
	NodeUtils.add_child_front(game_content_instance, self)

	game_content = game_content_instance


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
	_after_pause()
	LogWrapper.debug(name, "Game paused.")


func _action_continue_menu_button() -> void:
	game_content.visible = true
	pause_menu.visible = false
	options_menu.visible = false
	get_tree().paused = false
	_after_unpause()
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
	game_content.process_mode = Node.PROCESS_MODE_DISABLED
	game_content.visible = true
	pause_menu.visible = false
	options_menu.visible = false
	get_tree().paused = false
	LogWrapper.debug(name, "Game leave.")

	self.process_mode = PROCESS_MODE_DISABLED
	Data.exit_save_file()
	_after_leave()
	SceneManagerWrapper.change_scene(scene, scene_manager_options_id)


func _action_quit_menu_button() -> void:
	get_tree().quit()


func _connect_signals() -> void:
	SignalBus.menu_button_pressed.connect(_on_menu_button_pressed)


func _on_menu_button_pressed(id: MenuButtonEnum.ID, _source: MenuButtonClass) -> void:
	_action_handler.handle_action("MenuButton", id, self)
