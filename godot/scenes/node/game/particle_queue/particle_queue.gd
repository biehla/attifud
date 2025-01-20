## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Set a scene extending [ParticleEmitter] to particle_emitter_pck.
## Manages queue of particle emitters and accepts tasks in form of their arguments.
## Use [func add_task(arguments: Array)] to send a new task to next available emitter in queue.
## NOTE: If you send too many tasks in a short time, the queue will grow large and could cause lag.
class_name ParticleQueue
extends Node2D

@export var particle_emitter_pck: PackedScene

@export_group("Buffer Options")
## If enabled: instead of sending tasks to queue right away, will sum and send them periodically.
@export var buffer: bool = false
## Queue is self-extending, but maximal number of emitters is limited by lifetime and buffer_time.
@export var buffer_time: float = 0.15
## Will sum only given indices of arguments. If not summed, uses first in buffer as representative.
@export var buffer_sum_arguments: Array[int] = []

@export_group("Queue Options")
## Delete [ParticleEmitter] child from [queue] once it finishes its animation instead of reusing it.
## NOTE: Seems to improve FPS when visiting Web version of the project via mobile phone browser.
@export var free_on_finished: bool = true
@export var delay_time: float = 0.1
@export var lifetime: float = 2
## If false, delay_time is not applied on the first element (if the queue is empty).
@export var delay_on_empty_queue: bool = false
## Treated as unlimited if set to 0.
## NOTE: You should try to adjust delay time and buffer time instead of setting a hard limit.
@export var max_queue_size: int = 0
## If false, will wait until queue slot is free and resume the task then.
@export var skip_on_max_queue_size: bool = false

@export_group("Particles Options")

## If empty, will set parent as target on _ready function.
@export var position_target: Node = null:
	set(value):
		position_target = value
		set_position_to_target.call_deferred()

## Adjust position relative to position target.
@export var position_offset: Vector2 = Vector2(0, 0):
	set(value):
		position_offset = value
		set_position_to_target.call_deferred()

@export var particles_theme: Theme = null:
	set(value):
		particles_theme = value
		_set_particles_theme()

@export var inherit_theme_on_empty: bool = true

@export var particles_modulate: Color = Color.BLACK:
	set(value):
		particles_modulate = value
		_set_particles_modulate()

@export var particles_id: String = "":
	set(value):
		particles_id = value
		_set_particles()

var _buffer: Array = []
var _tasks: Array = []
var _last_task: Array = []
var _on_max_queue_size: bool = false
var _queue_visible: bool = true

# Using Node instead of Node2D for [queue] to keep position "on a separate layer" from its parent.
@onready var queue: Node = %Queue
@onready var buffer_timer: Timer = %BufferTimer
@onready var delay_timer: Timer = %DelayTimer


# Since Node is used instead of Node2D for [queue], we need to manually propagate visibility.
func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED:
		if _queue_visible != is_visible_in_tree():
			_queue_visible = is_visible_in_tree()
			_set_particles_visibility()


func _ready() -> void:
	if particle_emitter_pck == null:
		LogWrapper.error(name, "Particle emitter not set.")
		return
	if particles_id == null:
		LogWrapper.error(name, "Particles ID not set.")
		return
	_set_particles()
	_set_particles_theme()
	_set_particles_modulate()

	_init_timers()
	_init_theme()
	_extend_queue()
	buffer_timer.timeout.connect(_on_buffer_timer_timeout)
	delay_timer.timeout.connect(_on_delay_timer_timeout)

	if buffer and buffer_sum_arguments.is_empty():
		LogWrapper.warn(name, "Using particle queue buffer with no sum arguments.")

	if position_target == null:
		position_target = get_parent()
	set_position_to_target.call_deferred()

	get_tree().get_root().size_changed.connect(_on_root_size_changed)


func set_position_to_target() -> void:
	if position_target == null:
		return
	if "global_position" in position_target:
		position = position_target.global_position
		if "size" in position_target:
			var offset_x: float = position_target.size.x * position_offset.x
			var offset_y: float = position_target.size.y * position_offset.y
			position += Vector2(offset_x, offset_y)
		_set_particles_position()


func add_task(arguments: Array) -> void:
	if buffer:
		buffer_task(arguments)
	else:
		add_queue_task(arguments)


