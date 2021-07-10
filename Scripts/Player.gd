extends KinematicBody

var speed = 7
const ACCEL_DEFAULT = 7
const ACCEL_AIR = 1
onready var accel = ACCEL_DEFAULT
var gravity = 20
var jump = 10

var cam_accel = 40
var mouse_sense = 0.5
var snap

var direction = Vector3()
var velocity = Vector3()
var gravityVec = Vector3()
var movement = Vector3()

var currentWeapon = 1

onready var head = $Head
onready var camera = $Head/Camera
onready var gun1 = $Head/Hand/Gun1

func _ready():
	#hides the cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func weapon_select():
	if Input.is_action_just_pressed("slot1"):
		currentWeapon = 1
	elif Input.is_action_just_pressed("slot2"):
		currentWeapon = 2

	if currentWeapon == 1:
		gun1.visible = true
		gun1.shoot()
	else:
		gun1.visible = false

func _input(event):
	#get mouse input for camera rotation
	if event is InputEventMouseMotion:
		rotation.y += deg2rad(-event.relative.x * mouse_sense)
		head.rotation.x += deg2rad(-event.relative.y * mouse_sense)
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

func _process(delta):
	#camera physics interpolation to reduce physics jitter on high refresh-rate monitors
	if Engine.get_frames_per_second() > Engine.iterations_per_second:
		camera.set_as_toplevel(true)
		camera.global_transform.origin = camera.global_transform.origin.linear_interpolate(head.global_transform.origin, cam_accel * delta)
		camera.rotation.y = rotation.y
		camera.rotation.x = head.rotation.x
	else:
		camera.set_as_toplevel(false)
		camera.global_transform = head.global_transform
		
func _physics_process(delta):
	
	weapon_select()
	
	#get keyboard input
	direction = Vector3.ZERO
	var h_rot = global_transform.basis.get_euler().y
	var f_input = Input.get_action_strength("move_forwards") - Input.get_action_strength("move_backwards")
	var h_input = Input.get_action_strength("move_left") - Input.get_action_strength("move_right") 
	direction = Vector3(h_input, 0, f_input).rotated(Vector3.UP, h_rot).normalized()
	
	#jumping and gravity
	if is_on_floor():
		snap = -get_floor_normal()
		accel = ACCEL_DEFAULT
		gravityVec = Vector3.ZERO
	else:
		snap = Vector3.DOWN
		accel = ACCEL_AIR
		gravityVec += Vector3.DOWN * gravity * delta
		
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		snap = Vector3.ZERO
		gravityVec = Vector3.UP * jump
	
	#make it move
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	movement = velocity + gravityVec
	
	move_and_slide_with_snap(movement, snap, Vector3.UP)
