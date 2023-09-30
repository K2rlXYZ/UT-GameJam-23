# THIS NODES PARENT SHOULD BE A TILEMAP

class_name BetterTilesData

extends Node2D

@export var tilemap: TileMap

var lst: Array[BetterTileData] = []

func find_tile_by_coord(coord: Vector2i) -> BetterTileData:
	for el in self.lst:
		var tiledata = el as BetterTileData
		if tiledata.local_position == coord:
			return tiledata
	return null
	
func collapse(start_tile: BetterTileData):
	var unstable_position = start_tile.local_position
	unstable_position.y+=1
	
	if not $varisemine.playing:
		$varisemine.play()
	var position_for_particles = tilemap.to_global(tilemap.map_to_local(start_tile.local_position))
	var first_collapse = preload("res://Scenes/Particles/collapse_effect.tscn").instantiate() 
	var particles = first_collapse.get_child(0) as GPUParticles2D
	particles.position = position_for_particles
	particles.emitting = true
	var t = Timer.new()
	t.set_wait_time(10)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	await t.timeout
	particles.emitting = true
	var final_collapse = preload("res://Scenes/Particles/collapse_effect.tscn").instantiate()
	for child in final_collapse.get_children():
		child.position = position_for_particles
		child.emitting = true
	# TODO: varisemine animation2 start
	t = Timer.new()
	t.set_wait_time(5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	await t.timeout
	for child in final_collapse.get_children():
		child.emitting = false
	
	while true:
		if find_tile_by_coord(unstable_position) == null:
			lst.append(BetterTileData.new().construct(unstable_position))
			find_tile_by_coord(unstable_position).exists = true
		else:
			if find_tile_by_coord(unstable_position).exists:
				break
		tilemap.set_cell(0, unstable_position, 1, Vector2i(0, 0))
		unstable_position.y+=1

func check_for_collapse():
	for el in lst:
		var tile = el as BetterTileData
		if tile.exists and tile.unstable and (not tile.supported):
			collapse(tile)
			

# Called when the node enters the scene tree for the first time.
func _ready():
	for cell_coords in tilemap.get_used_cells(0):
		lst.append(BetterTileData.new().construct(cell_coords))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
