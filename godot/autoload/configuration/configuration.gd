extends Node


func _ready() -> void:
	Log.debug("AUTOLOAD READY: ", name)

	if OS.is_debug_build():
		_init_debug_configuration()
	else:
		_init_release_configuration()


func _init_debug_configuration() -> void:
	Log.current_log_level = Log.LogLevel.DEBUG


func _init_release_configuration() -> void:
	Log.current_log_level = Log.LogLevel.INFO
