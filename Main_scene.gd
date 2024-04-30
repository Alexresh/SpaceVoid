extends Node3D

@export var ExitBtn: Button

func _ready():
	ExitBtn.visible = false

func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			ExitBtn.visible = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			ExitBtn.visible = false
		


func _on_button_pressed():
	get_tree().quit(0)


func _on_area_3d_area_entered(area):
	pass # Replace with function body.
