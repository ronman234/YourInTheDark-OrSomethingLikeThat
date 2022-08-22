extends KinematicBody

signal can_take_picture
signal can_not_take_picture

export var speed : float = 5
export var acceleration : float = 5
export var gravity : float = -0.98
export var jump_power : float = 30
export var mouse_sensitivity : float = 0.3
export var default_fov : float = 70
export var zoom_fov : float = 40
export var max_zoom : float = 40
export var min_zoom : float = 90

var is_zooming : bool = false
var current_zoom : float = 70

onready var head : Spatial = $Head
onready var camera : Camera = $Head/Camera
onready var camera_lense : ViewportContainer = $Lense
onready var camera_lense_viewport : Viewport = $Lense/Viewport

var velocity : Vector3 = Vector3()
var camera_x_rotation : float = 0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera_lense.visible = false
	
func _process(_delta) -> void:
	if Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_pressed("zoom"):
		is_zooming = true
		emit_signal("can_take_picture")
		camera.fov = current_zoom
		camera_lense_viewport.size.x = OS.window_size.x
		camera_lense_viewport.size.y = OS.window_size.y
		camera_lense.visible = true
	elif Input.is_action_just_released("zoom"):
		is_zooming = false
		emit_signal("can_not_take_picture")
		camera.fov = default_fov
		camera_lense.visible = false

func _input(event) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-deg2rad(event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(-deg2rad(event.relative.y * mouse_sensitivity))
			camera_x_rotation += x_delta
			
	if event is InputEvent:
		if Input.is_action_just_pressed("zoom_increase") and camera.fov > max_zoom and is_zooming:
			current_zoom -= 5
	if event is InputEvent:
		if Input.is_action_just_pressed("zoom_decrease") and camera.fov < min_zoom and is_zooming:
			current_zoom += 5
			
	if event is InputEvent and Input.is_action_just_pressed("interact"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta) -> void:
	var direction : Vector3 = Vector3()
	var head_basis := head.get_global_transform().basis
	
	if !is_zooming:
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
