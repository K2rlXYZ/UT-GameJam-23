# THIS NODES PARENT SHOULD BE A TILEMAP

class_name BetterTilesData

extends Node2D

var tilemap = self.get_parent() as TileMap

var lst = []

func check_tiles_under_in_proximity(local_position: Vector2i, range: int = 5):
	for i in range(-range, range+1):
		var changed_pos = local_position
		changed_pos.y+=1
		changed_pos.x+=i
		var result = tilemap.get_cell_source_id(0, changed_pos)
		if result == -1:
			pass
		else:
			pass
		

func check_for_collapse():
	for el in lst:
		var tile = el as BetterTileData
		if tile.unstable:
			check_tiles_under_in_proximity(tile.local_position)

# Called when the node enters the scene tree for the first time.
func _ready():
	for cell_coords in tilemap.get_used_cells(0):
		lst.append(BetterTileData.new().construct(cell_coords))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	check_for_collapse()
