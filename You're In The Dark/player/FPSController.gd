extends KinematicBody

export var speed : float = 10
export var acceleration : float = 5
export var gravity : float = -0.98
export var jump_power : float = 30
export var mouse_sensitivity : float = 0.3

onready var head : Spatial = $Head
onready var camera : Camera = $Head/Camera

var velocity : Vector3 = Vector3()
var camera_x_rotation : float = 0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(_delta) -> void:
	if Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-deg2rad(event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(-deg2rad(event.relative.y * mouse_sensitivity))
			camera_x_rotation += x_delta

func _physics_process(delta) -> void:
	var direction : Vector3 = Vector3()
	var head_basis := head.get_global_transform().basis
	
	if Input.is_action_pressed("move_fwd"):
		direction -= head_basis.z
	elif Input.is_action_pressed("move_back"):
		direction += head_basis.z
		
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
	
	direction.y = 0
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector3.UP)