extends Control

onready var image_list = get_node("PanelContainer/Panel/PanelContainer/VBoxContainer/Pictures/HBoxContainer")

# VALUES:
onready var filmloss = get_node("PanelContainer/Panel/PanelContainer/VBoxContainer/EarnLoss/LostVbox/VALFilmLoss")
onready var images_value = get_node("PanelContainer/Panel/PanelContainer/VBoxContainer/EarnLoss/EarnedVbox/VALImage")
onready var health_value = get_node("PanelContainer/Panel/PanelContainer/VBoxContainer/EarnLoss/EarnedVbox/VALHealth")

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	calculate_loss()
	generate_images()
	calculate_earn()

func generate_images() -> void:
	var image_data : Array
	image_data = Master.get_game().pictures
	for entry in image_data:
		var image = entry[0]
		var score = entry[1]
		var image_texture := ImageTexture.new()
		image_texture.create_from_image((image as Image))
		var item : VBoxContainer = VBoxContainer.new()
		var texture : TextureRect = TextureRect.new()
		var score_record : Label = Label.new()
		texture.rect_min_size = Vector2(128,64)
		texture.texture = image_texture
		score_record.text = str("Value: ", score)
		item.add_child(texture)
		item.add_child(score_record)
		image_list.add_child(item)

func calculate_loss() -> void:
	filmloss.text = str("-", Master.get_game().roll * 10)

func calculate_earn() -> void:
	var score_earnings : int = 0
	var image_data : Array
	image_data = Master.get_game().pictures
	for i in image_data:
		var score : int = i[1]
		score_earnings += score
	images_value.text = str("+", score_earnings)
	health_value.text = str("+", Master.get_game().health)
