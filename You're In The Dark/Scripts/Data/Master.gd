extends Node

var game_instance : game_state

var scene_list : Dictionary = {
	"sandbox" : "res://SceneList/Debug.tres",
	"title" : "res://SceneList/Titlescreen.tres"
}

enum {SMALL, MEDIUM, LARGE}

var item_list : Dictionary = {
	"interior" : {
		"small" : ["ItemTest"],
		"medium" : [],
		"large" : []
	},
	"exterior" : {
		"small" : [],
		"medium" : [],
		"large" : []
	},
	"basement" : {
		"small" : [],
		"medium" : [],
		"large" : []
	},
}

var table_list : Dictionary = {
	"interior" : {
		"small" : ["TableTest"],
		"medium" : [],
		"large" : []
	},
	"exterior" : {
		"small" : [],
		"medium" : [],
		"large" : []
	},
	"basement" : {
		"small" : [],
		"medium" : [],
		"large" : []
	},
}

var room_list : Dictionary = {
	"interior" : {
		"small" : ["RoomTest", "RoomDual"],
		"medium" : [],
		"large" : []
	},
	"exterior" : {
		"small" : [],
		"medium" : [],
		"large" : []
	},
	"basement" : {
		"small" : [],
		"medium" : [],
		"large" : []
	},
}

func _ready() -> void:
	if game_instance == null:
		var new_game := game_state.new()
		game_instance = new_game
		add_child(new_game)
		load_scene("title")

func load_scene(scene : String) -> void:
	flush()
	var instance_scene : Scene = load(scene_list[scene])
	var instanced_scene : Node = instance_scene.scene_data.instance()
	game_instance.current_scene = instance_scene
	game_instance.add_child(instanced_scene)

func flush() -> void:
	for i in game_instance.get_children():
		(i as Node).queue_free()

func get_game() -> game_state:
	return game_instance

func get_random_object(type : int, room_size : int, location : int) -> ItemBase:
	var list : Array
	var ref_list
	var path_name : String
	match type:
		0:
			ref_list = item_list
			path_name = "Objects"
		1:
			ref_list = table_list
			path_name = "Tables"
		2:
			ref_list = room_list
			path_name = "Rooms"
	print(ref_list.values()[location].values()[room_size])
	list = ref_list.values()[location].values()[room_size]
	var item : ItemBase = load("res://Items/" + path_name + "/" + list[game_instance.random.randi_range(0, list.size() - 1)] + ".tscn").instance()
	return (item as ItemBase)
func get_item_list() -> Dictionary:
	return item_list
func get_table_list() -> Dictionary:
	return table_list
func get_room_list() -> Dictionary:
	return room_list
