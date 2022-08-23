extends ItemBase

class_name Table

export var satisfaction_locations : Array = [] # For fitting items

func _ready():
	for loc in range(0, satisfaction_locations.size()):
		var cur = get_node(satisfaction_locations[loc])
		cur.set_script(load("res://Scripts/Interaction/ItemSatisfier.gd"))
		cur.add_to_group("ItemSatisfier")
		cur.table = self
		cur.unit = loc
