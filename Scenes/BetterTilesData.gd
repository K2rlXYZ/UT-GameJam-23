# THIS NODES PARENT SHOULD BE A TILEMAP

class_name BetterTilesData

extends Node2D

@export var tilemap: TileMap

var lst = []

func find_tile_by_coord(coord: Vector2i) -> BetterTileData:
	for el in lst:
		var tiledata = el as BetterTileData
		if tiledata.local_position == coord:
			return tiledata
	return null
	
func collapse(start_tile: BetterTileData):
	var unstable_position = start_tile.local_position
	unstable_position.y+=1
	var depth_to_fall = 1
	while true:
		tilemap.set_cell(0, unstable_position, 1, Vector2i(0, 0))
		if find_tile_by_coord(unstable_position) != null:
			break
		unstable_position.y+=1

func check_for_collapse():
	for el in lst:
		var tile = el as BetterTileData
		if tile.unstable:
			collapse(tile)
			

# Called when the node enters the scene tree for the first time.
func _ready():
	for cell_coords in tilemap.get_used_cells(0):
		lst.append(BetterTileData.new().construct(cell_coords))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	check_for_collapse()
