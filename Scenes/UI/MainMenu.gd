extends Control


@export var scene_to_play: PackedScene

#@export var tutorial: Control
@export var settings: Control
#@export var credits: Control

signal any_key()

func _ready():
	
	$M.size = Vector2(1920, 1080)
	
	$M/HB/PlayButton.connect("pressed", _on_play_button_pressed)
	$M/HB/TutorialButton.connect("pressed", _on_tutorial_button_pressed)
	$M/HB/SettingsButton.connect("pressed", _on_settings_button_pressed)
	$M/HB/ExitButton.connect("pressed", _on_exit_button_pressed)
	$MainMenu.play()

func _on_play_button_pressed():
	
	$AnimationPlayer.play("play")
	await $AnimationPlayer.animation_finished
	#oota kuni cutscene läbi
	
	$CanvasLayer/Tutorial.show()
	
	await any_key
	
	get_tree().change_scene_to_packed(scene_to_play)

func _on_tutorial_button_pressed():
	$CanvasLayer/Tutorial.show()
	await any_key
	$CanvasLayer/Tutorial.hide()


func _on_settings_button_pressed():
	settings.show()

func _on_credits_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	get_tree().quit()


func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if event.pressed:
			any_key.emit()
