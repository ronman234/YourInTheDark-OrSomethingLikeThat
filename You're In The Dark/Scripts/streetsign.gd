extends Spatial

onready var prefix_label : MeshInstance = $Prefix
onready var suffix_label : MeshInstance = $Suffix

func _ready():
	var addr = Master.get_game().get_address_gen().get_address()
	prefix_label.mesh.text = addr[Address.STREET_NAME]
	suffix_label.mesh.text = addr[Address.STREET_TYPE]
