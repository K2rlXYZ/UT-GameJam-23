extends Node2D


@onready var animation_player = $AnimationPlayer

func play_idle():
	animation_player.play("idle")

func play_run():
	animation_player.play("run")
