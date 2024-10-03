extends AIController2D

@onready var boat = $".."

var sail : float = 0.0
var rudder : float = 0.0

func get_obs() -> Dictionary:
	#var distance = boat.boat_target_distance()
	var position_x = boat.position.x / 1200
	var position_y = boat.position.y / 700
	var relative_pos_target = boat.target_location - boat.position
	var angle_with_wind = (boat.wind_velo.angle() - boat.global_rotation) / (2*PI)
	var sail_angle_with_wind = (boat.wind_velo.angle() - boat.sail.global_rotation) / (PI/2)
	var rudder_angle = boat.radar.rotation / (PI/6)
	var speed_per = boat.speed_per
	var obs = [
		position_x,
		position_y,
		relative_pos_target.x/1200,
		relative_pos_target.y/700,
		angle_with_wind,
		sail_angle_with_wind,
		rudder_angle,
		speed_per
	]
	return {"obs":obs}

func get_reward() -> float:
	return reward

func get_action_space() -> Dictionary:
	return {
		"move_action" : {
			"size": 2,
			"action_type": "continuous"
		},
		}

func set_action(action) -> void:
	sail = clamp(action["move_action"][0], -1.0, 1.0)
	rudder = clamp(action["move_action"][1], -1.0, 1.0)
