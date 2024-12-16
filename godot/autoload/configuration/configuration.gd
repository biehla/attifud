## Original File MIT License Copyright (c) 2024 TinyTakinTeller
extends Node

const GAME_TITLE: String = "GAME_TITLE"
const GAME_AUTHOR: String = "TinyTakinTeller"

@onready var configuration_locale: ConfigurationLocale = %ConfigurationLocale
@onready var configuration_logger: ConfigurationLogger = %ConfigurationLogger


func _ready() -> void:
	Log.debug("AUTOLOAD READY: ", name)

	ConfigManagerAppLog.app_opened()
