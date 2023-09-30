extends RigidBody2D


var blocks_under = 0


func _ready():
	blocks_under = len($Area2D.get_overlapping_bodies())
	if blocks_under <= 0:
		rumble()

func _on_area_2d_body_entered(body):
	blocks_under += 1
	
	await get_tree().create_timer(1).timeout
	freeze = true


func _on_area_2d_body_exited(body):
	blocks_under -= 1
	
	if blocks_under <= 0:
		rumble()

func rumble():
	#rumble_animation
	
	await get_tree().create_timer(2).timeout
	if blocks_under <= 0:
		collapse()

func collapse():
	freeze = false

