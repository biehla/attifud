## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Keybinds track user modifications of the input map (default is considered the project settings).
class_name ConfigStorageSettingsControls

const SETTINGS_CONTROLS_SECTION: String = "SettingsControls"

const KEYBINDS_KEY: String = "Keybinds"

const DEFAULT_KEYBINDS: Dictionary = {}


static func get_keybinds() -> Dictionary:
	return ConfigStorage.get_config(SETTINGS_CONTROLS_SECTION, KEYBINDS_KEY, DEFAULT_KEYBINDS)


static func add_keybind(action: StringName, event: InputEvent) -> void:
	var keybinds: Dictionary = _set_keybind(action, event, true)
	ConfigStorage.set_config(SETTINGS_CONTROLS_SECTION, KEYBINDS_KEY, keybinds)


static func remove_keybind(action: StringName, event: InputEvent) -> void:
	var keybinds: Dictionary = _set_keybind(action, event, false)
	ConfigStorage.set_config(SETTINGS_CONTROLS_SECTION, KEYBINDS_KEY, keybinds)


static func delete() -> void:
	ConfigStorage.erase_section(SETTINGS_CONTROLS_SECTION)


static func _set_keybind(action: StringName, event: InputEvent, bind: bool) -> Dictionary:
	var keybinds: Dictionary = get_keybinds().duplicate(true)
	if not keybinds.has(action):
		var events: Dictionary = {}
		keybinds[action] = events
	if not keybinds[action].has(event):
		keybinds[action][event] = false
	keybinds[action][event] = bind
	return keybinds
