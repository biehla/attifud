## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name GameButton
extends TextureButton

const BRIGHTNESS_EFFECT: float = 0.25

var hovering: bool = false
var pressing: bool = false

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var click_counter: ClickCounter = %ClickCounter


func _ready() -> void:
	_connect_signals()
	_init_nodes()


func click() -> void:
	Data.game.coins += 1
	click_counter.click()


func max_click(clicks_per_second: int) -> void:
	Data.game.max_clicks_per_second = max(clicks_per_second, Data.game.max_clicks_per_second)
	animation_player.speed_scale = 1.0 + 1.0 * clicks_per_second


func _init_nodes() -> void:
	animation_player.play("float")


func _display_effect() -> void:
	if pressing:
		self.modulate.v = 1.0 - BRIGHTNESS_EFFECT
	elif hovering:
		self.modulate.v = 1.0  #+ BRIGHTNESS_EFFECT
	else:
		self.modulate.v = 1.0


func _connect_signals() -> void:
	self.mouse_entered.connect(_on_hover.bind(true))
	self.mouse_exited.connect(_on_hover.bind(false))
	self.button_down.connect(_on_button_down)
	self.button_up.connect(_on_button_up)
	SignalBus.clicks_per_second_updated.connect(_on_clicks_per_second_updated)


func _on_hover(hovered: bool) -> void:
	hovering = hovered
	_display_effect()


func _on_button_down() -> void:
	pressing = true
	_display_effect()
	click()


func _on_button_up() -> void:
	pressing = false
	_display_effect()


func _on_clicks_per_second_updated(clicks_per_second: int) -> void:
	max_click(clicks_per_second)
