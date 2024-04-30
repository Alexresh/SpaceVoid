extends Node3D

@export var Menu: Control
@export var BaseGenerator : Node3D

const CONFIG_FILE = "user://config.json"

var config = {
	"fullscreen" : false
} 

func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Menu.visible = true
			get_tree().paused = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			Menu.visible = false


func setFullScreen(fullscreen):
	if(fullscreen):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		$CanvasLayer/Menu/OptionsContainer/Values/FullScreenCheck.button_pressed = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	config.fullscreen = fullscreen
	save_data()

func _on_ready():
	Input.warp_mouse(Vector2(0,0))
	read_data()
	setParameters()
	BaseGenerator.generate(20, 20)


func save_data():
	var file = FileAccess.open(CONFIG_FILE, FileAccess.WRITE)
	file.store_string(JSON.stringify(config))
	file.close()
	
func read_data():
	if(FileAccess.file_exists(CONFIG_FILE)):
		var file = FileAccess.open(CONFIG_FILE, FileAccess.READ)
		config = JSON.parse_string(file.get_as_text())
	else:
		save_data()
		
func setParameters():
	setFullScreen(config.fullscreen)
