class_name SupportBeam

extends CharacterBody2D

@export var player: CharacterBody2D
@export var area: Area2D

var weight = 1

func _ready():
	var position_of_above_tile = self.position
	position_of_above_tile.y-=(150+50)
	var tilemap = get_tree().current_scene.get_children().filter(func(e): return e is TileMap)[0]
	var local_coordinate = tilemap.local_to_map(tilemap.to_local(position_of_above_tile)) as Vector2i
	
	

func _physics_process(delta):
	pass
	
	