func buffer_task(arguments: Array) -> void:
	if _buffer.is_empty():
		_buffer = arguments.duplicate(true)
		return

	for sum_index: int in buffer_sum_arguments:
		if _buffer[sum_index] is Dictionary:
			for key: Variant in _buffer[sum_index]:
				_buffer[sum_index][key] += arguments[sum_index][key]
		else:
			_buffer[sum_index] += arguments[sum_index]


func add_queue_task(arguments: Array) -> void:
	if delay_on_empty_queue:
		_tasks.append(arguments)
		delay_timer.start(delay_time)
	elif _last_task.is_empty():
		_last_task = arguments
		var success: bool = trigger_label_effect(arguments)
		if success:
			delay_timer.start(delay_time)
		elif not skip_on_max_queue_size:
			_tasks.append(arguments)
	else:
		_tasks.append(arguments)


func trigger_label_effect(arguments: Array) -> bool:
	for particle_emitter: ParticleEmitter in queue.get_children():
		if particle_emitter.is_finished:
			_start(particle_emitter, arguments)
			return true

	var new_particle_emitter: ParticleEmitter = _extend_queue()
	if new_particle_emitter == null:
		return false

	_start(new_particle_emitter, arguments)
	return true


func _start(particle_emitter: ParticleEmitter, arguments: Array) -> void:
	particle_emitter.start(arguments)


func _extend_queue() -> ParticleEmitter:
	var queue_size: int = queue.get_child_count()
	if max_queue_size != 0 and queue_size >= max_queue_size:
		if not _on_max_queue_size:
			_on_max_queue_size = true
			Log.warn("Max queue size reached.")
		return null

	var particle_emitter: ParticleEmitter = particle_emitter_pck.instantiate()
	particle_emitter.visible = false
	queue.add_child(particle_emitter)
	LogWrapper.debug(name, "Extended to %d particle emitters." % queue_size)

	particle_emitter.finished.connect(_on_task_finished.bind(particle_emitter))
	particle_emitter.set_particle_theme(particles_theme)
	particle_emitter.set_particle_modulate(particles_modulate)
	particle_emitter.particle_process_material_id = particles_id
	particle_emitter.lifetime = lifetime
	particle_emitter.position = position
	particle_emitter.visible = true
	return particle_emitter


func _on_buffer_timer_timeout() -> void:
	if _buffer.is_empty():
		return
	add_queue_task(_buffer)
	_buffer = []


func _on_delay_timer_timeout() -> void:
	if _tasks.is_empty():
		_last_task = []
		return
	var arguments: Array = _tasks.pop_front()
	_last_task = arguments
	var success: bool = trigger_label_effect(arguments)
	if not success and not skip_on_max_queue_size:
		_tasks.push_front(arguments)


func _on_task_finished(particle_emitter: ParticleEmitter) -> void:
	if free_on_finished:
		particle_emitter.queue_free.call_deferred()


func _init_timers() -> void:
	buffer_timer.wait_time = buffer_time
	delay_timer.wait_time = delay_time


func _init_theme() -> void:
	if inherit_theme_on_empty and particles_theme == null:
		particles_theme = ThemeUtils.get_inherited_theme(get_parent())


func _set_particles() -> void:
	if queue == null:
		queue = %Queue
	for particle_emitter: ParticleEmitter in queue.get_children():
		particle_emitter.set_particle(particles_id)


func _set_particles_theme() -> void:
	if queue == null:
		queue = %Queue
	for particle_emitter: ParticleEmitter in queue.get_children():
		particle_emitter.set_particle_theme(particles_theme)


func _set_particles_modulate() -> void:
	if queue == null:
		queue = %Queue
	if particles_modulate == Color.BLACK:
		return
	for particle_emitter: ParticleEmitter in queue.get_children():
		particle_emitter.set_particle_modulate(particles_modulate)


func _set_particles_position() -> void:
	if queue == null:
		queue = %Queue
	for particle_emitter: ParticleEmitter in queue.get_children():
		particle_emitter.position = position


func _set_particles_visibility() -> void:
	if queue == null:
		queue = %Queue
	for particle_emitter: ParticleEmitter in queue.get_children():
		particle_emitter.visible = _queue_visible


# Needed because [queue] is Node instead of Node2D, so it does not follow position from parents.
func _on_root_size_changed() -> void:
	set_position_to_target.call_deferred()
