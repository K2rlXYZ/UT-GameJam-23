extends Control


@export var scene_to_play: PackedScene

#@export var tutorial: Control
@export var settings: Control
#@export var credits: Control


func _on_play_button_pressed():
	
	$AnimationPlayer.play("play")
	
	#oota kuni cutscene läbi
#	get_tree().change_scene_to_packed(scene_to_play)

func _on_tutorial_button_pressed():
	pass # Replace with function body.

func _on_settings_button_pressed():
	settings.show()

func _on_credits_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	get_tree().quit()






