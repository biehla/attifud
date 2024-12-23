## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Track FPS limit.
class_name ConfigurationVideoFPSLimit
extends Node

var options: LinkedMap


func _ready() -> void:
	_init_options()
	load_fps_limit()


func get_fps_limit() -> int:
	return Engine.max_fps


func get_saved_index() -> int:
	var fps_limit: int = ConfigStorageSettingsVideo.get_fps_limit_option_value()
	return options.find_key_index_by_value(fps_limit)


func get_option_index() -> int:
	var fps_limit: int = get_fps_limit()
	var index: int = options.find_key_index_by_value(fps_limit)
	if index == -1:
		index = get_saved_index()
	return index


func set_option_index(index: int) -> void:
	var fps_limit: int = options.get_value_at(index)
	_set_fps_limit(fps_limit)
	ConfigStorageSettingsVideo.set_fps_limit_option_value(fps_limit)


func load_fps_limit() -> void:
	var vsync_mode: int = ConfigStorageSettingsVideo.get_fps_limit_option_value()
	_set_fps_limit(vsync_mode)


func _set_fps_limit(fps_limit: int) -> void:
	if fps_limit != get_fps_limit():
		Engine.max_fps = fps_limit


func _init_options() -> void:
	options = LinkedMap.new()

	_init_option("LABEL_UNLIMITED", 0)
	for fps: int in [240, 200, 180, 165, 160, 144, 120, 100, 60, 30]:
		_init_option("%d FPS" % [fps], fps)


func _init_option(label: String, fps_limit: int) -> void:
	options.add(label, fps_limit)
