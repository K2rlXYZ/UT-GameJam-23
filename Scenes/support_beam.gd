class_name SupportBeam

extends CharacterBody2D

@export var player: CharacterBody2D
@export var area: Area2D

var weight = 1

func _ready():
	
	Globals.support_beams.append(self)
	

func _physics_process(delta):
	Physics.down_accel(self, self.weight, delta)
	move_and_slide()
	
	
