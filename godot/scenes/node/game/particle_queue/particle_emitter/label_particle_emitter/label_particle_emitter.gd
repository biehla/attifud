## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Exteds [ParticleEmitter] and sets [Label] as particle scene with text formatted from arguments.
## [br][br]
## Function [func start(arguments: Array)] from extended class takes in the following arguments:
## - [0] is the base text to be set to label
## - [1] is the format dictionary to be applied to base text
## Example: arguments = ["+{n} Love", {"n": 10}] will set text to "+10 Love".
class_name LabelParticleEmitter
extends ParticleEmitter

@onready var sub_viewport: SubViewport = %SubViewport
@onready var particle: Control = %Particle

@onready var label: Label = %Label


func _ready() -> void:
	_sub_viewport = sub_viewport
	_particle = particle
	super.initialize()


func _on_start(arguments: Array) -> void:
	label.text = arguments[0].format(arguments[1])
