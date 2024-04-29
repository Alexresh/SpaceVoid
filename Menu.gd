extends Control

@onready var Options = $OptionsContainer
@onready var Menu = $MenuContainer


func _ready():
	visible = false
	Options.visible = false

func _on_resume_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	visible = !visible
	get_tree().paused = visible


func _on_exit_pressed():
	get_tree().quit()


func _on_check_button_toggled(toggled_on):
	if(toggled_on):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
	


func _on_options_pressed():
	switchScreens(Menu, Options)


func switchScreens(first, second):
	first.visible = false
	second.visible = true


func _on_options_back_button_pressed():
	switchScreens(Options, Menu)
