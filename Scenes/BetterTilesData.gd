# THIS NODES PARENT SHOULD BE A TILEMAP

class_name BetterTilesData

extends Node2D

@export var tilemap: TileMap

var lst = []

func check_for_collapse():
	for el in lst:
		var tile = el as BetterTileData
		if tile.unstable:
			pass

# Called when the node enters the scene tree for the first time.
func _ready():
	for cell_coords in tilemap.get_used_cells(0):
		lst.append(BetterTileData.new().construct(cell_coords))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	check_for_collapse()
