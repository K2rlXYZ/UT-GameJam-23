class_name BetterTileData

extends Node2D

var local_pos: Vector2i
var durability: int

func neww(lp: Vector2i, dur: int = 1) -> BetterTileData:
	self.local_pos = lp
	self.durability = dur
	return self
