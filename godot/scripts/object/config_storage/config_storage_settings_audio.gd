## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name ConfigStorageSettingsAudio

const SETTINGS_AUDIO_SECTION: String = "SettingsAudio"

const MASTER_VOLUME_KEY: String = "MasterVolume"
const MUSIC_VOLUME_KEY: String = "MusicVolume"
const SFX_VOLUME_KEY: String = "SFXVolume"
const AUDIO_ENABLED_KEY: String = "AudioEnabled"

const DEFAULT_VOLUME: float = 50.0
const DEFAULT_ENABLED: bool = true


static func get_master_volume() -> float:
	return ConfigStorage.get_config(SETTINGS_AUDIO_SECTION, MASTER_VOLUME_KEY, DEFAULT_VOLUME)


static func get_music_volume() -> float:
	return ConfigStorage.get_config(SETTINGS_AUDIO_SECTION, MUSIC_VOLUME_KEY, DEFAULT_VOLUME)


static func get_sfx_volume() -> float:
	return ConfigStorage.get_config(SETTINGS_AUDIO_SECTION, SFX_VOLUME_KEY, DEFAULT_VOLUME)


static func get_audio_enabled() -> bool:
	return ConfigStorage.get_config(SETTINGS_AUDIO_SECTION, AUDIO_ENABLED_KEY, DEFAULT_ENABLED)


static func set_master_volume(volume: float) -> void:
	ConfigStorage.set_config(SETTINGS_AUDIO_SECTION, MASTER_VOLUME_KEY, volume)


static func set_music_volume(volume: float) -> void:
	ConfigStorage.set_config(SETTINGS_AUDIO_SECTION, MUSIC_VOLUME_KEY, volume)


static func set_sfx_volume(volume: float) -> void:
	ConfigStorage.set_config(SETTINGS_AUDIO_SECTION, SFX_VOLUME_KEY, volume)


static func set_audio_enabled(enabled: bool) -> void:
	ConfigStorage.set_config(SETTINGS_AUDIO_SECTION, AUDIO_ENABLED_KEY, enabled)


static func delete() -> void:
	ConfigStorage.erase_section(SETTINGS_AUDIO_SECTION)
