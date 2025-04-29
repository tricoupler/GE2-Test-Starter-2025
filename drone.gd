extends RigidBody3D

@export var speed: int = 100
@export var rotational_speed = 10
@export var drone_propeller1: Node3D
@export var drone_propeller2: Node3D
@export var drone_propeller3: Node3D
@export var drone_propeller4: Node3D


func calculate_rotational_force() -> Vector3:
	# Y is up
	# Rotate around Y
	
	# Empty torque
	var torque = Vector3(0,0,0)
	
	# Left
	if(Input.is_action_pressed('left')):
		torque.y += rotational_speed
	
	# Right
	if(Input.is_action_pressed('right')):
		torque.y -= rotational_speed
	
	return torque
	
func calculate_force() -> Vector3:
	# F = M * A
	# -Z is forward
	# +X is to the right
	# +Y is up
	
	# Get the local position
	var force = Vector3(0,0,0)
	
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

func spin_propellers(prop_speed):
	drone_propeller1.global_rotate(Vector3(0,1,0), global_rotation.y + prop_speed)
	drone_propeller2.global_rotate(Vector3(0,1,0), global_rotation.y + prop_speed)
	drone_propeller3.global_rotate(Vector3(0,1,0), global_rotation.y + prop_speed)
	drone_propeller4.global_rotate(Vector3(0,1,0), global_rotation.y + prop_speed)
	pass
	
func _process(delta: float) -> void:
	#force = calculate()	
	#accel = force / mass	
	#velocity = (velocity + accel * delta)
	#
	
	var rotation = calculate_rotational_force()
	var force = calculate_force()
	
	print('Drone Up Force', force)
	print('Drone Forward Force:', force)
	print('Drone Rotational Force:', rotation)
	
	# Calculate propeller speed
	var prop_speed = force.length() + rotation.length()
	
	spin_propellers(prop_speed)
	
	apply_torque(rotation)
	apply_central_force(force)
	
	pass
