extends CharacterBody2D


var speed = 1000
@onready var player = get_tree().get_nodes_in_group("player")
@onready var player_position = player[0].get_position()



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
	
	if global_position.distance_to(player_position) > 20:
		#var vect := (player_position-position).normalized()
		velocity.move_toward(player_position, speed)
	move_and_slide()
