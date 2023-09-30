class_name BetterTileData

extends Node2D

var local_pos: Vector2i
var durability: int

func new(lp: Vector2i):
	self.local_pos = lp
	self.durability = 3
	return self
