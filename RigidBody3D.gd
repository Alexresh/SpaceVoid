extends RigidBody3D

@export var collision: CollisionShape3D
@export var life_timer: Timer

var disabled = true

func _ready():
	life_timer.start(20)

func _process(delta):
	collision.set_disabled(disabled)

func _on_area_3d_area_exited(area):
	disabled = false
	
func _on_timer_2_timeout():
	queue_free()
