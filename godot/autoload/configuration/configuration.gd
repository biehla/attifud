## Original File MIT License Copyright (c) 2024 TinyTakinTeller
extends Node

const GAME_TITLE: String = "GAME_TITLE"
const GAME_AUTHOR: String = "TinyTakinTeller"

# Should be the same as in: Project > Project Settings > GUI > Theme > Custom.
const CUSTOM_THEME = preload("res://resources/global/theme/tres/theme.tres")

@onready var audio: ConfigurationAudio = %ConfigurationAudio
@onready var controls: ConfigurationControls = %ConfigurationControls
@onready var game: ConfigurationGame = %ConfigurationGame
@onready var locale: ConfigurationLocale = %ConfigurationLocale
@onready var logger: ConfigurationLogger = %ConfigurationLogger
@onready var video: ConfigurationVideo = %ConfigurationVideo


func _ready() -> void:
	ConfigStorageAppLog.app_opened()

	_verify_custom_theme()

	LogWrapper.debug(self, "AUTOLOAD READY.")


# Global theme is not exported when project is ran via scripts (CI/CD), so we fix that here.
func _verify_custom_theme() -> void:
	var custom_theme: Theme = ThemeDB.get_project_theme()
	if custom_theme == null:
		LogWrapper.warn(
			self, "Custom theme was not exported automatically, setting it on startup now."
		)
		get_tree().get_root().theme = CUSTOM_THEME
