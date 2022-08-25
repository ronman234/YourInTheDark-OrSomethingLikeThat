extends ItemBase

class_name Hall

export(Array) var gen_pieces # HAVE 2 @ MINIMUM
var _iter : int = 0 
var rooms_complete : int
var is_complete : bool = false
var mansion
#var current_door
var doors : Array = []
var rooms : Array = []
var mansion_size : int = 1
func _ready() -> void:
	(get_node(bounds) as Area).connect("body_entered", self, "_on_body_entered")
	(get_node(bounds) as Area).connect("body_exited", self, "_on_body_exited")
	var has_room = false
	var has_hall = false
	var start : int = Master.get_game().random.randi_range(0,1)
	
	for i in range(0, gen_pieces.size()):
		var is_room := false
		var is_hall := false
		var current = gen_pieces[i]
		var p : Spatial = get_node((current as NodePath))
		var v = Master.get_game().random.randi_range(0,1)
		var obj
		var can_open := false
		var door = load("res://Prefabs/Door.tscn").instance()
		door.hall = self
		doors.append(door)
		mansion.doors.append(door)
		if i <= 1:
			if i == start:
				has_room = true
				is_room = true
			else:
				if _iter < mansion_size:
					has_hall = true
					is_hall = true
				else:
					is_room = true
					has_room = true
		else:
			if v == 0:
				is_room = true
			else:
				if has_hall == true or _iter >= mansion_size:
					is_room = true
				else:
					is_hall = true
		if is_room:
			var room = RoomSpawner.new()
			room.get_room().door = door
			obj = room
			can_open = true
			mansion.rooms.append(obj)
			rooms.append(obj)
			has_room = true
#			door.is_room = true
		if is_hall:
			var hall = Master.get_random_object(3)
			hall._iter = _iter + 1
			hall.mansion = mansion
			obj = hall
			can_open = false
			mansion.halls.append(obj)
		door.can_open = can_open
		door.corresponding_object = obj
		p.add_child(door)
		reparent(door, mansion.door_container)
		door.global_transform.origin = p.global_transform.origin
		door.global_transform.basis = p.global_transform.basis

func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("NEW MANSION HALL WHO DIS")
		mansion.current_hall = self
func _on_body_exited(body):
	if body.is_in_group("Player"):
		print("LEAVING HALL")
		print(self)
#		if mansion.current_hall != self:
		if is_complete == true: #  and body.is_in_group("Player")
			queue_free()
			print(mansion.doors)
			print("LOOP TIME:")
			var cull_array : Array = []
#			processed_array = mansion.doors
			for i in range(0, mansion.doors.size() - 1):
				var door = mansion.doors[i]
				if !is_instance_valid(door.hall):
					print("CANCELLED OMG NOT VALID")
					cull_array.append(door)
#					door.queue_free()
					print(str("DELETED ", door))
				if door.hall != mansion.current_hall:
					if door != mansion.current_door:
						cull_array.append(door)
#						door.queue_free()
					else:
						door.deactivate()
			for i in cull_array:
				mansion.doors.erase(i)
				i.queue_free()
#			mansion.doors = processed_array
