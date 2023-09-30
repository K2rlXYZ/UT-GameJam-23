extends CharacterBody2D


var speed = 400000
var change = true


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	var player = get_tree().get_nodes_in_group("player")
	var player_position = player[0].get_position()
	if change:
		velocity = player_position - position
	if!change:
		velocity = position - player_position
		
	if player_position.distance_to(position) > 2000:
		queue_free()
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body is PlayerCharacter:
		body.shoved = true
		body.velocity.x += 200000
		var t = Timer.new()
		t.set_wait_time(1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		#await t.timeout
		body.velocity.x -= 200000
		body.shoved = false
		change = false
