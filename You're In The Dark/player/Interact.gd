extends Spatial

var can_take_picture = false
var player
onready var shutter_sfx : AudioStreamPlayer = $AudioStreamPlayer

func _input(event):
	if event is InputEvent and Input.is_action_just_pressed("interact"):
		if can_take_picture:
			shutter_sfx.play()
			$AnimationPlayer.play("camera_flash")
			Master.get_game().flash(player.current_location, player)

func _on_Player_can_take_picture():
	can_take_picture = true

func _on_Player_can_not_take_picture():
	can_take_picture = false
