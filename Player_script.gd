extends CharacterBody3D

const SPEED = 0.1
const CAMERA_VERTICAL_SENSIVITY = 0.1
const CAMERA_HORIZONTAL_SENSIVITY = 0.1
const ROTATION_SPEED = 0.05

@export var SpeedBarHorizontalForward: TextureProgressBar
@export var SpeedBarHorizontalBackward: TextureProgressBar
@export var SpeedBarHorizontalRight: TextureProgressBar
@export var SpeedBarHorizontalLeft: TextureProgressBar
@export var SpeedBarHorizontalUp: TextureProgressBar
@export var SpeedBarHorizontalDown: TextureProgressBar
@export var Camera: Camera3D

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
	if(Input.is_action_pressed("zoom")):
		Camera.fov = lerp(Camera.fov, 10.0, 0.08)
	else:
		Camera.fov = lerp(Camera.fov, 75.0, 0.08)
		
		
	var horizontal_speed_forward = global_transform.basis.z.dot(velocity)#(transform.basis * get_real_velocity()).z
	var horizontal_speed_side = global_transform.basis.x.dot(velocity)#(transform.basis * get_real_velocity()).x
	var vertical_speed = -global_transform.basis.y.dot(velocity)
	
	SpeedBarHorizontalForward.value = horizontal_speed_forward if horizontal_speed_forward > 0 else 0
	SpeedBarHorizontalBackward.value = abs(horizontal_speed_forward) if horizontal_speed_forward < 0 else 0
	
	SpeedBarHorizontalRight.value = horizontal_speed_side if horizontal_speed_side > 0 else 0
	SpeedBarHorizontalLeft.value = abs(horizontal_speed_side) if horizontal_speed_side < 0 else 0
	
	SpeedBarHorizontalUp.value = vertical_speed if vertical_speed > 0 else 0
	SpeedBarHorizontalDown.value = abs(vertical_speed) if vertical_speed < 0 else 0
	
	
	FPS.text = str(Engine.get_frames_per_second())
	

	if(move_and_slide()):
		#вставить звук удара
		velocity = Vector3.ZERO
	
func _unhandled_input(event):
	
	if (event is InputEventMouseButton):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED) and (event is InputEventMouseMotion):
		rotate_object_local(Vector3(0, 1, 0), deg_to_rad(-event.relative.x * CAMERA_HORIZONTAL_SENSIVITY))
		rotate_object_local(Vector3(1, 0, 0), deg_to_rad(-event.relative.y * CAMERA_VERTICAL_SENSIVITY))
		#rotate(transform.basis.x.normalized(), -deg_to_rad(event.relative.y * CAMERA_VERTICAL_SENSIVITY)) # rotate around local axis
