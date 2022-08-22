extends Spatial

class_name ItemBase

enum size {SMALL, MEDIUM, LARGE}
enum location {INTERIOR, EXTERIOR, BASEMENT}
export var id : String = ""
export(size) var item_size
export(location) var item_location
