extends RigidBody3D

@export var speed: int = 10
@export var drone_propellers: Node3D

func calculate_force() -> Vector3:
	# F = M * A
	# -Z is forward
	# +X is to the right
	# +Y is up
	
	# Empty Vector3
	var force = Vector3(0, 0, 0)
	
	# Get the input
	
	# UP (P)
	if(Input.is_action_pressed('up')):
		force.y += speed
	
	# FORWARD (W)
	if(Input.is_action_pressed('forward')):
		force.z -= speed
		
		
	# BACK (S)
	if(Input.is_action_pressed('reverse')):
		force.z += speed
		
	return force
	
func _process(delta: float) -> void:
	
	var force = calculate_force()

	apply_central_force(force)

	pass
