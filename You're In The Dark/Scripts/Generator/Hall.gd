extends ItemBase

class_name Hall

export(Array) var gen_pieces
#export(NodePath) var door
var _iter : int = 0
var rooms_complete : int
var is_complete : bool = false
var mansion
var doors : Array = []
var rooms : Array = []
#export(NodePath) var Bounds 

func _ready():
	(get_node(bounds) as Area).connect("body_entered", self, "_on_body_entered")
	(get_node(bounds) as Area).connect("body_exited", self, "_on_body_exited")
	var has_room = false
	for i in gen_pieces:
		var p = get_node((i as NodePath))
		var v = Master.get_game().random.randi_range(0,1)
		var obj
		var can_open := false
		var door = load("res://Prefabs/Door.tscn").instance()
		doors.append(door)
		if _iter <= 10:
			if v == 0:
				var room = RoomSpawner.new()
				room.get_room().door = door
				obj = room
				can_open = true
				mansion.rooms.append(obj)
				rooms.append(obj)
				has_room = true
			else:
				if has_room == true:
					var hall = Master.get_random_object(3)
					hall._iter = _iter + 1
					hall.mansion = mansion
					obj = hall
					can_open = false
					mansion.halls.append(obj)
				else:
					var room = RoomSpawner.new()
					room.get_room().door = door
					obj = room
					can_open = true
					mansion.rooms.append(obj)
					rooms.append(obj)
					has_room = true
		else:
			var room = RoomSpawner.new()
			room.get_room().door = door
			obj = room
			can_open = true
			mansion.rooms.append(obj)
			rooms.append(obj)
			has_room = true
		door.can_open = can_open
		door.corresponding_object = obj
		p.add_child(door)
		mansion.doors.append(door)
		reparent(p, get_parent())

func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
func _on_body_entered(body):
	if body.is_in_group("Player"):
		mansion.current_hall = self
		print("NEW MAINN HEHEH")
func _on_body_exited(body):
	if is_complete == true and body.is_in_group("Player"):
		queue_free()
