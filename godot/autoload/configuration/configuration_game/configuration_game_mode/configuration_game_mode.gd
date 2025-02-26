## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Track game mode. (Represents index of active game content scene from "game_content_scenes".)
class_name ConfigurationGameMode
extends Node

@export var game_content_scenes: Array[PackedScene]

var options: LinkedMap

var game_content_scene: PackedScene


func _ready() -> void:
	_init_options()
	load_game_mode()


func get_game_mode() -> int:
	return ConfigStorageSettingsGame.get_game_mode_option_value()


func get_saved_index() -> int:
	var game_mode: int = ConfigStorageSettingsGame.get_game_mode_option_value()
	return options.find_key_index_by_value(game_mode)


func get_option_index() -> int:
	var game_mode: int = get_game_mode()
	var index: int = options.find_key_index_by_value(game_mode)
	if index == -1:
		index = get_saved_index()
	return index


func set_option_index(index: int) -> void:
	var game_mode: int = options.get_value_at(index)
	_set_game_mode(game_mode)
	ConfigStorageSettingsGame.set_game_mode_option_value(game_mode)


func load_game_mode() -> void:
	var game_mode: int = ConfigStorageSettingsGame.get_game_mode_option_value()
	_set_game_mode(game_mode)


func _set_game_mode(game_mode: int) -> void:
	game_content_scene = game_content_scenes[game_mode]


func _init_options() -> void:
	options = LinkedMap.new()

	_init_option(_get_option_name(0), 0)
	_init_option(_get_option_name(1), 1)
	_init_option(_get_option_name(2), 2)


func _init_option(label: String, game_mode: int) -> void:
	options.add(label, game_mode)


func _get_option_name(game_mode: int) -> String:
	return TranslationServerWrapper.translate("MENU_LABEL_GAME_MODE| " + str(game_mode))
