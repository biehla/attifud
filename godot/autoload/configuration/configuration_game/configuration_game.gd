## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Manages game options.
class_name ConfigurationGame
extends Node

@onready var autosave: ConfigurationGameAutosave = $ConfigurationGameAutosave
@onready var number_format: ConfigurationGameNumberFormat = $ConfigurationGameNumberFormat
@onready var game_mode: ConfigurationGameMode = $ConfigurationGameMode


func _ready() -> void:
	pass


func reset() -> void:
	ConfigStorageSettingsGame.delete()
	autosave.load_autosave()
	number_format.load_number_format()
	game_mode.load_game_mode()
