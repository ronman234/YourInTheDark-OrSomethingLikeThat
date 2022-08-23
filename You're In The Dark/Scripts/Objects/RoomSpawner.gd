extends Spatial

class_name RoomSpawner

var room

func _init():
	var random = Master.get_game().random
	room = Master.get_random_object(2, random.randi_range(0,2), random.randi_range(0,2))
	add_child(room)
func get_room():
	return room
