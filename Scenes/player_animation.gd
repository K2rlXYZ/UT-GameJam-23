extends Node2D


@export var animation_player: AnimationPlayer


func play_mine_upward() -> void:
	animation_player.play("mine_upward")

func play_mine_forward() -> void:
	animation_player.play("mine_forward")

func play_idle() -> void:
	animation_player.play("idle")

func play_run() -> void:
	animation_player.play("run")
