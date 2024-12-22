## Original File MIT License Copyright (c) 2024 TinyTakinTeller
extends Node

const GAME_TITLE: String = "GAME_TITLE"
const GAME_AUTHOR: String = "TinyTakinTeller"

@onready var audio: ConfigurationAudio = %ConfigurationAudio
@onready var locale: ConfigurationLocale = %ConfigurationLocale
@onready var logger: ConfigurationLogger = %ConfigurationLogger
@onready var video: ConfigurationVideo = %ConfigurationVideo


func _ready() -> void:
	Log.debug("AUTOLOAD READY: ", name)

	ConfigStorageAppLog.app_opened()
