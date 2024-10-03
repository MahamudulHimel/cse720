extends Node2D
@onready var wind = $wind
@onready var target = $target

var target_location = Vector2()
var wind_velo = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	target_location = target.get_location()
	wind_velo = wind.get_wind_velo()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_target():
	return target_location

func get_wind_velo():
	return wind_velo
