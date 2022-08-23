extends Spatial

#class_name Door

var corresponding_object
var spawn

var is_active : bool = false
var can_open : bool = true
func activate():
	spawn = corresponding_object
	add_child(spawn)
	if can_open:
		$AnimationPlayer.play("open")
		is_active = true
func deactivate():
	$AnimationPlayer.play("close")
#	can_open = false
