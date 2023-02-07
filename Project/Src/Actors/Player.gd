extends Actor

func _physics_process(delta: float) -> void:
#		This code is relating to the jump functionality of the player.
#    --------------------------------------------------------------------
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y<0.0
	var direction: = get_direction()
	
	velocity = calculate_move_velocity(velocity, direction, Ishowspeed, is_jump_interrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
#		This code is relating to the jump functionality of the player.
#     -------------------------------------------------------------------
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0 
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		Ishowspeed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out = linear_velocity
	out.x = Ishowspeed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()\
#	This is code relating to the jump functionality of the player
# -----------------------------------------------------------------
	if direction.y == -1.0:
		out.y = Ishowspeed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out
