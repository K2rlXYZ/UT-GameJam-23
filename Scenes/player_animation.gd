extends Node2D


@export var animation_player: AnimationPlayer
@export var lantern_on: bool = true

func _ready():
	set_lantern(lantern_on)

func play_mine_upward() -> void:
	animation_player.play("mine_upward")

func play_mine_forward() -> void:
	animation_player.play("mine_forward")

func play_idle() -> void:
	animation_player.play("idle")

func play_run() -> void:
	animation_player.play("run")
	

func play_jump() -> void:
	animation_player.play("jump")

func set_lantern(state: bool):
	$Torso/RightArm/flame/Lantern.enabled = state
	
func cancel_animation():
	pass

func turn_player():
	if Input.is_action_pressed("left"):
		get_parent().scale.x = -1
	else:
		get_parent().scale.x = 1

func last_animation() -> String:
	return animation_player.assigned_animation

func pickhitsound() -> void:
	$PickHitSound.play()
	
func StepSound1():
	$StepSound1.play()
	
func StepSound2():
	$StepSound2.play()
