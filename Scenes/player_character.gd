extends CharacterBody2D

@export var movement_speed = 400 

# Get user input and do something with it
func react_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	var velocity = input_direction * movement_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
