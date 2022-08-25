extends Node

class_name game_state

var current_scene : Scene = null
var random : RandomNumberGenerator = RandomNumberGenerator.new()
var current_room : Room = null
var current_mansion
var room_score : int = 0
var current_health : int = 100
var current_money : int = 100
var current_film_rolls : int = 3
var is_dead : bool = false
var out_of_film : bool = false

func _ready() -> void:
	Master.game_instance = self
	random.randomize()

func flash(current_location : ItemBase, player : Player) -> void:
	if current_location.type == current_location._type.ROOM:
		var complexity = current_location.room_complexity
		print(complexity)
		for i in current_location.items:
			i = (i as InteractiveItem)
			if i.satisfaction_table == i.current_table:
				current_location.items.erase(i)
				i.queue_free()
				room_score = room_score + 1
		if room_score >= complexity:
			current_location.door.activate()
			room_score = 0
			current_mansion.completed_rooms += 1
			current_mansion.ping()
