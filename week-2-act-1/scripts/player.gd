extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -200.0

const DODGE_SPEED = 400.0
const DODGE_TIME = 0.002

var is_dodging = false
var dodge_timer = 0.0
var dodge_direction = 0.0

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Start dodge
	if Input.is_action_just_pressed("dodge") and not is_dodging:
		print("Dodging right now")
		is_dodging = true
		dodge_timer = DODGE_TIME
		
		# Dodge in movement direction, or face direction if standing still
		dodge_direction = Input.get_axis("ui_left", "ui_right")
		if dodge_direction == 0:
			dodge_direction = sign(velocity.x)
			if dodge_direction == 0:
				dodge_direction = 1  # default right
		
		velocity.y = 0  # Optional: remove vertical motion during dodge

	# Handle dodge movement
	if is_dodging:
		dodge_timer -= delta
		velocity.x = dodge_direction * DODGE_SPEED
		
		if dodge_timer <= 0:
			is_dodging = false
	else:
		# Handle jump
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Normal movement
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
