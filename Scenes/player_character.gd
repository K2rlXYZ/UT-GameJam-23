extends CharacterBody2D

@export var movement_speed = 400*100
@export var weight = 1
@export var jump_speed = 5*100
@export var sprite: Sprite2D
@export var pickaxe: CharacterBody2D
@export var raycast: RayCast2D
@export var tiles_data: BetterTilesData

var number_of_supports = 4
var direction = true
var pickaxe_x_offset = 50
var in_air = false



func jump():
	velocity.y = -jump_speed*weight

# Get user input and do something with it
func movement(delta):
	Physics.down_accel(self, self.weight, delta)

	velocity.x = movement_speed * (Input.get_action_strength("right") - Input.get_action_strength("left")) * delta

	if Input.is_action_just_pressed("up") and not in_air:
		jump()
		in_air = true
		
	if is_on_floor():
		in_air = false
	else:
		in_air = true
		
	if Input.is_action_just_pressed("right"):
		sprite.set_flip_h(true)
		pickaxe.position.x = pickaxe_x_offset
	elif Input.is_action_just_pressed("left"):
		sprite.set_flip_h(false)
		pickaxe.position.x = -pickaxe_x_offset

	move_and_slide()
	
func pickup_support(support: SupportBeam):
	support.get_parent().remove_child(support)
	self.number_of_supports+=1
	
	
func place_support():
	if number_of_supports > 0:
		var prel = preload("res://Scenes/support_beam.tscn").instantiate()
		var player_position_adjusted_to_tilemap = self.position
		player_position_adjusted_to_tilemap.x = int(player_position_adjusted_to_tilemap.x/100)*100+50
		player_position_adjusted_to_tilemap.y = int(player_position_adjusted_to_tilemap.y/100)*100+50
		prel.position = player_position_adjusted_to_tilemap
		get_parent().add_child(prel)
		Globals.support_beams.append(prel)
		self.number_of_supports-=1
		
func place_or_pickup_support():
	for el in Globals.support_beams:
		var beam = el as SupportBeam
		var beam_area = beam.area as Area2D
		if self in beam_area.get_overlapping_bodies():
			pickup_support(beam)
			return
	if not in_air:
		place_support()

func mine():
	# Get vector from player towards mouse and limit its length
	var vect = get_global_mouse_position() - self.position
	vect = vect.limit_length(250)
	# Set the vector as raycasts target position and update the raycast
	raycast.target_position = vect
	raycast.force_raycast_update()
	if (raycast.is_colliding() && raycast.get_collider() is TileMap):
		var collision_point = raycast.get_collision_point() as Vector2
		var tilemap = raycast.get_collider() as TileMap
		#Get the local coordinates from the collision point
		var local_coordinate = tilemap.local_to_map(tilemap.to_local(collision_point+vect.limit_length(20))) as Vector2i
		#Get the target tiles BetterTileData
		var target_tile = tiles_data.lst.filter(func(e): return (e as BetterTileData).local_position == local_coordinate)[0] as BetterTileData
		if (target_tile.durability == 1):
			tilemap.erase_cell(0, local_coordinate)
			var above_target_tile_position = target_tile.local_position
			above_target_tile_position.y -= 1
			var tile_above_target_tile = tiles_data.lst.filter(func(e): \
				return (e as BetterTileData).local_position == above_target_tile_position \
			)[0] as BetterTileData
			tile_above_target_tile.unstable = true
		else:
			target_tile.durability -= 1
		

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	movement(delta)

func _input(event):
	if event is InputEventMouse:
		if event.is_action_pressed("clickLeft"):
			mine()
		if event.is_action_pressed("clickRight"):
			place_or_pickup_support()
			
			

