extends CharacterBody2D
const CHANGE_SPEED = 2
const MAX_ANGLE = PI / 2
var angle = rotation
const FRICTION = 0.01
@onready var ai_controller = $"../AIController2D"

func _ready():
	angle = 0

func _physics_process(delta):
	
	var direction = 0
	if ai_controller.heuristic == "human":
		direction = Input.get_axis("ui_left", "ui_right")
	else:
		direction = ai_controller.sail
	
	if direction:
		var new_angle = angle + direction * delta * CHANGE_SPEED
		if new_angle >= -MAX_ANGLE and new_angle <= MAX_ANGLE:
			angle = new_angle
			
	rotation = angle
	angle = move_toward(angle, 0 , FRICTION)
	move_and_slide()
