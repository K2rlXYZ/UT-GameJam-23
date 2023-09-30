class_name SupportBeam

extends CharacterBody2D

@export var player: PlayerCharacter
@export var area: Area2D

var scan_range = 3
var weight = 1

func set_tiles_above_unstable(unstable: bool = false):
	var position_of_above_tile = self.position
	position_of_above_tile.y-=(150+50)
	var tilemap = get_tree().current_scene.get_children().filter(func(e): return e is TileMap)[0]
	var local_coordinate = tilemap.local_to_map(tilemap.to_local(position_of_above_tile)) as Vector2i
	for i in range(-scan_range, scan_range+1):
		var adjusted_local_coordinate = local_coordinate
		adjusted_local_coordinate.x+=i
		for el in player.tiles_data.lst:
			var tile = el as BetterTileData
			if tile.local_position == adjusted_local_coordinate:
				tile.unstable = unstable

func _ready():
	set_tiles_above_unstable()
	
	

func _physics_process(delta):
	pass
	
	
