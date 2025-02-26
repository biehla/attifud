## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Track FPS count enabled.
class_name ConfigurationVideoFPSCount
extends Node
# This class is responsible for saving, loading and applying option value (slider) of "window zoom".


# load and apply the saved option value at startup
func _ready() -> void:
	load_fps_count()


# get current option value
func is_fps_count_enabled() -> bool:
	return ConfigStorageSettingsVideo.get_fps_count_enabled()


# apply and save a new option value
func set_fps_count_enabled(enabled: bool) -> void:
	_set_fps_count_enabled(enabled)
	ConfigStorageSettingsVideo.set_fps_count_enabled(enabled)


# used to load and apply the saved option value
func load_fps_count() -> void:
	var enabled: bool = ConfigStorageSettingsVideo.get_fps_count_enabled()
	_set_fps_count_enabled(enabled)


# apply the given option value
func _set_fps_count_enabled(enabled: bool) -> void:
	Overlay.fps_counter_toggle(enabled)
