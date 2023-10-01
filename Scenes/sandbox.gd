extends Node2D

@export var tiles_data: BetterTilesData
var timer: Timer
@export var end_conditions = [[15,0,0], [0,25,0]] # 15 gold or 25 silver

func win():
	# TODO: OSKAR!!!! MAKE WIN INVOLVED IN GAMEFLOW
	var win_screen = load("res://Scenes/UI/win_screen.tscn").instantiate()
	hud.add_child(win_screen)
	

func _check_win_conditions():
	var player = get_tree().get_nodes_in_group("player")[0] as PlayerCharacter
	if player.inventory[0] == end_conditions[0][0] or player.inventory[1] == end_conditions[1][1]:
		win()

func _enemy_timer_timeout():
	print("Mole Spawned")
	$mole_roar.play()
	$HyperVentilate.play()
	await get_tree().create_timer(randf_range(4,5.5)).timeout
	Globals.spawn_mole()
	timer.set_wait_time(randf_range(25, 40))
	timer.start()
	
var hud

# Called when the node enters the scene tree for the first time.
func _ready():
	var arr = [Vector2(135, 307),Vector2(632, 307),Vector2(1165, 207),Vector2(-201, 207),Vector2(1643, 107)]
	for i in arr:
		var prel = preload("res://Scenes/support_beam.tscn").instantiate()
		var position_adjusted_to_tilemap = i
		position_adjusted_to_tilemap.x = int(position_adjusted_to_tilemap.x/100)*100+50
		position_adjusted_to_tilemap.y = int((position_adjusted_to_tilemap.y-20)/100)*100+50
		prel.position = position_adjusted_to_tilemap
		Globals.support_beams.append(prel)
		self.add_child(prel)
		prel.after_ready(tiles_data)
	
	timer = Timer.new()
	timer.set_wait_time(randf_range(1, 2))
	timer.set_one_shot(true)
	self.add_child(timer)
	timer.timeout.connect(_enemy_timer_timeout)
	timer.start()
	
	var player = get_tree().get_nodes_in_group("player")[0] as PlayerCharacter
	player.mined.connect(_check_win_conditions)
	# spawn hud
	hud = load("res://Scenes/UI/hud.tscn").instantiate()
	add_child(hud)
	
	get_tree().get_nodes_in_group("player")[0].mined.connect(hud.set_mineral_amounts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEvent:
		if event.is_action_pressed("pause"):
			hud.pause_game()
