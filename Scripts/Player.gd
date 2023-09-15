extends KinematicBody2D

export (int) var speed
var velocity
var screen_size
var facing_right = true
var airborne

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	velocity = Vector2.ZERO
	airborne = true

func _process(delta):
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		facing_right = true
	elif Input.is_action_pressed("move_left"):
		velocity.x = -speed
		facing_right = false
	else:
		velocity.x = 0
	if Input.is_action_pressed("jump") && !airborne:
		velocity.y = -200
		airborne = true
		#$AnimatedSprite.animation = "Jump"
	
	
	move_and_slide(velocity)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision != null:
			airborne = false
			
	if airborne:
		velocity.y += 5
	else:
		if velocity.x != 0:
			$AnimatedSprite.animation = "Run"
		else:
			$AnimatedSprite.animation = "Idle"
		
	$AnimatedSprite.flip_h = !facing_right
