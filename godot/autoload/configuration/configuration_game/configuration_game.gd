## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Manages game options.
class_name ConfigurationGame
extends Node


func _ready() -> void:
	pass


func get_autosave_enabled() -> bool:
	return ConfigStorageSettingsGame.get_autosave_enabled()


func set_autosave_enabled(enabled: bool) -> void:
	ConfigStorageSettingsGame.set_autosave_enabled(enabled)


func reset() -> void:
	ConfigStorageSettingsGame.delete()
