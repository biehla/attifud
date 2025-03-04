## Original File MIT License Copyright (c) 2024 TinyTakinTeller
extends Node

const GAME_TITLE: String = "GAME_TITLE"
const GAME_AUTHOR: String = "TinyTakinTeller"

const CUSTOM_THEME = preload("res://resources/global/theme/tres/theme.tres")

@onready var audio: ConfigurationAudio = %ConfigurationAudio
@onready var controls: ConfigurationControls = %ConfigurationControls
@onready var game: ConfigurationGame = %ConfigurationGame
@onready var locale: ConfigurationLocale = %ConfigurationLocale
@onready var logger: ConfigurationLogger = %ConfigurationLogger
@onready var video: ConfigurationVideo = %ConfigurationVideo


func _ready() -> void:
	ConfigStorageAppLog.app_opened()

	_set_custom_theme()

	LogWrapper.debug(self, "AUTOLOAD READY.")


# Alternative to the inconsistent custom theme: Project > Project Settings > GUI > Theme > Custom.
func _set_custom_theme() -> void:
	if CUSTOM_THEME == null:
		LogWrapper.warn(self, "Custom theme not found.")
		return
	get_tree().root.theme = CUSTOM_THEME
