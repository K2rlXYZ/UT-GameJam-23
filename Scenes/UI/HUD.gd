extends CanvasLayer


@export var beams_label: Label
@export var ladders_label: Label

func set_beams(amount: int) -> void:
	beams_label.text = str(amount)

func set_ladders(amount: int) -> void:
	ladders_label.text = str(amount)
