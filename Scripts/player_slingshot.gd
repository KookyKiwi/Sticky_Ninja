extends CharacterBody2D

# Variables
var is_dragging = false  # Tracks if the player is dragging the character
var start_position = Vector2.ZERO  # Starting position of the drag
var launch_velocity = Vector2.ZERO  # Velocity determined by the drag
var max_power = 600  # Maximum launch speed (can adjust for stronger/softer slingshot)
var gravity = 400  # Simulated gravity
var current_velocity = Vector2.ZERO  # Stores the character's current velocity
var is_launched = false  # Tracks if the character has been launched

# Input handling (mouse click and drag)
func _process(delta):
	if Input.is_action_just_pressed("mouse_left"):  # Mouse click detected
		if is_mouse_over():  # Only start dragging if the mouse is over the character
			is_dragging = true
			start_position = get_global_mouse_position()  # Track where the drag starts
			is_launched = false  # Reset launch state

	if Input.is_action_just_released("mouse_left") and is_dragging:
		# End dragging and launch the character
		is_dragging = false
		is_launched = true
		# Calculate launch velocity based on drag distance and direction
		launch_velocity = (start_position - get_global_mouse_position()).clamped(max_power)
		current_velocity = launch_velocity

# Movement and physics (gravity effect on velocity)
func _physics_process(delta):
	if is_launched:
		# Apply gravity to the velocity
		current_velocity.y += gravity * delta  # Simulate gravity
		# Move the character using the current velocity
		velocity = current_velocity
		move_and_slide()

# Check if the mouse is over the character
func is_mouse_over() -> bool:
	var mouse_pos = get_global_mouse_position()
	var shape = $CollisionShape2D.shape
	var transform = $CollisionShape2D.global_transform
	return shape.collide_point(mouse_pos, transform)
