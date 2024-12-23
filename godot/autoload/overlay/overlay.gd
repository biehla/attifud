## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Container for global overlays.
extends Control

@onready var fps_counter_margin_container: MarginContainer = %FPSCounterMarginContainer
@onready var fps_counter_label: Label = %FPSCounterLabel


func _ready() -> void:
	for child: Node in get_children():
		if "visible" in child:
			child.visible = false


func _process(_delta: float) -> void:
	if fps_counter_margin_container.visible:
		var fps: int = int(Engine.get_frames_per_second())
		fps_counter_label.text = "%d FPS" % [fps]


func fps_counter_toggle(enabled: bool) -> void:
	fps_counter_margin_container.visible = enabled
