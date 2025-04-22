
########### TO DO ################
# make player not interact physically with objects in players sphere of influence. without a solution to this players can launch themselves picking up objects underneath them

extends CharacterBody3D
class_name Player

var Speed
const SprintSpeed = 10
const WalkSpeed = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = .002

@export_category("Camera")
@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var grabPoint = $Head/Camera3D/SpringArm3D/GrabPoint
@onready var grabPointRef = $Head/Camera3D/GrabRefPoint

@export_category("Holding Object")
@export var ThrowForce = 7.5
@export var FollowSpeed = 5.0
@export var FollowDistance = 2.5
@export var MaxDistanceFromCamera = 5.0
@export var DropBelowPlayer = false
@export var GroundRay: RayCast3D
var IsRotatingObject = false
var IsObjectHeld = false
var MouseX = 0.0
var MouseY = 0.0
var ZeroedVector3 = Vector3(0,0,0)
var HeldObjectCollisionLayers

@onready var interactRay = $Head/Camera3D/InteractRay
var heldObject: RigidBody3D

#mouse movement
func _ready() -> void:
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

#mouse movements
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		
		MouseX = -event.relative.x
		MouseY = -event.relative.y
		
		if IsRotatingObject == false: #mouse movements to rotate held object
			head.rotate_y(-event.relative.x * SENSITIVITY)
			camera.rotate_x(-event.relative.y * SENSITIVITY)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

#character movement physics	
func _physics_process(delta: float) -> void:
	
	RotationPressed()
	handle_holding_objects()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("Sprint") and is_on_floor():
		Speed = SprintSpeed
		
	else:
		Speed = WalkSpeed

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * Speed
			velocity.z = direction.z * Speed
		else:
			velocity.x = lerp(velocity.x, direction.x * Speed, delta * 10)
			velocity.z = lerp(velocity.z, direction.z * Speed, delta * 10)
	else:
		velocity.x = lerp(velocity.x, direction.x * Speed, delta * 3)
		velocity.z = lerp(velocity.z, direction.z * Speed, delta * 3)
	move_and_slide()

#character collision with rigidbodies

#holding object/interaction logic
func set_held_object(body):
	if body is RigidBody3D:
		heldObject = body
		HeldObjectCollisionLayers = heldObject.collision_layer
		IsObjectHeld = true
		$Head/Camera3D/SpringArm3D.add_excluded_object(heldObject)
		
			#set object collision to not interact with player while held
		heldObject.collision_layer = 2
		
func drop_held_object():
	var obj = heldObject
	var vec3 = Vector3(0,0,0)
	
	#set object collision to not interact with player while held
	heldObject.collision_layer = 1
	heldObject.collision_layer = HeldObjectCollisionLayers
	
	heldObject.angular_velocity = ZeroedVector3
	
	heldObject.collision_layer = HeldObjectCollisionLayers
	HeldObjectCollisionLayers = null
	$Head/Camera3D/SpringArm3D.remove_excluded_object(heldObject)
	obj.apply_central_impulse(vec3)
	heldObject = null
	IsObjectHeld = false
	grabPoint.transform = grabPointRef.transform
	TrackedPhysicsObjects()
	
func throw_held_object():
	var obj = heldObject
	drop_held_object()
	obj.apply_central_impulse(-camera.global_transform.basis.z * ThrowForce * .5)
	
func handle_holding_objects():
	if Input.is_action_just_pressed("RightClick"):
		if heldObject != null: throw_held_object()
	
	if Input.is_action_just_pressed("Interact"):
		if heldObject != null: drop_held_object()
		elif interactRay.is_colliding(): set_held_object(interactRay.get_collider())
	
	if heldObject != null and IsRotatingObject == false:
		var targetPos = grabPoint.global_transform.origin ##+ (camera.global_basis * Vector3(0, 0, -FollowDistance))
		var objectPos = heldObject.global_transform.origin
		var objectRot = $Head/Camera3D/SpringArm3D/GrabPoint.global_rotation
		heldObject.linear_velocity = (targetPos - objectPos) * FollowSpeed
		heldObject.global_rotation = objectRot 

		if heldObject.global_position.distance_to(camera.global_position) > MaxDistanceFromCamera:
			drop_held_object()
		
		if DropBelowPlayer && GroundRay.is_colliding():
			if GroundRay.get_collider() == heldObject: drop_held_object()
			
	if  heldObject != null and IsRotatingObject == true: #if rotation mode is on for held object -> rotation logic
		heldObject.global_position = grabPoint.global_position
		heldObject.global_rotate(Vector3(0,1,0),MouseX * SENSITIVITY)
		heldObject.rotate_object_local(Vector3(1,0,0),MouseY * SENSITIVITY) #object is rotated locally to match player rotation but rotated on the x value for world position to avoid weird axis movements
		heldObject.angular_velocity = ZeroedVector3
		MouseX = 0
		MouseY = 0
		$Head/Camera3D/SpringArm3D/GrabPoint.global_rotation = heldObject.global_rotation
			
			
		if DropBelowPlayer && GroundRay.is_colliding():
			if GroundRay.get_collider() == heldObject: drop_held_object()

func RotationPressed():
	if Input.is_action_pressed("Inspect") and IsObjectHeld == true:
		IsRotatingObject = true
	if Input.is_action_just_released("Inspect"):
		IsRotatingObject = false

func PlayerArmDistance():
	pass

func TrackedPhysicsObjects():
	#$CollisionShape3D.
	pass
