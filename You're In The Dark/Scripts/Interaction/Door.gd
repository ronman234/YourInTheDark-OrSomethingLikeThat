extends Spatial

#class_name Door

var corresponding_object
var spawn

var is_active : bool = false

func activate():
#	get_tree().call_group("Door","deactivate", self)
	spawn = corresponding_object
	add_child(spawn)
	$AnimationPlayer.play("open")
	is_active = true
func deactivate():
	$AnimationPlayer.play("close")
