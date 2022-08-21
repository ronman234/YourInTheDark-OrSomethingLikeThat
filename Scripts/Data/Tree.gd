extends Node

var current_scene : Scene = null
var test_scene : Scene = preload("res://SceneList/Titlescreen.tres")
func load_scene(scene : Scene) -> void:
	flush()
	current_scene = scene
	var instanced_scene : Node = scene.scene_data.instance()
	add_child(instanced_scene)

func flush() -> void:
	for i in get_children():
		(i as Node).queue_free()

func _ready():
	load_scene(test_scene)
