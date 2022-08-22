extends ItemBase

class_name InteractiveItem

export(NodePath) var area

var satisfaction_table : Table
var satisfaction_unit : int 
func _ready():
	add_to_group("Item")
