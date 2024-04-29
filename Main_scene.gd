extends Node3D

@export var MenuContainer: VBoxContainer

func _ready():
	MenuContainer.visible = false

func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			MenuContainer.visible = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			MenuContainer.visible = false

func _on_resume_btn_pressed():
	MenuContainer.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_exit_button_pressed():
	get_tree().quit(0)
