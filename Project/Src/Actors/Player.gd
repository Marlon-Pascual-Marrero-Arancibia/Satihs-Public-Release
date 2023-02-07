extends Actor

func _physics_process(delta: float) -> void:
	velocity = calculate_move_velocity(velocity, get_direction(), Ishowspeed)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		Ishowspeed: Vector2
	) -> Vector2:
	var out = linear_velocity
	out.x = Ishowspeed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	out.y = Ishowspeed.y * direction.y
	return out
