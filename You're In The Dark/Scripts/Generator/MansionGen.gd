extends Spatial

var room_quantity : int
var halls : Array = []
var rooms : Array = []
var doors : Array = []
var completed_rooms : int = 0
var current_hall
func _ready():

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
