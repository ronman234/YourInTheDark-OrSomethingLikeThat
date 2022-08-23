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
#func deactivate(current_door):
#	if self == current_door:
#		pass
#	else:
#		if is_active == true:
#			print("SHOULD ABSOLUTRLEY BE DOING ANYTHIN")
#			spawn.queue_free()
#		else:
#			print("SHOULD NOT BE DOING ANYTHIN")
