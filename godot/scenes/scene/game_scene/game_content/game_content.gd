## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name GameContent
extends Control

@onready var control_grab_focus: ControlGrabFocus = %ControlGrabFocus

func _ready() -> void:
	LogWrapper.debug(self, "Ready.")
