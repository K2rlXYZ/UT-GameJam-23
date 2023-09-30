class_name BetterTileData

extends Node2D

var local_position: Vector2i
var durability: int
var unstable: bool
var exists: bool
var supported: bool

func construct(local_position: Vector2i, durability: int = 1, unstable: bool = false, supported: bool = false) -> BetterTileData:
	self.local_position = local_position
	self.durability = durability
	self.unstable = unstable
	self.exists = true
	return self
