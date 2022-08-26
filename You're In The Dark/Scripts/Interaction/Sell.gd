extends Control

onready var image_list = get_node("%ImageList")

# VALUES:
onready var address_val = get_node("%VALMansion")
onready var filmloss = get_node("%VALFilmLoss")
onready var images_value = get_node("%VALImage")
onready var health_value = get_node("%VALHealth")
onready var mansion_size = get_node("%VALRoomCom")
onready var film_ruined = get_node("%VALWasted")
func _ready() -> void:
	address_val.text = Master.get_game().get_address_gen().get_address(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	generate_images()
	calculate_total()

func generate_images() -> void:
	var image_data : Array
	image_data = Master.get_game().pictures
	for entry in image_data:
		var image : Image = entry[0]
		var score : int = entry[1]
		var image_texture := ImageTexture.new()
		image_texture.create_from_image((image as Image))
		var item : VBoxContainer = VBoxContainer.new()
		var texture : TextureRect = TextureRect.new()
		var score_record : Label = Label.new()
		if score <= 0:
			var ghost = load("res://assets/ghosts/ghosttest.tscn").instance()
			texture.add_child(ghost)
		texture.rect_min_size = Vector2(128,64)
		texture.texture = image_texture
		score_record.text = str("Value: ", score)
		item.add_child(texture)
		item.add_child(score_record)
		image_list.add_child(item)

func calculate_total() -> void:
	var score_earnings : int = 0
	var image_data : Array
	var wasted_film : int = 0
	image_data = Master.get_game().pictures
	for i in image_data:
		var score : int = i[1]
		if score >= 1:
			score_earnings += score
		else:
			wasted_film += 1
	images_value.text = str("+", score_earnings)
	health_value.text = str("+", Master.get_game().health * 25)
	mansion_size.text = str("+", Master.get_game().score * 32, "ft²")
	filmloss.text = str("-", Master.get_game().roll * 10)
	film_ruined.text = str("-", wasted_film * 15)
