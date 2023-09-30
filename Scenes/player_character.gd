extends CharacterBody2D

@export var movement_speed = 400*100
@export var weight = 1
@export var jump_speed = 5*100
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
		self.get_children(true).filter(func(e): return e is Sprite2D)[0].set_flip_h(true)
		self.get_children(true).filter(func(e): return e is CharacterBody2D)[0].position.x = pickaxe_x_offset
	elif Input.is_action_just_pressed("left"):
		self.get_children(true).filter(func(e): return e is Sprite2D)[0].set_flip_h(false)
		self.get_children(true).filter(func(e): return e is CharacterBody2D)[0].position.x = -pickaxe_x_offset

	move_and_slide()

func mine():
	var vect = get_global_mouse_position() - self.position
	vect.limit_length(1000)
	var raycast = self.get_children(true).filter(func(e): return e is RayCast2D)[0] as RayCast2D
	raycast.target_position = vect
	if (raycast.is_colliding() && raycast.get_collider() is TileMap):
		var cp = raycast.get_collision_point() as Vector2
		var tilemap = raycast.get_collider() as TileMap
		var local_coord = tilemap.local_to_map(tilemap.to_local(cp+vect.limit_length(20))) as Vector2i
		tilemap.set_cell(0, local_coord, -1)
		tilemap.fix_invalid_tiles()
		tilemap.force_update(0)
		
		
func mine_test():
	if Input.is_action_just_pressed("clickLeft"):
		mine()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	movement(delta)
	mine_test()

