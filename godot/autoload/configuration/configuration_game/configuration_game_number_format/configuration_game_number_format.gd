## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Track number format. See [NumberUtils] for formatting methods.
class_name ConfigurationGameNumberFormat
extends Node

var options: LinkedMap


func _ready() -> void:
	_init_options()


func get_number_format() -> NumberUtils.NumberFormat:
	return ConfigStorageSettingsGame.get_number_format_option_value()


func get_option_index() -> int:
	var number_format: NumberUtils.NumberFormat = get_number_format()
	return options.find_key_index_by_value(number_format)


func set_option_index(index: int) -> void:
	var number_format: NumberUtils.NumberFormat = options.get_value_at(index)
	ConfigStorageSettingsGame.set_number_format_option_value(number_format)
	_set_number_format(number_format)


func load_number_format() -> void:
	var number_format: int = get_number_format()
	_set_number_format(number_format)


func _set_number_format(number_format: NumberUtils.NumberFormat) -> void:
	SignalBus.number_format_changed.emit(number_format)


func _init_options() -> void:
	options = LinkedMap.new()

	_init_option("NUMBER_FORMAT_STRING", NumberUtils.NumberFormat.STRING)
	_init_option("NUMBER_FORMAT_DIGITS", NumberUtils.NumberFormat.DIGITS)
	_init_option("NUMBER_FORMAT_METRIC", NumberUtils.NumberFormat.METRIC)
	_init_option("NUMBER_FORMAT_SCIENTIFIC", NumberUtils.NumberFormat.SCIENTIFIC)


func _init_option(label: String, number_format: NumberUtils.NumberFormat) -> void:
	label = label + "{0}: {0}" + NumberUtils.format(98765, number_format)
	label = label.format({"0": TranslationServerWrapper.LOCALE_LIST_SEPARATOR})
	options.add(label, number_format)
