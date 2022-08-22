extends Node

class_name game_state

var current_scene : Scene = null
var test_scene : Scene = preload("res://SceneList/Titlescreen.tres")
var random : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	Master.game_instance = self
	random.randomize()
