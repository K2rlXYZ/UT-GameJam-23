extends Node2D


@onready var animation_player = $AnimationPlayer

func play(animation: String) -> void:
	animation_player.play(animation)
