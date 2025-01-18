## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Extends logger [Log] plugin with log groups configuration, managed by [ConfigurationLogger].
## [br][br]
## TODO: Does not wrap all methods. Wrap other methods from original class if and when needed.
extends Node

const LOG_SOURCE_SEPARATOR: String = "."
const LOG_LEVEL_DISABLED: int = 9
const LOG_LEVEL_NONE: int = -1

var default_log_group: Log.LogLevel
var log_groups: Dictionary
var disable_debug_logs: bool = false


func debug(src: Variant, msg: String, values: Variant = null, src_suffix: String = "") -> void:
	if disable_debug_logs:
		return
	var src_name: String = _src_name(src)
	var source: String = _extract_log_group(src_name, src_suffix)
	var message: String = _prefix_message(msg, source)
	if _is_log_group_active(Log.LogLevel.DEBUG, source):
		Log.debug(message, values)


func info(src: Variant, msg: String, values: Variant = null, src_suffix: String = "") -> void:
	var src_name: String = _src_name(src)
	var source: String = _extract_log_group(src_name, src_suffix)
	var message: String = _prefix_message(msg, source)
	if _is_log_group_active(Log.LogLevel.INFO, source):
		Log.info(message, values)


func warn(src: Variant, msg: String, values: Variant = null, src_suffix: String = "") -> void:
	var src_name: String = _src_name(src)
	var source: String = _extract_log_group(src_name, src_suffix)
	var message: String = _prefix_message(msg, source)
	if _is_log_group_active(Log.LogLevel.WARN, source):
		Log.warn(message, values)


func error(src: Variant, msg: String, values: Variant = null, src_suffix: String = "") -> void:
	var src_name: String = _src_name(src)
	var source: String = _extract_log_group(src_name, src_suffix)
	var message: String = _prefix_message(msg, source)
	if _is_log_group_active(Log.LogLevel.ERROR, source):
		Log.error(message, values)


func _src_name(src: Variant) -> String:
	return src if src is String or src is StringName else src.name


func _extract_log_group(source_name: String, source: String) -> String:
	if source != "":
		return source_name + LOG_SOURCE_SEPARATOR + source
	return source_name


func _prefix_message(message: String, source_name: String) -> String:
	return "[%s] %s" % [source_name, message]


func _is_log_group_active(source_log_level: Log.LogLevel, source: String) -> bool:
	var key: String = source
	var value: int = log_groups.get(key, LOG_LEVEL_NONE)
	while value == LOG_LEVEL_NONE:
		if not key.contains(LOG_SOURCE_SEPARATOR):
			break
		key = key.split(LOG_SOURCE_SEPARATOR, 2)[0]
		value = log_groups.get(key, LOG_LEVEL_NONE)

	if value == LOG_LEVEL_DISABLED:
		return false

	var group_log_level: Log.LogLevel = (
		(value as Log.LogLevel) if value != LOG_LEVEL_NONE else default_log_group
	)

	return source_log_level >= group_log_level

## Commented lines not useful due to: https://github.com/godotengine/godot-proposals/issues/105
#
#func _extract_log_group2(source: String = "") -> String:
#	var skip_stack: int = 2
#	var stack: Array[Dictionary] = get_stack()
#	for index: int in range(stack.size() - 1, skip_stack - 1, -1):
#		var e: Dictionary = stack[index]
#		var stack_source_name: String = _stack_source_name(e["source"])
#		source += stack_source_name + LOG_SOURCE_SEPARATOR + e["function"] + LOG_SOURCE_SEPARATOR
#	return source.trim_suffix(LOG_SOURCE_SEPARATOR)
#
#
#func _stack_source_name(stack_source: String) -> String:
#	var packed_string_array: PackedStringArray = stack_source.split("/")
#	return packed_string_array[packed_string_array.size() - 1].trim_suffix(".gd")
