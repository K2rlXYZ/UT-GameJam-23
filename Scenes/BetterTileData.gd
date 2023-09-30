class_name BetterTileData

extends Node2D

var local_position: Vector2i
var durability: int
var unstable: bool

func construct(local_position: Vector2i, durability: int = 1, unstable: bool = false) -> BetterTileData:
	self.local_position = local_position
	self.durability = durability
	self.unstable = unstable
	return self
