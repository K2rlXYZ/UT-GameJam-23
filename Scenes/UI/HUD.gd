extends CanvasLayer


@export var pause_menu: Control
@export var settings_menu: Control

@export var main_menu: PackedScene

@export var silver_label: Label
@export var gold_label: Label
@export var uranium_label: Label
@export var amethyst_label: Label
@export var diamond_label: Label
@export var blood_label: Label

@export var time_label: Label


func set_mineral_amounts(inventory):
	silver_label.text = str(inventory[0])
	gold_label.text = str(inventory[1])
	uranium_label.text = str(inventory[2])
	amethyst_label.text = str(inventory[3])
	diamond_label.text = str(inventory[4])
	blood_label.text = str(inventory[5])


func pause_game() -> void:
	pause_menu.show()
	get_tree().paused = true

func _unpause_game() -> void:
	pause_menu.hide()
	get_tree().paused = false

func _update_clock(_aijs, time_left = Globals.end_game_timer.time_left):
	time_label.text = str(time_left/1000)

func _on_resume_button_pressed():
	_unpause_game()


func _on_settings_button_pressed():
	settings_menu.show()


func _on_quit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu)


func _process(_delta):
	_update_clock(0)
