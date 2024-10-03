extends CharacterBody2D
@onready var sail = $sail
@onready var radar = $radar
@onready var ai_controller = $AIController2D
@onready var game = get_parent()

const MAX_VELO = 300
const FRICTION = 0.1

var wind_velo = Vector2(0,0)
var speed = 2

var velo_x = 0
var angle = 0
var angle_increment = 0
var target_location = Vector2(0,0)
@onready var color_rect = $ColorRect
var min_distance = -1 
var speed_per = 0

func _ready():
	velo_x = 0
	angle = PI/6 + (2* randf() - 1) * PI/9
	rotation = angle
	sail._ready()
	radar._ready()
	angle_increment = 0
	position.x = 50
	position.y = randi_range(200, 450)
	color_rect.color = Color(randf(), randf(), randf())
	min_distance = -1 
	ai_controller.init(self)

func _physics_process(delta):
	if ai_controller.needs_reset:
		ai_controller.reset()
		_ready()
		return
	if wind_velo.x == 0 and wind_velo.y == 0:
		wind_velo = game.get_wind_velo()
		target_location = game.get_target()
		
	velo_x += wind_velo.length() * sin(wind_velo.angle() - sail.global_rotation) * sin(sail.rotation) * speed
	
	velo_x = clamp(velo_x, -MAX_VELO , MAX_VELO)
	
	speed_per = velo_x / MAX_VELO
	
	if velo_x:
		angle_increment += delta * speed_per * radar.rotation
		angle += angle_increment
		angle_increment = 0
	
	rotation = angle
	
	position -= global_transform.x * velo_x * delta
	
	velo_x = move_toward(velo_x, 0, FRICTION)
	
	var distance = boat_target_distance()
	if min_distance == -1: 
		min_distance = distance
	else:
		if distance < min_distance:
			ai_controller.reward = - (distance - min_distance) * 10
			min_distance = distance
		else:
			ai_controller.reward = -10
func set_wind_velo(velo):
	wind_velo = velo
	
func game_done():
	ai_controller.reward += 10000
	ai_controller.done = true
	ai_controller.needs_reset = true
	
func game_over():
	ai_controller.reward -= 10000
	ai_controller.done = true
	ai_controller.needs_reset = true
	
func set_target_location(location):
	target_location = location

func boat_target_distance():
	var distance = global_position - target_location
	return distance.length()
