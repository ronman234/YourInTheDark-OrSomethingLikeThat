extends ItemBase

class_name InteractiveItem

export(NodePath) var area

var satisfaction_table : Table
var satisfaction_unit : int 
var current_table : Table
var current_unit : int
func _ready():
	add_to_group("Item")
