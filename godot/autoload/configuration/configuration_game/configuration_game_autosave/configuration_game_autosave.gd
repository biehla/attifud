## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Manages game autosave option.
class_name ConfigurationGameAutosave
extends Node


func get_enabled() -> bool:
	return ConfigStorageSettingsGame.get_autosave_enabled()


func set_enabled(enabled: bool) -> void:
	ConfigStorageSettingsGame.set_autosave_enabled(enabled)


func load_autosave() -> void:
	pass  # No need for load logic because this is a pure flag managed directly by config.
