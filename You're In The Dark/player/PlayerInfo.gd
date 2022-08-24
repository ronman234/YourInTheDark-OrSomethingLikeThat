extends Node

export var max_health : int = 100

var money : int = 100
var current_health : int = max_health
var is_dead : bool = false

onready var health_label : RichTextLabel = get_parent().get_node("CanvasLayer/HealthLabel")
onready var money_label : RichTextLabel = get_parent().get_node("CanvasLayer/MoneyLabel")

func take_damage(amount : int = 1):
	if !is_dead:
		current_health -= amount
	check_health()
	update_ui_labels()

func heal_damage(amount : int = 1):
	if !current_health >= max_health and !is_dead:
		current_health += amount
	update_ui_labels()
	

func check_health():
	if current_health <= 0:
		# Master.load_scene("title")
		print ("MF is dead")
		is_dead = true
	update_ui_labels()

func update_money(amount : int):
	money += amount
	update_ui_labels()

func update_ui_labels():
	health_label.text = str("Health: ", current_health)
	money_label.text = str("Money: $", money)
	
	
func _input(event):
	if Input.is_action_just_pressed("zoom"):
		take_damage(10)
	if Input.is_action_just_pressed("interact"):
		heal_damage(10)
	if Input.is_action_just_pressed("zoom_increase"):
		update_money(10)
	if Input.is_action_just_pressed("zoom_decrease"):
		update_money(-10)
		
