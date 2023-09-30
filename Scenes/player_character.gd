extends CharacterBody2D

@export var movement_speed = 400 



# Get user input and do something with it
func react_input(delta):
	velocity += Vector2.DOWN * 10.0 * delta

	velocity.x = movement_speed * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * delta

	if Input.is_action_just_pressed("ui_up"):
		velocity = Vector2.UP * 10.0

	move_and_collide(velocity)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	react_input(delta)
