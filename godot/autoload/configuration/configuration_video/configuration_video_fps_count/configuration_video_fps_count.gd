## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Track FPS count enabled.
class_name ConfigurationVideoFPSCount
extends Node


func _ready() -> void:
	load_fps_count()


func is_fps_count_enabled() -> bool:
	return ConfigStorageSettingsVideo.get_fps_count_enabled()


func set_fps_count_enabled(enabled: bool) -> void:
	_set_fps_count_enabled(enabled)
	ConfigStorageSettingsVideo.set_fps_count_enabled(enabled)


func load_fps_count() -> void:
	var enabled: bool = ConfigStorageSettingsVideo.get_fps_count_enabled()
	_set_fps_count_enabled(enabled)


func _set_fps_count_enabled(enabled: bool) -> void:
	Overlay.fps_counter_toggle(enabled)
