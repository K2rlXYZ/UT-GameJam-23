class_name PlayerCharacter

extends CharacterBody2D

@export var movement_speed = 400*100
@export var weight = 1
@export var jump_speed = 6*100
@export var sprite: Sprite2D
@export var pickaxe: CharacterBody2D
@export var raycast: RayCast2D
@export var tiles_data: BetterTilesData

var number_of_supports = 4
var direction = true
var pickaxe_x_offset = 50
var in_air = false
var jumped_on_wall = false
var shoved = false

var inventory = [0,0]


func jump():
	velocity.y = -jump_speed*weight

# Get user input and do something with it
func movement(delta):
	Physics.down_accel(self, self.weight, delta)
	
	if not shoved:
		velocity.x = movement_speed * (Input.get_action_strength("right") - Input.get_action_strength("left")) * delta
		
	if (Input.is_action_just_pressed("up") and not in_air):
		$PlayerAnimation.play_jump()
		jump()
		in_air = true
		
	elif Input.is_action_just_pressed("up") and self.is_on_wall() and not jumped_on_wall:
		$PlayerAnimation.play_jump()
		jump()
		jumped_on_wall = true
		
	if not is_on_wall():
		jumped_on_wall = false
		
	if is_on_floor():
		in_air = false
	else:
		in_air = true
		
	if Input.is_action_pressed("right"):
		#sprite.set_flip_h(true)
		$PlayerAnimation.scale.x = 1
		#pickaxe.position.x = pickaxe_x_offset
	elif Input.is_action_pressed("left"):
		#sprite.set_flip_h(false)
		$PlayerAnimation.scale.x = -1
		#pickaxe.position.x = -pickaxe_x_offset
	
		
	move_and_slide()
	
func pickup_support(support: SupportBeam):
	support.set_tiles_around_supported(false, tiles_data)
	Globals.support_beams.erase(support)
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
		prel.after_ready(tiles_data)
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
		var target_tile = tiles_data.find_tile_by_coord(local_coordinate)
		if (target_tile.durability == 1):
			var source_id := tilemap.get_cell_source_id(0, local_coordinate)
			var atlas_coord := tilemap.get_cell_atlas_coords(0, local_coordinate)
			var tile_data = tilemap.tile_set.get_source(source_id).get_tile_data(atlas_coord,0)
			var custom_data = tile_data.get_custom_data("obj")
			add_to_inventory(custom_data)
			tilemap.erase_cell(0, local_coordinate)
			$PlayerAnimation.destroy_rock(collision_point)
			$PlayerAnimation.pickhitsound()
			target_tile.exists = false
			var above_target_tile_position = target_tile.local_position
			above_target_tile_position.y -= 1
			var tile = tiles_data.find_tile_by_coord(above_target_tile_position)
			if tile != null:
				if tile.exists and not tile.supported:
					tile.unstable = true
		else:
			target_tile.durability -= 1
			
	Globals.check_for_collapse()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	movement(delta)
	animate()
	
func _input(event):
	if event is InputEventMouse:
		if event.is_action_pressed("clickLeft"):
			mine()
			if event.position.y > get_node("CollisionShape2D_PlayerCharacter").position.y:
				$PlayerAnimation.play_mine_upward()
			else:
				$PlayerAnimation.play_mine_forward()
		if event.is_action_pressed("clickRight"):
			place_or_pickup_support()
			
			
func animate() -> void:
	var player_animation = $PlayerAnimation
	if !is_on_floor():
		if player_animation.last_animation() == "jump": return
		player_animation.play_jump()
	elif velocity.x != 0:
		player_animation.play_run()
		$PlayerAnimation.run_effect()
	
	elif !($PlayerAnimation/AnimationPlayer.get_current_animation() == "mine_upward" \
		 or $PlayerAnimation/AnimationPlayer.get_current_animation() == "mine_forward"\
		 or $PlayerAnimation/AnimationPlayer.get_current_animation() == "jump"):
		player_animation.play_idle()
		player_animation.run_effect_stop()

func add_to_inventory(id):
	if id != null:
		if id.name == "Gold":
			inventory[0] += 1
		elif id.name == "Silver":
			inventory[1] += 1
		else:
			pass
