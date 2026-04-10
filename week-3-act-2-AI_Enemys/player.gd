extends CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready():
	add_to_group("Player")

func _physics_process(delta: float) -> void:
	# Get WASD input for movement
	var direction = Vector2.ZERO
	
	if Input.is_key_pressed(KEY_W):
		direction.y -= 1
	if Input.is_key_pressed(KEY_S):
		direction.y += 1
	if Input.is_key_pressed(KEY_A):
		direction.x -= 1
	if Input.is_key_pressed(KEY_D):
		direction.x += 1
	
	# Apply movement
	velocity = direction.normalized() * SPEED
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Level complete!")
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://scenes/Level2.tscn")
