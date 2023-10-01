extends CharacterBody2D


var speed = 400000
var change = true


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var wait: bool = true


func _physics_process(delta):
	var player = get_tree().get_nodes_in_group("player")
	var player_position = player[0].get_position()
	if change:
		velocity = (player_position - position)*randf_range(1.8,2.5)
	if !change:
		velocity = (position - player_position)*randf_range(0.8,1.4)
		
	if player_position.distance_to(position) > 5000:
		queue_free()
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body is PlayerCharacter:
		$mole_attack.play()
		$Scream.play()
		body.shoved = true
		if randf() < 0.5:
			body.velocity.x += randf_range(2000,2500)
		else:
			body.velocity.x -= randf_range(2000,2500)
		body.velocity.y -= randf_range(300,900)
		var lambda = func(empty, bod):
			bod.velocity*=0.95
		var t = AlternateTimer.new()
		t.wait_time = 5*100
		t.one_shot=true
		t.millisecond_elapsed.connect(lambda.bind(body))
		self.add_child(t)
		change = false
		t.start()
		await t.timeout
		body.velocity.x = 0.0
		body.velocity.y = 0.0
		body.shoved = false


func _on_area_2d_2_body_entered(body):
	if body is PlayerCharacter:
		pass
