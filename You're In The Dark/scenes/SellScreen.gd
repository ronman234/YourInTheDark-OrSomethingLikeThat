extends Control

var timer = 2
var currentTimer = 0
var counter = 0

var roomBonus = 100
var healthBonus = 50
var timeBonus = 25
var filmBonus = -10
var knockBonus = -10

var plusTotal = 0
var minusTotal = 0

var total = 0

func _ready():
	#$SellBtn.connect("button_up", Master.get_game(), "on_sell_btn")
	currentTimer = timer


func _process(delta):
	if(counter >= 6):
		return
	if(currentTimer <= 0):
		
		if(counter < 3):
			_playAnimCheckmark()
			print(counter)
		elif(counter >2 && counter < 5 ):
			_playAnimRedmark()
			print(counter)
		else:
			_calcTotal()
			print(counter)
		counter += 1
		currentTimer = timer
	currentTimer -= delta


func _playAnimCheckmark():
	if(counter == 0):
		$"Room Bonus/AnimatedSprite".play()
		roomBonus *= 20
		$"Room Bonus".text += String(roomBonus)
	elif(counter == 1):
		$"Time Bonus/AnimatedSprite2".play()
		timeBonus *= 10
		$"Time Bonus".text += String(timeBonus)
	elif(counter == 2):
		$"Health Bonus/AnimatedSprite3".play()
		healthBonus *= 5
		$"Health Bonus/".text += String(healthBonus)
		
func _playAnimRedmark():
	if(counter == 3):
		$"Film Bonus/AnimatedSprite4".play()
		filmBonus *= 10
		$"Film Bonus".text += String(filmBonus)
	elif(counter == 4):
		$"Knock Out/AnimatedSprite5".play()
		knockBonus *= 10
		$"Knock Out".text += String(knockBonus)

func _calcTotal():
	plusTotal += (roomBonus + timeBonus + healthBonus)
	$"Total Earned".text += String(plusTotal)
	minusTotal -= (filmBonus + knockBonus)
	$"Total Lost".text += String(minusTotal)
	total = plusTotal + minusTotal
	$Total.text += String(total)
	$SellBtn.visible = true
	$SellBtn.mouse_filter = MOUSE_FILTER_PASS


func _on_SellBtn_pressed():
	print("Total Sales BOI")
