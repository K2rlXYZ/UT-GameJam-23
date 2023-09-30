extends Node2D

@export var gravity = 9.8*100

func down_accel(node: CharacterBody2D, weight, delta):
	node.velocity.y += weight * gravity * delta
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
