## Original File MIT License Copyright (c) 2024 TinyTakinTeller
##
## Holds menu scenes and manages their transitions (listens to menu button pressed signal).
##
## Uses (light) command pattern: (instead of if-else and switch/match statements uses action map)
## https://refactoring.guru/design-patterns/command
extends Control

var _current_menu: Control = null
var _menu_button_action_map: Dictionary = {}

@onready var main_menu: Control = %MainMenu
@onready var options_menu: Control = %OptionsMenu
@onready var credits_menu: Control = %CreditsMenu
@onready var save_files_menu: Control = %SaveFilesMenu


func _ready() -> void:
	_connect_signals()
	_toggle_menu(main_menu)
	_init_menu_button_action_map()


func _init_menu_button_action_map() -> void:
	_menu_button_action_map[MenuButtonEnum.ID.MAIN_MENU_PLAY] = _action_main_menu_play
	_menu_button_action_map[MenuButtonEnum.ID.MAIN_MENU_OPTIONS] = _action_main_menu_options
	_menu_button_action_map[MenuButtonEnum.ID.MAIN_MENU_CREDITS] = _action_main_menu_credits
	_menu_button_action_map[MenuButtonEnum.ID.MAIN_MENU_QUIT] = _action_main_menu_quit

	_menu_button_action_map[MenuButtonEnum.ID.OPTIONS_MENU_BACK] = _action_main_menu_back
	_menu_button_action_map[MenuButtonEnum.ID.CREDITS_MENU_BACK] = _action_main_menu_back
	_menu_button_action_map[MenuButtonEnum.ID.SAVE_FILES_MENU_BACK] = _action_main_menu_back


func _action_main_menu_play() -> void:
	_toggle_menu(save_files_menu)


func _action_main_menu_options() -> void:
	_toggle_menu(options_menu)


func _action_main_menu_credits() -> void:
	_toggle_menu(credits_menu)


func _action_main_menu_quit() -> void:
	get_tree().quit()


func _action_main_menu_back() -> void:
	_toggle_menu(main_menu)


func _toggle_menu(menu: Control) -> void:
	menu.visible = true
	if _current_menu != null:
		_current_menu.visible = false
	_current_menu = menu


func _connect_signals() -> void:
	SignalBus.menu_button_pressed.connect(_on_menu_button_pressed)


func _on_menu_button_pressed(id: MenuButtonEnum.ID, _source: MenuButtonClass) -> void:
	var action: Callable = _menu_button_action_map.get(id, _action_unknown)
	if action != _action_unknown:
		_log_action(id, action)
		action.call()


func _log_action(id: MenuButtonEnum.ID, action: Callable) -> void:
	Log.debug(
		(
			"%s: action for menu button ID '%s' called '%s'."
			% [name, MenuButtonEnum.ID.keys()[id], action]
		)
	)


static func _action_unknown() -> void:
	pass
