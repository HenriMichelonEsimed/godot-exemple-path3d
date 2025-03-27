class_name Player
extends CharacterBody3D

@onready var camera : Camera3D = $CameraAttachement/CameraPivot/Camera3D
@onready var camera_pivot : Node3D = $CameraAttachement/CameraPivot

const walking_speed:float = 4
const running_speed:float = 8
const mouse_sensitivity:float = 0.005
const max_camera_angle_up:float = deg_to_rad(50)
const max_camera_angle_down:float = -deg_to_rad(40)

var mouse_y_axis:int = -1
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	capture_mouse()

func _input(event):
	if (mouse_captured()):
		if (event is InputEventScreenDrag) or (mouse_captured and (event is InputEventMouseMotion)):
			rotate_y(-event.relative.x * mouse_sensitivity)
			camera_pivot.rotate_x(event.relative.y * mouse_sensitivity * mouse_y_axis)
			camera_pivot.rotation.x = clampf(camera_pivot.rotation.x, max_camera_angle_down, max_camera_angle_up)
		if (Input.is_action_just_pressed("esc")):
			release_mouse()
	else:
		if (event is InputEventMouseButton):
			capture_mouse()

func _physics_process(delta: float) -> void:
	var on_floor = is_on_floor() 
	if not on_floor:
		velocity.y += -gravity
	const speed = walking_speed
	var input = Input.get_vector("player_left", "player_right", "player_forward", "player_backward")
	var direction = transform.basis * Vector3(input.x, 0, input.y)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	if  direction != Vector3.ZERO:
		capture_mouse()
	move_and_slide()

func _process(delta: float) -> void:
	pass

func capture_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func release_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func mouse_captured() -> bool:
	return Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
