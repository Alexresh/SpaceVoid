extends Node3D

@export var Menu: Control


func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Menu.visible = true
			get_tree().paused = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			Menu.visible = false

var config = {
	"fullscreen" : false
} 


func _on_ready():
	Input.warp_mouse(Vector2(0,0))
