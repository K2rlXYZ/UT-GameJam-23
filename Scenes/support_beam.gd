class_name SupportBeam

extends CharacterBody2D

@export var area: Area2D

var list_of_tile_indexes: Array[Vector2i] = []

var scan_range = 5
var weight = 1

func set_tiles_around_supported(supported: bool, tiles_data: BetterTilesData):
	if supported:
		var position_of_above_tile = self.position
		var tree = get_tree()
		var player = tree.get_nodes_in_group("player")[0]
		position_of_above_tile.y-=(150+50)
		var tilemap = tree.current_scene.get_children().filter(func(e): return e is TileMap)[0]
		var local_coordinate = tilemap.local_to_map(tilemap.to_local(position_of_above_tile)) as Vector2i
		var adjusted_local_coordinate = local_coordinate
		for x_add in range(-scan_range, scan_range+1):
			for y_add in range(-scan_range, scan_range+1):
				var temp_local_coordinate = adjusted_local_coordinate
				temp_local_coordinate.x+=x_add
				temp_local_coordinate.y+=y_add
				var tile = tiles_data.find_tile_by_coord(temp_local_coordinate)
				if tile != null:
					list_of_tile_indexes.append(tile.local_position)
					tile.supported=true
		for tile_local_coords in (Globals.cancelable_tile_index_pairs as Dictionary).keys():
			if tile_local_coords in self.list_of_tile_indexes:
				pass
	else:
		for el in Globals.support_beams:
			var beam = el as SupportBeam
			if beam != self:
				for el2 in beam.list_of_tile_indexes:
					var index = el2 as Vector2i
					if index in self.list_of_tile_indexes:
						self.list_of_tile_indexes.erase(index)
		for index in self.list_of_tile_indexes:
			#print(index)
			var tile = tiles_data.find_tile_by_coord(index)
			tile.supported = false
			tile.unstable = true
		Globals.check_for_collapse()
				
func after_ready(tiles_data):
	set_tiles_around_supported(true, tiles_data)

func _ready():
	pass
	
	

func _physics_process(delta):
	pass
	
	
