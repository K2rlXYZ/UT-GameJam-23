extends Node

var support_beams: Array = []

var cancelable_tile_index_pairs: Dictionary = {}

var end_game_timer: AlternateTimer

func _end_game():
	print("Game Over")
	var end_screen = load("res://Scenes/UI/end_screen.tscn").instantiate()
	
	var lvl = get_tree().current_scene
	var hud = lvl.get_node("HUD")
	hud.time_label.text = "Survived " + str(end_game_timer.elapsed / 1000) + " seconds"
	lvl.remove_child(hud)
	lvl.queue_free()
	get_tree().root.add_child(hud)
	hud.add_child(end_screen)
	hud.move_child(end_screen, 0)
	get_tree().current_scene = hud
	
	end_game_timer.stop()
	

func _ready():
	end_game_timer = AlternateTimer.new()
	end_game_timer.autostart = false
	end_game_timer.one_shot = true
	end_game_timer.wait_time = 300 * 1000
	add_child(end_game_timer)

func check_for_collapse():
	var tilemap = get_tree().current_scene.get_children().filter(func(e): return e is TileMap)[0] as TileMap
	var better_tiles_data = tilemap.get_children().filter(func(e): return e is BetterTilesData)[0] as BetterTilesData
	better_tiles_data.check_for_collapse()
	
func spawn_mole():
	var mole = preload("res://Scenes/mole.tscn").instantiate()
	var tree = get_tree()
	var player = tree.get_nodes_in_group("player")[0] as PlayerCharacter
	if randf() < 0.5:
		mole.position = Vector2(player.position.x+randf_range(2000,2500), player.position.y+randf_range(-900,900))
	else:
		mole.position = Vector2(player.position.x-randf_range(2000,2500), player.position.y+randf_range(-900,900))
	get_tree().current_scene.add_child(mole)
	
