extends Camera
export(bool) var is_gps = false
onready var player = get_parent().get_parent().get_parent().get_parent()
func _physics_process(delta):
	if is_gps:
		self.global_transform.origin.x = player.global_transform.origin.x
		self.global_transform.origin.z = player.global_transform.origin.z
	else:
		self.global_transform.origin = player.get_node("Head/Camera").global_transform.origin
		self.global_transform.basis = player.get_node("Head/Camera").global_transform.basis
