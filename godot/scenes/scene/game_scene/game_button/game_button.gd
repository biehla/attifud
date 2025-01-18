## Original File MIT License Copyright (c) 2024 TinyTakinTeller
class_name GameButton
extends TextureButton

const BRIGHTNESS_EFFECT: float = 0.25

var hovering: bool = false
var pressing: bool = false

var _love_label: String

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var click_counter: ClickCounter = %ClickCounter
@onready var particle_queue: ParticleQueue = %ParticleQueue


func _ready() -> void:
	_connect_signals()
	_init_nodes()
	_refresh_label()


func click(coins_per_click: int = 1) -> void:
	Data.game.coins += coins_per_click
	click_counter.click()
	particle_queue.add_task(["+{n} %s" % _love_label, {"n": coins_per_click}])


func max_click(clicks_per_second: int) -> void:
	Data.game.max_clicks_per_second = max(clicks_per_second, Data.game.max_clicks_per_second)
	animation_player.speed_scale = 1.0 + 1.0 * clicks_per_second


func _init_nodes() -> void:
	animation_player.play("float")


func _refresh_label() -> void:
	_love_label = TranslationServerWrapper.translate("CONTEXT_ITEM_LOVE")


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
	SignalBus.language_changed.connect(_on_language_changed)


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


func _on_language_changed(_locale: String) -> void:
	_refresh_label()
