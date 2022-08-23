extends ItemBase

class_name Hall

export(Array) var gen_pieces
#export(NodePath) var door
var _iter : int = 0

#export(NodePath) var Bounds 

func _ready():
#	(get_node(Bounds) as Area).connect("body_entered", self, "_on_Detection_body_entered")
	for i in gen_pieces:
		var p = get_node((i as NodePath))
		var v = Master.get_game().random.randi_range(0,1)
		var obj
		var door = load("res://Prefabs/Door.tscn").instance()
		if _iter <= 10:
			if v == 0:
				var room = RoomSpawner.new()
				room.get_room().door = door
				obj = room
			else:
				var hall = Master.get_random_object(3)
				hall._iter = _iter + 1
				obj = hall
		else:
			var room = RoomSpawner.new()
			obj = room
		door.corresponding_object = obj
		p.add_child(door)
		reparent(p, get_parent())
func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
