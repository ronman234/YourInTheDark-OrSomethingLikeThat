extends Control

var volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))

# Called when the node enters the scene tree for the first time.
func _ready():
	$SettingsMenu/HBoxContainer/VolumeLabel.text = String(volume)
	$SettingsMenu/HBoxContainer/Volume.value = volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume)

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("Pause"):
		self.is_paused = !is_paused
		
func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
	$PauseMenu.visible = is_paused
	if(is_paused):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_QuitBtn_pressed():
	get_tree().quit()


func _on_ControlsBtn_pressed():
	$MainMenuContainer.visible = false
	$ControlsContainer.visible = true


func _on_SettingsBtn_pressed():
	$PauseMenu.visible = false
	$SettingsMenu.visible = true


func _on_ResumeBtn_pressed():
	self.is_paused = false


func _on_ReturnBtn_pressed():
	$PauseMenu.visible = true
	$SettingsMenu.visible = false


func _on_ControlsReturnBtn_pressed():
	$MainMenuContainer.visible = true
	$ControlsContainer.visible = false

func _on_Volume_value_changed(value):
	AudioServer.set_bus_volume_db(volume, value/100)
	$SettingsMenu/HBoxContainer/VolumeLabel.text = String(value)

func _on_QuitBtn_button_up():
	get_tree().quit()
