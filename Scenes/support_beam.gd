extends CharacterBody2D

@export var player: CharacterBody2D

var weight = 1

func _ready():
	var player_position_adjusted_to_tilemap = player.position
	player_position_adjusted_to_tilemap.x = int(player_position_adjusted_to_tilemap.x/100)*100
	player_position_adjusted_to_tilemap.y = int(player_position_adjusted_to_tilemap.y/100)*100
	self.position = player_position_adjusted_to_tilemap
	

func _physics_process(delta):
	Physics.down_accel(self, self.weight, delta)
	move_and_slide()
	
	
