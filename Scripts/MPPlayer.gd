extends KinematicBody

onready var cam = $Camera

var speed = 6
var mouse_sense = 1

var direction = Vector3()

func _ready():
	#hides the cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	#get mouse input for camera rotation
	if event is InputEventMouseMotion:
		rotation.y += deg2rad(-event.relative.x * mouse_sense)
		cam.rotation.x += deg2rad(-event.relative.y * mouse_sense)
		cam.rotation.x = clamp(cam.rotation.x, deg2rad(-90), deg2rad(90))

remote func _set_pos(position):
	global_transform.origin = position

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
	
	if direction != Vector3():
		if is_network_master():
			move_and_slide(direction * speed, Vector3.UP)
		rpc_unreliable("_set_pos", global_transform.origin)
