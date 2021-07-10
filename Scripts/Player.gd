extends KinematicBody

onready var cam = $Camera

var speed = 6

var direction = Vector3()

remote func _set_pos(position):
	global_transform.origin = position

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		var movement = event.relative
		cam.rotation.x += -deg2rad(movement.y * GameRun.sensevity)
		cam.rotation.x = clamp(cam.rotation.x, deg2rad(-90), deg2rad(90))
		rotation.y += -deg2rad(movement.x * GameRun.sensevity)

func _physics_process(_delta):
	direction = Vector3()
	if Input.is_action_pressed("move_forwards"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_backwards"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_right"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_left"):
		direction += transform.basis.x
	
	direction = direction.normalized()
	
	move_and_slide(direction * speed, Vector3.UP)
