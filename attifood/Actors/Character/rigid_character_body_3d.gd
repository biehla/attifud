extends RigidBody3D

const TARGETSPEED = 5.0

var _pid := Pid3D.new(1.0, .1, 1.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var Direction = Vector3(
		Input.get_action_strength("Left") - Input.get_action_strength("Right"),
		0.0,
		Input.get_action_strength("Forward") - Input.get_action_strength("Backward")).normalized()
	var TargetVelocity = Direction * TARGETSPEED
	var VelocityError = TargetVelocity - linear_velocity
	var correction_impulse = _pid.update(VelocityError, delta) * 1
	apply_central_impulse(correction_impulse)
