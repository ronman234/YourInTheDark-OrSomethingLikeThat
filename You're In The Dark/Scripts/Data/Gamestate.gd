extends Node

class_name game_state

# IMPORTANT DATA:
var score : int = 0
var streak : int
var pictures : Array = []
var address = Address.new()
# Local Data
var current_scene : Scene = null
var random : RandomNumberGenerator = RandomNumberGenerator.new()
var current_room : Room = null
var current_mansion
var room_score : int = 0

# Player Data
var health : int = 100
var roll : int
var money : int

func _ready() -> void:
	Master.game_instance = self
	random.randomize()

func get_address_gen() -> Address:
	return address

func flash(current_location : ItemBase, player : Player) -> void:
	roll += 1
	var quality : int
	if current_location.type == current_location._type.ROOM:
		var complexity = current_location.room_complexity
		for i in current_location.items:
			i = (i as InteractiveItem)
			if i.satisfaction_table == i.current_table:
				current_location.items.erase(i)
				i.queue_free()
				room_score = room_score + 1
			
		if room_score >= complexity:
			quality = current_location.room_quality
#			pictures.append(image_data)
			current_location.door.activate()
			room_score = 0
			current_mansion.completed_rooms += 1
			current_mansion.ping()
			print(str("Score Before: ", score))
			score += (current_location.item_size + random.randi_range(1,3) * 32)
			print(str("Score After: ", score))
		else:
			quality = 0
#			pictures.append(image_data)
		var new_viewport = player.get_camera_view()
		var image = new_viewport.get_texture().get_data()
		image.flip_y()
		var image_data : Array = []
		image_data.append(image)
		image_data.append(quality)
		pictures.append(image_data)
func finish_mansion():
	Master.load_scene("sell")
