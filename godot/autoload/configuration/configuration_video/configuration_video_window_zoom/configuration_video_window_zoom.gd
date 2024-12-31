## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Manages window zoom on % scale.
class_name ConfigurationVideoWindowZoom
extends Node


func _ready() -> void:
	load_window_zoom()


func get_root_window() -> Window:
	return get_tree().get_root()


func get_window_zoom() -> float:
	return get_root_window().content_scale_factor * 100


func set_window_zoom(value: float) -> void:
	_set_window_zoom(value)
	ConfigStorageSettingsVideo.set_window_zoom(value)


func _set_window_zoom(value: float) -> void:
	get_root_window().content_scale_factor = value / 100


func load_window_zoom() -> void:
	var value: float = ConfigStorageSettingsVideo.get_window_zoom()
	_set_window_zoom(value)
