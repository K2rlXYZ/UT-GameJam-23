extends Node

var support_beams: Array = []

var cancelable_tile_index_pairs: Dictionary = {}

func check_for_collapse():
	var tilemap = get_tree().current_scene.get_children().filter(func(e): return e is TileMap)[0] as TileMap
	var better_tiles_data = tilemap.get_children().filter(func(e): return e is BetterTilesData)[0] as BetterTilesData
	better_tiles_data.check_for_collapse()
	
