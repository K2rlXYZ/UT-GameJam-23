class_name SupportBeam

extends CharacterBody2D

@export var area: Area2D
@onready var tree = get_tree()
@onready var player = tree.get_nodes_in_group("player")[0]

var scan_range = 3
var weight = 1

func set_tiles_around_supported(supported: bool = false):
	var position_of_above_tile = self.position
	position_of_above_tile.y-=(150+50)
	var tilemap = tree.current_scene.get_children().filter(func(e): return e is TileMap)[0]
	var local_coordinate = tilemap.local_to_map(tilemap.to_local(position_of_above_tile)) as Vector2i
	var adjusted_local_coordinate = local_coordinate
	adjusted_local_coordinate.y+=3
	for x_add in range(-scan_range, scan_range+1):
		for y_add in range(-scan_range, scan_range+1):
			var temp_local_coordinate = adjusted_local_coordinate
			temp_local_coordinate.x+=x_add
			temp_local_coordinate.y+=y_add
			var tile = player.tiles_data.find_tile_by_coord(adjusted_local_coordinate)
			if tile != null:
				tile.supported=supported

func _ready():
	set_tiles_around_supported()
	
	

func _physics_process(delta):
	pass
	
	
