extends Control


func _ready():
	$P/M/VB/Volume/VolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))


func _on_back_button_pressed():
	hide()



func _on_volume_slider_value_changed(value):
	var bus_name := "Master"
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)


func _on_fullscreen_check_box_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if button_pressed == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
