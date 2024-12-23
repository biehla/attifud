## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Manages video settings.
class_name ConfigurationVideo
extends Node

@onready var anti_alias: ConfigurationVideoAntiAliasMode = %ConfigurationVideoAntiAlias
@onready var display_mode: ConfigurationVideoDisplayMode = %ConfigurationVideoDisplayMode
@onready var fps_count: ConfigurationVideoFPSCount = %ConfigurationVideoFpsCount
@onready var fps_limit: ConfigurationVideoFPSLimit = %ConfigurationVideoFPSLimit
@onready var resolution: ConfigurationVideoResolution = %ConfigurationVideoResolution
@onready var vsync_mode: ConfigurationVideoVsyncMode = %ConfigurationVideoVsyncMode


func _ready() -> void:
	pass


func reset() -> void:
	ConfigStorageSettingsVideo.delete()
	anti_alias.load_anti_alias_mode()
	display_mode.load_display_mode()
	fps_count.load_fps_count()
	fps_limit.load_fps_limit()
	resolution.load_resolution()
	vsync_mode.load_vsync_mode()


func _reload_resolution(window_mode: DisplayServer.WindowMode) -> void:
	if window_mode == DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
		resolution.load_resolution()
