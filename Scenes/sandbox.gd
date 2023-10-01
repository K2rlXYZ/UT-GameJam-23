extends Node2D

@export var tiles_data: BetterTilesData
var timer: Timer

func _enemy_timer_timeout():
	print("Mole Spawned")
	$mole_roar.play()
	await get_tree().create_timer(randf_range(4,5.5)).timeout
	Globals.spawn_mole()
	timer.set_wait_time(randf_range(25, 40))
	timer.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	var arr = [Vector2(135.7413, 307.924),Vector2(632.2584, 307.9859),Vector2(1165.591, 207.924),Vector2(-201.076, 207.924),Vector2(1643.37, 107.924)]
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
