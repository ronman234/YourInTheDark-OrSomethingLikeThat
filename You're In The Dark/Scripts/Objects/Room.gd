extends ItemBase

class_name Location_Room

export var table_spawners : Array = [] # Nest Arrays, [obj, size]
var room_quality : int
var room_complexity : int
export var item_spawners : Array = []

var spawn_piece : RoomSpawner

var items : Array = []
var tables : Array = []
var door
func _ready() -> void:
	room_quality = (item_spawners.size() + item_size) * Master.get_game().random.randi_range(2,4)
	populate_room()
	(get_node(bounds) as Area).connect("body_entered", self, "_on_body_entered")
	(get_node(bounds) as Area).connect("body_exited", self, "_on_body_exited")
	room_complexity = table_spawners.size()
func populate_room(which : int = -1) -> void:
	var table = false
	var item = false
	if which == -1:
		table = true
		item = true
	if which == 0:
		item = true
	if which == 1:
		table = true
	if item:
		for i in item_spawners:
			var new_item : InteractiveItem = Master.get_random_object(0, item_size, item_location)
			get_node(i).add_child(new_item)
			items.append(new_item)
	if table:
		for i in table_spawners:
			var new_item : Table = Master.get_random_object(1, item_size, item_location)
			get_node(i[0]).add_child(new_item)
			tables.append(new_item)
	set_targets()
func set_targets() -> void:
	for i in items:
		var set_table : Table = tables[Master.get_game().random.randi_range(0, tables.size() - 1)]
		(i as InteractiveItem).satisfaction_table = set_table
		(i as InteractiveItem).satisfaction_unit = Master.get_game().random.randi_range(0, set_table.satisfaction_locations.size() - 1)
func _on_body_entered(body):
	if body.is_in_group("Player"):
		door.deactivate()
func _on_body_exited(body):
	if body.is_in_group("Player"):
		door.deactivate()
		self.queue_free()
