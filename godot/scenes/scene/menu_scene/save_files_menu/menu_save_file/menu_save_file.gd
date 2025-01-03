## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name MenuSaveFile
extends MarginContainer

signal save_file_button_pressed(index: int)

const NAME_TITLE: String = "MENU_NAME"
const TIME_TITLE: String = "GAME_OBJECTIVE_TIME"

var index: int = -1

@onready var name_title_label: Label = %NameTitleLabel
@onready var name_value_label: Label = %NameValueLabel

@onready var playtime_title_label: Label = %PlaytimeTitleLabel
@onready var playtime_time_label: Label = %PlaytimeTimeLabel
@onready var playtime_datetime_label: Label = %PlaytimeDatetimeLabel

@onready var save_file_button: Button = %SaveFileButton

@onready var buttons_margin_container: MarginContainer = %ButtonsMarginContainer
@onready var play_save_menu_button: MenuButtonClass = %PlaySaveMenuButton


func _ready() -> void:
	_connect_signals()
	_refresh_title_labels()
	buttons_margin_container.visible = false


func set_index(new_index: int) -> void:
	index = new_index


func set_value_labels(
	save_file_name: String, playtime_seconds: int, modified_at: Dictionary
) -> void:
	name_value_label.text = save_file_name
	playtime_time_label.text = DatetimeUtils.format_seconds(playtime_seconds)
	playtime_datetime_label.text = DatetimeUtils.format_datetime(modified_at, "{z}.{x}.{y} {h}:{m}")

	var never_played: bool = playtime_seconds == 0 or modified_at.is_empty()
	if never_played:
		playtime_time_label.text = "---------------"
		playtime_datetime_label.text = "-------------------------"


func _refresh_title_labels() -> void:
	name_title_label.text = TranslationServerWrapper.translate(NAME_TITLE)
	playtime_title_label.text = TranslationServerWrapper.translate(TIME_TITLE)


func _connect_signals() -> void:
	save_file_button.pressed.connect(_on_save_file_button_pressed)
	save_file_button.toggled.connect(_on_save_file_button_toggled)

	SignalBus.language_changed.connect(_on_language_changed)


func _on_save_file_button_pressed() -> void:
	save_file_button_pressed.emit(index)


func _on_save_file_button_toggled(toggled_on: bool) -> void:
	buttons_margin_container.visible = toggled_on
	if toggled_on:
		play_save_menu_button.grab_focus()


func _on_language_changed(_locale: String) -> void:
	_refresh_title_labels()
