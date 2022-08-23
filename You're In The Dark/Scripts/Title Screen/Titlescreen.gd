extends Control

func _on_Button_button_up():
	Master.load_scene("sandbox")
	$MainMenu.visible = false


func _on_Button_pressed():
	self.is_paused = false
