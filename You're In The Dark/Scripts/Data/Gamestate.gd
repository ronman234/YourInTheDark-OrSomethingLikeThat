extends Node

class_name game_state

var current_scene : Scene = null
var random : RandomNumberGenerator = RandomNumberGenerator.new()
var current_room : Room = null

func _ready() -> void:
	Master.game_instance = self
	random.randomize()

func flash() -> void:
	pass
