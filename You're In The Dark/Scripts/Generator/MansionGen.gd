extends Spatial

var room_quantity : int
var halls : Array = []
var rooms : Array = []
var doors : Array = []
var completed_rooms : int = 0
var current_hall
var current_door

var door_container := Spatial.new()
#var room_container := Spatial.new()
var hall_container := Spatial.new()

func _ready():
	add_child(door_container)
#	add_child(room_container)
	add_child(hall_container)
	Master.get_game().current_mansion = self
	var base = Master.get_random_object(3,0,0)
	base.mansion = self
	add_child(base)

func ping():
	print(str("Completed Rooms ", completed_rooms, "\n Room Size:", rooms.size()))
	if completed_rooms == current_hall.rooms.size():
		print("SUCCESS IN HALL!")
		current_hall.is_complete = true
		completed_rooms = 0
		for i in current_hall.doors:
			i.can_open = true
