extends ItemBase

func _ready():
	(get_node(bounds) as Area).connect("body_exited", self, "_on_body_exited")
func _on_body_exited(body : Node):
	if body.is_in_group("Player"):
		queue_free()
