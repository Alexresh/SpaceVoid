extends CharacterBody3D

const SPEED = 0.1
const CAMERA_VERTICAL_SENSIVITY = 0.1
const CAMERA_HORIZONTAL_SENSIVITY = 0.1
const ROTATION_SPEED = 0.05
const STABILIZE_SPEED = 0.005


@export var SpeedLabel: RichTextLabel
@export var FPS: RichTextLabel
@export var Move_player: AudioStreamPlayer
@export var MainNode: Node3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta):
	var action = false	
	if (Input.is_action_pressed("rotate_left")):
		rotate_object_local(Vector3(0,0,1), -ROTATION_SPEED)
		action = true
	if (Input.is_action_pressed("rotate_right")):
		rotate_object_local(Vector3(0,0,1), ROTATION_SPEED)
		action = true
	if (Input.is_action_pressed("down")):
		velocity += get_basis() * Vector3(0, -SPEED, 0)
		action = true
	if (Input.is_action_pressed("up")):
		velocity += get_basis() * Vector3(0, SPEED, 0)
		action = true
	if (Input.is_action_pressed("right")):
		velocity += get_basis() * Vector3(SPEED, 0, 0)
		action = true
	if (Input.is_action_pressed("left")):
		velocity += get_basis() * Vector3(-SPEED, 0, 0)
		action = true
	if (Input.is_action_pressed("forward")):
		velocity += get_basis() * Vector3(0, 0, -SPEED)
		action = true
	if (Input.is_action_pressed("backward")):
		velocity += get_basis() * Vector3(0, 0, SPEED)
		action = true
	if (Input.is_action_pressed("stop") && (velocity.length() <= 0.5)):
		velocity = Vector3.ZERO
		action = true
	if (Input.is_action_just_pressed("throw")):
		var Bolt = preload("res://bolt.tscn").instantiate()
		MainNode.add_child(Bolt)
		Bolt.set_position(get_position())
		Bolt.apply_force(-self.global_transform.basis.z * 10)
		Bolt.set_angular_velocity(Vector3(1, 1, 0))
	
	SpeedLabel.text = "Speed: " + str(velocity.length()).substr(0, 4)
	FPS.text = str(Engine.get_frames_per_second())
	
	if (action and  not Move_player.playing):
		Move_player.play(0)
	elif (not action and Move_player.playing):
		Move_player.stop()
	
	if move_and_slide():
		velocity *= -0.5
		
func _unhandled_input(event):
	
	if (event is InputEventMouseButton):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED) and (event is InputEventMouseMotion):
		rotate_object_local(Vector3(0, 1, 0), deg_to_rad(-event.relative.x * CAMERA_HORIZONTAL_SENSIVITY))
		rotate_object_local(Vector3(1, 0, 0), deg_to_rad(-event.relative.y * CAMERA_VERTICAL_SENSIVITY))
