extends Node2D

@export var tiles_data: BetterTilesData


# Called when the node enters the scene tree for the first time.
func _ready():
	var arr = [Vector2(400, 372), Vector2(1672, 372), Vector2(1005, 372)]
	for i in arr:
		var prel = preload("res://Scenes/support_beam.tscn").instantiate()
		var player_position_adjusted_to_tilemap = i
		player_position_adjusted_to_tilemap.x = int(player_position_adjusted_to_tilemap.x/100)*100+50
		player_position_adjusted_to_tilemap.y = int(player_position_adjusted_to_tilemap.y/100)*100+50
		prel.position = player_position_adjusted_to_tilemap
		Globals.support_beams.append(prel)
		self.add_child(prel)
		prel.after_ready(tiles_data)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
