extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$SettingsContainer/VBoxContainer/Volume.value = 5
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 5)
	$MainMenuContainer.visible = true
	$SettingsContainer.visible = false
	$ControlsContainer.visible = false
	$SettingsContainer/VBoxContainer/Volume.step = 0.0001

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartBtn_pressed():
	get_tree().change_scene("res://scenes/sandbox.tscn")


func _on_SettingsBtn_pressed():
	$MainMenuContainer.visible = false
	$SettingsContainer.visible = true


func _on_ControlsBtn_pressed():
	$MainMenuContainer.visible = false
	$ControlsContainer.visible = true


func _on_QuitBtn_pressed():
	get_tree().quit()

func _on_Volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value * 20)
	$SettingsContainer/VBoxContainer/Volume/Label2.text = String(value * 20)


func _on_ReturnBtn_pressed():
	$MainMenuContainer.visible = true
	$SettingsContainer.visible = false


func _on_ControlsReturnBtn_pressed():
	$MainMenuContainer.visible = true
	$ControlsContainer.visible = false
