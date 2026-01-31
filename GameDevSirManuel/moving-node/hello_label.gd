extends Label

# Speed in pixels per second
var velocity: Vector2 = Vector2(200, 150) # initial x and y speed

func _process(delta):
	# Move label by velocity
	position += velocity * delta

	var screen_size = get_viewport_rect().size
	var label_size = size

	# Bounce off left/right edges
	if position.x < 0:
		position.x = 0
		velocity.x *= -1
	elif position.x + label_size.x > screen_size.x:
		position.x = screen_size.x - label_size.x
		velocity.x *= -1

	# Bounce off top/bottom edges
	if position.y < 0:
		position.y = 0
		velocity.y *= -1
	elif position.y + label_size.y > screen_size.y:
		position.y = screen_size.y - label_size.y
		velocity.y *= -1
