extends CharacterBody2D

@export var weight = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not self.get_parent() is CharacterBody2D:
		Physics.down_accel(self, self.weight, delta)
		move_and_slide()
