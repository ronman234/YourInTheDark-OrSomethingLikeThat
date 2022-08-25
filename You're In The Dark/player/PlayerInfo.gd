extends Node

export var max_health : int = 100

var money : int = 100
var current_health : int = max_health
var is_dead : bool = false

onready var health_label : Label = get_parent().get_node("CanvasLayer/HealthLabel")
onready var money_label : Label = get_parent().get_node("CanvasLayer/MoneyLabel")

func take_damage(amount : int = 1):
	if !is_dead:
		current_health -= amount
	check_health()
	update_ui_labels()
	update_master()

func heal_damage(amount : int = 1):
	if !current_health >= max_health and !is_dead:
		current_health += amount
	update_ui_labels()
	update_master()

func check_health():
	if current_health <= 0:
		print ("MF is dead")
		is_dead = true
	update_ui_labels()
	update_master()

func update_money(amount : int):
	money += amount
	update_ui_labels()
	update_master()

func update_ui_labels():
	health_label.text = str("Health: ", current_health)
	money_label.text = str("Money: $", money)
	
func update_master():
	Master.get_game().current_health = current_health
	Master.get_game().current_money = money
	Master.get_game().is_dead = is_dead
	
	
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		heal_damage(10)
	
	
