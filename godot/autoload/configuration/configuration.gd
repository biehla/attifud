## Original File MIT License Copyright (c) 2024 TinyTakinTeller
extends Node

const GAME_TITLE: String = "GAME_TITLE"
const GAME_AUTHOR: String = "TinyTakinTeller"

@onready var audio: ConfigurationAudio = %ConfigurationAudio
@onready var controls: ConfigurationControls = %ConfigurationControls
@onready var game: ConfigurationGame = %ConfigurationGame
@onready var locale: ConfigurationLocale = %ConfigurationLocale
@onready var logger: ConfigurationLogger = %ConfigurationLogger
@onready var video: ConfigurationVideo = %ConfigurationVideo


func _ready() -> void:
	ConfigStorageAppLog.app_opened()

	LogWrapper.debug(self, "AUTOLOAD READY.")
