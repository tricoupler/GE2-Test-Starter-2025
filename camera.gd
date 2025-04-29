# This is the camera script

extends Marker3D


@export var target: RigidBody3D
var current_position

func _process(delta: float) -> void:
	global_position = lerp(global_position, target.global_position, delta * 10.0)
	
	pass
