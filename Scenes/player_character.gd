extends CharacterBody2D

@export var movement_speed = 400*100
@export var weight = 1

# Get user input and do something with it
func movement(delta):
	velocity.y += weight * Physics.gravity * delta

	velocity.x = movement_speed * (Input.get_action_strength("right") - Input.get_action_strength("left")) * delta

	if Input.is_action_just_pressed("up"):
		velocity.y = -Physics.gravity

	move_and_slide()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)
