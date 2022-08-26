extends Spatial

onready var prefix_label : MeshInstance = $Prefix
onready var suffix_label : MeshInstance = $Suffix

var current_address_name : String

export var prefixs : Array = [
	"Amicicide",
	"Pine",
	"Green",
	"Crescent",
	"Pleasant",
	"Unity",
	"Godot",
	"Linton",
	"Ralph",
	"Bell",
	"Trevor",
	"Lime",
	"Kensington",
	"Brackeys",
	"Poplin",
	"Campanile",
	"Martin",
	"Simon",
	"Murray",
	"Sandy",
	"Rodger",
	"Gray",
	"Blue",
	"Shadow",
	"Palm",
	"Elm",
	"Moonlight",
	"Warren",
	"Smith",
	"Benedict",
	"Hawthorne",
	"Dakota",
	"Stone",
	"Pleasent"
]

export var suffixs : Array = [
	"Road",
	"Rd.",
	"Street",
	"St.",
	"Valley",
	"Lane",
	"Blvd.",
	"Boulevard",
	"Avenue",
	"Drive",
	"Route",
	"Crossing",
	"Corner",
	"Park",
	"Lane",
	"Hollow",
	"Manor",
	"Heights",
	"Haven",
	"Hills",
	"Grove",

]

func generate_address_name():
	var rand : RandomNumberGenerator = Master.get_game().random
	var prefix_text : String = prefixs[rand.randi_range(0, prefixs.size() - 1)]
	var suffix_text : String = suffixs[rand.randi_range(0, suffixs.size() - 1)]
	prefix_label.mesh.text = prefix_text
	suffix_label.mesh.text = suffix_text
	$Prefix2.mesh.text = prefix_text
	$Suffix2.mesh.text = suffix_text
	
	current_address_name = str(prefix_text, " ", suffix_text)
	
	
func _ready():
	generate_address_name()


func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		generate_address_name()
