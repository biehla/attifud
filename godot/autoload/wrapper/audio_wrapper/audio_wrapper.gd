## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Wraps Resonance (Audio Manager) plugin: [MusicManager] [SoundManager]
## - uses enums instead of string names
## [br][br]
## TODO: Does not wrap all methods. Wrap other methods from original classes if and when needed.
extends Node


func _ready() -> void:
	Log.debug("AUTOLOAD READY: ", name)


func play_music(music: AudioEnum.Music, crossfade: float = 0.0) -> void:
	MusicManager.play(AudioEnum.MUSIC_BANK, AudioEnum.music_name(music), crossfade)


func play_sfx(sfx: AudioEnum.Sfx) -> void:
	SoundManager.play(AudioEnum.SOUND_BANK, AudioEnum.sfx_name(sfx))


func get_instance_poly_sfx(sfx: AudioEnum.Sfx) -> Variant:
	return SoundManager.instance_poly(AudioEnum.SOUND_BANK, AudioEnum.sfx_name(sfx))


func play_instance(instance: Variant) -> void:
	instance.trigger()
	instance.release(true)
