extends Spatial

class_name ItemBase

enum size {SMALL, MEDIUM, LARGE}
enum location {INTERIOR, EXTERIOR, BASEMENT}
export var id : String = ""
export(size) var item_size
export(location) var item_location
export (NodePath) var bounds
enum _type {
	ITEM, ROOM, TABLE, HALL
}
export(_type) var type 
func _ready() -> void:
	if type != _type.ITEM and type != _type.TABLE:
		(get_node(bounds) as Area).connect("body_entered", self, "_on_Detection_body_entered")

func _on_Detection_body_entered(body):
	if body.is_in_group("Player"):
		body.current_location = self
