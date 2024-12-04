## Modified File MIT License Copyright (c) 2024 TinyTakinTeller
## Original File MIT License Copyright (c) 2022-present Marek Belski
class_name ConfigManager
extends Object

const CONFIG_FILE_NAME: String = "user_config"
const CONFIG_FILE_PATH: String = PathConsts.USER + CONFIG_FILE_NAME + ".cfg"

static var config_file: ConfigFile


static func _init() -> void:
	_load_config_file()


static func _load_config_file(create_on_not_found: bool = true) -> void:
	if config_file != null:
		return
	config_file = ConfigFile.new()
	var err_file_cant_open: int = config_file.load(CONFIG_FILE_PATH)
	if err_file_cant_open and create_on_not_found:
		_save_config_file()


static func _save_config_file() -> void:
	var save_error: int = config_file.save(CONFIG_FILE_PATH)
	if save_error:
		Log.err("Save config file failed with error ", save_error)


static func set_config(section: String, key: String, value: Variant) -> void:
	_load_config_file()
	config_file.set_value(section, key, value)
	_save_config_file()


static func get_config(section: String, key: String, default: Variant = null) -> Variant:
	_load_config_file()
	return config_file.get_value(section, key, default)


static func has_section(section: String) -> bool:
	_load_config_file()
	return config_file.has_section(section)


static func has_section_key(section: String, key: String) -> bool:
	_load_config_file()
	return config_file.has_section_key(section, key)


static func erase_section(section: String) -> void:
	if has_section(section):
		config_file.erase_section(section)
		_save_config_file()


static func erase_section_key(section: String, key: String) -> void:
	if has_section_key(section, key):
		config_file.erase_section_key(section, key)
		_save_config_file()


static func get_section_keys(section: String) -> PackedStringArray:
	_load_config_file()
	if config_file.has_section(section):
		return config_file.get_section_keys(section)
	return PackedStringArray()
