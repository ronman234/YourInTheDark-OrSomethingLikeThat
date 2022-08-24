extends Spatial

#class_name Door

var corresponding_object
var spawn = Spatial.new()
var hall : Hall
var is_active : bool = false
var can_open : bool = true
#var current_door = false
func _ready():
	add_child(spawn)
func activate():
	if can_open:
		spawn.add_child(corresponding_object)
		$AnimationPlayer.play("open")
		is_active = true
		print(str("MANSION DOOR PRE: ", hall.mansion.current_door))
		hall.mansion.current_door = self
		print(str("MANSION DOOR POST: ", hall.mansion.current_door))
func deactivate():
	$AnimationPlayer.play("close")
	corresponding_object = null
#	current_door = false
func get_content():
	return spawn.get_child(0)
