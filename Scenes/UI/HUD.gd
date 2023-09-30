extends CanvasLayer


@export var beams_label: Label
@export var ladders_label: Label

@export var pause_menu: Control
@export var settings_menu: Control


func set_beams(amount: int) -> void:
	beams_label.text = str(amount)

func set_ladders(amount: int) -> void:
	ladders_label.text = str(amount)

func pause_game() -> void:
	pause_menu.show()
	get_tree().paused = true

func _unpause_game() -> void:
	pause_menu.hide()
	get_tree().paused = false


func _on_resume_button_pressed():
	_unpause_game()


func _on_settings_button_pressed():
	settings_menu.show()
