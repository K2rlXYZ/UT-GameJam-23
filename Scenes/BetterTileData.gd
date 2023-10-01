class_name BetterTileData

extends Node2D

var local_position: Vector2i
var durability: int
var unstable: bool
var exists: bool
var supported: bool

func construct(_local_position: Vector2i, _durability: int = 1, _unstable: bool = false, _supported: bool = false) -> BetterTileData:
	self.local_position = _local_position
	self.durability = _durability
	self.unstable = _unstable
	self.exists = true
	return self
