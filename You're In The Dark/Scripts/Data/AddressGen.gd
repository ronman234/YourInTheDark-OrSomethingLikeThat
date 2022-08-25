extends Node

class_name Address

enum {HOUSE_NUM, STREET_NAME, STREET_TYPE}

var address : Array = []

var prefixes : Array = [
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
	"Pleasent"
]

var suffixes : Array = [
	" Valley",
	" Route",
	" Crossing",
	"'s Corner",
	" Park",
	" Lane",
	" Hollow",
	" Manor",
	" Heights",
	"haven",
	" Hills",
	" Grove",
	"stone",
]

var road_signature : Array = [
	"Lane",
	"Blvd.",
	"Road",
	"Rd.",
	"Street",
	"St.",
	"Avenue",
	"Ave.",
	"Drive",
	"Dr.",
]

func generate_address_name():
	address.clear()
	var rand : RandomNumberGenerator = Master.get_game().random
	var prefix_text : String = (prefixes[rand.randi_range(0, prefixes.size() - 1)] as String)
	var suffix_text : String = suffixes[rand.randi_range(0, suffixes.size() - 1)]
	var road_type : String = road_signature[rand.randi_range(0, road_signature.size() - 1)]
	var address_number : int = rand.randi_range(112,9999)
	address = [address_number, str(prefix_text, suffix_text), road_type]
func get_address(as_string : bool = false):
	if as_string:
		var returned_string
		returned_string = str(address[HOUSE_NUM], " ", address[STREET_NAME], " ", address[STREET_TYPE])
		return returned_string
	else:
		return (address as Array)
