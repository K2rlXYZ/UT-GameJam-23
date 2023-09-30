class_name SupportBeam

extends CharacterBody2D

@export var area: Area2D

var scan_range = 5
var weight = 1

func set_tiles_around_supported(supported: bool, tiles_data: BetterTilesData):
	var position_of_above_tile = self.position
	var tree = get_tree()
	var player = tree.get_nodes_in_group("player")[0]
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
			var tile = tiles_data.find_tile_by_coord(temp_local_coordinate)
			if tile != null:
				if not supported:
					tile.unstable = true
				tile.supported=supported
				
func after_ready(tiles_data):
	set_tiles_around_supported(true, tiles_data)

func _ready():
	pass
	
	

func _physics_process(delta):
	pass
	
	
