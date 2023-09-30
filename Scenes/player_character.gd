extends CharacterBody2D

@export var movement_speed = 400*100
@export var weight = 1
@export var jump_speed = 5*100
@export var sprite: Sprite2D
@export var pickaxe: CharacterBody2D
@export var raycast: RayCast2D
var direction = true
var pickaxe_x_offset = 50



func jump():
	velocity.y = -jump_speed*weight

# Get user input and do something with it
func movement(delta):
	Physics.down_accel(self, self.weight, delta)

	velocity.x = movement_speed * (Input.get_action_strength("right") - Input.get_action_strength("left")) * delta

	if Input.is_action_just_pressed("up"):
		jump()
		
	if Input.is_action_just_pressed("right"):
		sprite.set_flip_h(true)
		pickaxe.position.x = pickaxe_x_offset
	elif Input.is_action_just_pressed("left"):
		sprite.set_flip_h(false)
		pickaxe.position.x = -pickaxe_x_offset

	move_and_slide()

func mine():
	var vect = get_global_mouse_position() - self.position
	vect.limit_length(1000)
	raycast.target_position = vect
	raycast.force_raycast_update()
	if (raycast.is_colliding() && raycast.get_collider() is TileMap):
		var cp = raycast.get_collision_point() as Vector2
		var tilemap = raycast.get_collider() as TileMap
		var local_coord = tilemap.local_to_map(tilemap.to_local(cp+vect.limit_length(20))) as Vector2i
		tilemap.erase_cell(0, local_coord)

		
func mine_test():
	if Input.is_action_just_pressed("clickLeft"):
		mine()

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
