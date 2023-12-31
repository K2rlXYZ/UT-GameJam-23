# THIS NODES PARENT SHOULD BE A TILEMAP

class_name BetterTilesData

extends Node2D

@export var tilemap: TileMap

var lst: Array[BetterTileData] = []
var unsupported_lst: Array[BetterTileData] = []

func find_tile_by_coord(coord: Vector2i) -> BetterTileData:
	for el in self.lst:
		var tiledata = el as BetterTileData
		if tiledata.local_position == coord:
			return tiledata
	return null
	
func final_collapse_individual(position_for_particles):
	var final_collapse = preload("res://Scenes/Particles/final_collapse.tscn").instantiate()
	final_collapse.z_index = 10
	final_collapse.position = position_for_particles
	for child in final_collapse.get_children():
		child.emitting = true
	self.add_child(final_collapse)
	var t = Timer.new()
	t.set_wait_time(2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	await t.timeout
	self.remove_child(final_collapse)
	
func first_collapse(position_for_particles, start_tile_local_position):
	var cancel: bool = false
	if not $varisemine.playing:
		$varisemine.play()
	var first_collapse_particles = preload("res://Scenes/Particles/collapse_effect.tscn").instantiate() 
	var particles = first_collapse_particles.get_child(0) as GPUParticles2D
	first_collapse_particles.z_index = -10
	particles.emitting = true
	first_collapse_particles.position = position_for_particles
	self.add_child(first_collapse_particles)
	var t = AlternateTimer.new()
	t.wait_time = 4*1000
	t.one_shot=true
	self.add_child(t)
	var ck = (func(_e, stlp): 
		#print(Globals.cancelable_tile_index_pairs)
		#print(e)
		if (stlp in Globals.cancelable_tile_index_pairs.keys()):
			var data = Globals.cancelable_tile_index_pairs[stlp]
			#print(data[0])
			if data[0]:
				data[1].stop() 
	)
	t.millisecond_elapsed.connect(ck.bind(start_tile_local_position))
	t.start()
	Globals.cancelable_tile_index_pairs[start_tile_local_position].append(t)
	
	await t.timeout
	self.remove_child(first_collapse_particles)
	return cancel
	
func collapse(start_tile: BetterTileData):
	var position_for_particles = tilemap.to_global(tilemap.map_to_local(start_tile.local_position))
	Globals.cancelable_tile_index_pairs[start_tile.local_position] = [false]
	
	await first_collapse(position_for_particles, start_tile.local_position)
	if start_tile.local_position in Globals.cancelable_tile_index_pairs.keys():
		if Globals.cancelable_tile_index_pairs[start_tile.local_position][0]:
			Globals.cancelable_tile_index_pairs.erase(start_tile.local_position)
			if $varisemine.playing:
				$varisemine.stop()
			return
	else:
		if $varisemine.playing:
				$varisemine.stop()
		return
	
	var unstable_position = start_tile.local_position
	unstable_position.y+=1
	while true && unstable_position.y < 100:
		var unstb = find_tile_by_coord(unstable_position)
		if unstb == null:
			unstb=BetterTileData.new().construct(unstable_position)
			unstb.exists = true
			lst.append(unstb)
		else:
			if unstb.exists:
				break
		position_for_particles = tilemap.to_global(tilemap.map_to_local(unstable_position))
		final_collapse_individual(position_for_particles)
		tilemap.set_cell(0, unstable_position, 1, Vector2i(0, 0))
		unstable_position.y+=1

func check_for_collapse():
	for el in unsupported_lst:
		var tile = el as BetterTileData
		if tile.exists and tile.unstable and (not tile.supported):
			var temp_coord = tile.local_position
			temp_coord.y+=1
			var tile_temp = find_tile_by_coord(temp_coord)
			if tile_temp == null or not tile_temp.exists:
				collapse(tile)
			

# Called when the node enters the scene tree for the first time.
func _ready():
	for cell_coords in tilemap.get_used_cells(0):
		lst.append(BetterTileData.new().construct(cell_coords))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	pass

