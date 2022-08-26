extends Camera
onready var player = get_parent().get_parent().get_parent().get_parent()
func _physics_process(delta):
	self.global_transform.origin.x = player.global_transform.origin.x
	self.global_transform.origin.z = player.global_transform.origin.z
