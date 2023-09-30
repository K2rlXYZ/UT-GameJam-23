extends CharacterBody2D

@export var movement_speed = 400 


# Get user input and do something with it
func react_input(delta):
	velocity.y += physics.gravity * delta

	velocity.x = movement_speed * (Input.get_action_strength("right") - Input.get_action_strength("left")) * delta

	if Input.is_action_just_pressed("up"):
		velocity.y = -100.0

	move_and_slide()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	react_input(delta)
