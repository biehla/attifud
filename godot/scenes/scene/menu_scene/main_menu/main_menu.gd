## Original File MIT License Copyright (c) 2024 TinyTakinTeller
extends Control

const VERSION_PREFIX: String = "v"

@onready var title_label: Label = %TitleLabel
@onready var author_label: Label = %AuthorLabel
@onready var version_label: Label = %VersionLabel
@onready var quit_menu_button: MenuButtonClass = %QuitMenuButton
@onready var control_resize_text_font: ControlResizeTextFont = %ControlResizeTextFont


func _ready() -> void:
	Log.debug("VIEW SCENE READY: ", name)

	_connect_signals()
	_refresh_labels()

	if OS.has_feature("web"):
		quit_menu_button.visible = false


func _refresh_labels() -> void:
	title_label.text = TranslationServerWrapper.translate(Configuration.GAME_TITLE)
	author_label.text = Configuration.GAME_AUTHOR
	version_label.text = VERSION_PREFIX + ProjectSettings.get_setting("application/config/version")


func _connect_signals() -> void:
	SignalBus.language_changed.connect(_on_language_changed)


func _on_language_changed(_locale: String) -> void:
	_refresh_labels()
