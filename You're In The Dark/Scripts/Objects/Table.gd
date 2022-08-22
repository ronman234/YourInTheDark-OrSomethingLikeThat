extends ItemBase

class_name Table

export var satisfaction_locations : Array = [] # For fitting items

func _ready():
	for loc in satisfaction_locations:
		get_node(loc).add_to_group("ItemSatisfier")
