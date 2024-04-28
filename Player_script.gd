extends CharacterBody3D

const SPEED = 0.1
const CAMERA_VERTICAL_SENSIVITY = 0.1
const CAMERA_HORIZONTAL_SENSIVITY = 0.1
const ROTATION_SPEED = 0.05

@export var SpeedLabel: RichTextLabel
@export var FPS: RichTextLabel

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):	
	if (Input.is_action_pressed("rotate_left")):
		rotate_object_local(Vector3(0,0,1), -ROTATION_SPEED)
	if (Input.is_action_pressed("rotate_right")):
		rotate_object_local(Vector3(0,0,1), ROTATION_SPEED)
	if (Input.is_action_pressed("down")):
		velocity += get_basis() * Vector3(0, -SPEED, 0)
	if (Input.is_action_pressed("up")):
		velocity += get_basis() * Vector3(0, SPEED, 0)
	if (Input.is_action_pressed("right")):
		velocity += get_basis() * Vector3(SPEED, 0, 0)
	if (Input.is_action_pressed("left")):
		velocity += get_basis() * Vector3(-SPEED, 0, 0)
	if (Input.is_action_pressed("forward")):
		velocity += get_basis() * Vector3(0, 0, -SPEED)
	if (Input.is_action_pressed("backward")):
		velocity += get_basis() * Vector3(0, 0, SPEED)
	if (Input.is_action_pressed("stop") && (velocity.length() <= 0.5)):
		velocity = Vector3.ZERO
	SpeedLabel.text = "Speed: " + str(velocity.length()).substr(0, 4)
	FPS.text = str(Engine.get_frames_per_second())

	move_and_slide()
	
func _unhandled_input(event):
	
	if (event is InputEventMouseButton):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED) and (event is InputEventMouseMotion):
		rotate_object_local(Vector3(0, 1, 0), deg_to_rad(-event.relative.x * CAMERA_HORIZONTAL_SENSIVITY))
		rotate_object_local(Vector3(1, 0, 0), deg_to_rad(-event.relative.y * CAMERA_VERTICAL_SENSIVITY))
		#rotate(transform.basis.x.normalized(), -deg_to_rad(event.relative.y * CAMERA_VERTICAL_SENSIVITY)) # rotate around local axis
