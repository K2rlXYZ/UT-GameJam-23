# THIS NODES PARENT SHOULD BE A TILEMAP

extends Node2D

var lst = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var tilemap = self.get_parent() as TileMap
	for cell_coords in tilemap.get_used_cells(0):
		lst.append(BetterTileData.new())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
