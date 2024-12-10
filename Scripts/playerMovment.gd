extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
		
	if is_on_wall():
		velocity = Vector2.ZERO
		if Input.is_action_just_pressed("mouse_right"):
			var mouse_direction = get_global_mouse_position() - global_position
			if mouse_direction != Vector2.ZERO:
				mouse_direction = mouse_direction.normalized()
				mouse_direction.x = mouse_direction.x * 6
				velocity = mouse_direction * 400
	
	var direction := Input.get_axis("left", "right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
