extends Spatial

var room_quantity : int

func _ready():
	add_child(Master.get_random_object(3,0,0))
