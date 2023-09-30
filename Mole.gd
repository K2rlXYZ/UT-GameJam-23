extends CharacterBody2D


var speed = 400000



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	var player = get_tree().get_nodes_in_group("player")
	var player_position = player[0].get_position()
	velocity = player_position - position
	move_and_slide()
