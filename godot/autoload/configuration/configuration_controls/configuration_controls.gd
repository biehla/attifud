## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Manages controls settings.
class_name ConfigurationControls
extends Node

@onready var keybinds: ConfigurationControlsKeybinds = %ConfigurationControlsKeybinds


func _ready() -> void:
	pass


func reset() -> void:
	ConfigStorageSettingsControls.delete()
	keybinds.load_keybinds()
