extends Node2D
var wind = Vector2(-5,0)
var rotate_limit = PI/6
@onready var sprite_2d = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.rotation = wind.angle() -PI/2
# Called every frame. 'delta' is the elapsed time since the previous frame.

func get_wind_velo():
	return wind

