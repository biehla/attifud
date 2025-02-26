## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Manages window zoom on % scale.
class_name ConfigurationVideoWindowZoom
extends Node
# This class is responsible for saving, loading and applying option value (slider) of "window zoom".


# load and apply the saved option value at startup
func _ready() -> void:
	load_window_zoom()


# get current option value
func get_window_zoom() -> float:
	return _get_root_window().content_scale_factor * 100


# apply and save a new option value
func set_window_zoom(value: float) -> void:
	_set_window_zoom(value)
	ConfigStorageSettingsVideo.set_window_zoom(value)


# used to load and apply the saved option value
func load_window_zoom() -> void:
	var value: float = ConfigStorageSettingsVideo.get_window_zoom()
	_set_window_zoom(value)


# apply the given option value
func _set_window_zoom(value: float) -> void:
	_get_root_window().content_scale_factor = value / 100


# helper method to get the window
func _get_root_window() -> Window:
	return get_tree().get_root()
