class_name MineralResource

extends Resource

@export var name: String
@export var value: float
@export var weight: float

func _init():
	if name == "Gold":
		value = randf_range(100, 200)
		weight = randf_range(0.5, 2.5)
	if name == "Silver":
		value = randf_range(50, 120)
		weight = randf_range(0.8, 3.3)
