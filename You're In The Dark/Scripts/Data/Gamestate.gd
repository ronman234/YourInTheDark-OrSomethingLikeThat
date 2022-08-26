extends Node

class_name game_state

<<<<<<< HEAD
=======
# IMPORTANT DATA:
var score : int
var streak : int
var pictures : Array = []
# Local Data
>>>>>>> parent of bd7f08d (Added ghost effect)
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
<<<<<<< HEAD
	if current_location.type == current_location._type.ROOM:
		var complexity = current_location.room_complexity
		print(complexity)
=======
	var new_viewport = player.get_camera_view()
	var image = new_viewport.get_texture().get_data()
	image.flip_y()
	var image_data : Array = []
	image_data.append(image)
	roll += 1
#	var image_texture := ImageTexture.new()
#	image_texture.create_from_image((image as Image))
#	player.get_node("CanvasLayer/TextureRect").texture = image_texture
	if current_location.type == current_location._type.ROOM:
		var complexity = current_location.room_complexity
#		print(complexity)
>>>>>>> parent of bd7f08d (Added ghost effect)
		for i in current_location.items:
			i = (i as InteractiveItem)
			if i.satisfaction_table == i.current_table:
				current_location.items.erase(i)
				i.queue_free()
				room_score = room_score + 1
		if room_score >= complexity:
<<<<<<< HEAD
=======
			image_data.append(current_location.room_quality)
			pictures.append(image_data)
>>>>>>> parent of bd7f08d (Added ghost effect)
			current_location.door.activate()
			room_score = 0
			current_mansion.completed_rooms += 1
			current_mansion.ping()
<<<<<<< HEAD
=======
#			finish_mansion()
	
func finish_mansion():
	Master.load_scene("sell")
>>>>>>> parent of bd7f08d (Added ghost effect)
