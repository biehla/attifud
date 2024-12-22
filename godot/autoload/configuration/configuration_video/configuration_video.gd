## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Manages video settings.
## - track display mode as options index
class_name ConfigurationVideo
extends Node

@onready var display_mode: ConfigurationVideoDisplayMode = %ConfigurationVideoDisplayMode


func _ready() -> void:
	pass

func reset() -> void:
	display_mode.reset()
