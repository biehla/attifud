## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Base class for particle emitter components. Make sure to set: _sub_viewport, _particle.
## Emits child node [SubViewport] as particle, given particle_process_material_id.
## [br][br]
## Use start and stop functions from extending classes: e.g. [LabelParticleEmitter].
class_name ParticleEmitter
extends GPUParticles2D

@export_group("Options")
@export var particle_process_material_id: String = "":
	set(value):
		particle_process_material_id = value
		_set_particle()

@export_group("On Ready")
@export var ready_one_shot: bool = true
@export var ready_emitting: bool = false
@export var ready_amount: int = 1
@export var sub_viewport_x: int = 200
@export var sub_viewport_y: int = 200

var is_finished: bool = true

var _sub_viewport: SubViewport = null
var _particle: Control = null


# https://github.com/godotengine/godot/issues/65390
func _notification(what: int) -> void:
	if NOTIFICATION_PAUSED == what:
		self.interpolate = false
	elif NOTIFICATION_UNPAUSED == what:
		self.interpolate = true


func _process(_delta: float) -> void:
	if !is_visible_in_tree():
		stop()


func _ready() -> void:
	initialize()


func initialize() -> void:
	if _sub_viewport == null or _particle == null:
		push_error("Invalid setup: %s" % name)
		return

	_set_particle()

	_sub_viewport.size.x = sub_viewport_x
	_sub_viewport.size.y = sub_viewport_y
	self.one_shot = ready_one_shot
	self.emitting = ready_emitting
	self.amount = ready_amount

	self.finished.connect(_on_finished)


func start(arguments: Array) -> void:
	_on_start(arguments)
	is_finished = false
	_particle.visible = true
	self.emitting = true
	self.restart()


func stop() -> void:
	self.emitting = false
	_particle.visible = false


func set_particle_theme(theme: Resource) -> void:
	_particle.theme = theme


func set_particle_modulate(color: Color) -> void:
	if color != null and color != Color.BLACK:
		_particle.modulate = color


func _set_particle() -> void:
	var particle_process_material: ParticleProcessMaterial = (
		Reference.get_particle_process_material(particle_process_material_id)
	)
	if particle_process_material != null:
		self.process_material = particle_process_material


func _on_start(_arguments: Array) -> void:
	pass


func _on_finished() -> void:
	is_finished = true
