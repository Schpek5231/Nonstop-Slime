extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const BOUNCE_HEIGHT = -500.0
const default_gravity = 700
const pound_power = 1300
var time_on_wall = 0
var grav = default_gravity
var pressed_space = 0
var hit_floor = 0
var falling = 0
var ground_pounding = 0
var tick = 0

func _physics_process(delta: float) -> void:
	Global.playerx = position.x
	Global.playery = position.y
	
	if ground_pounding == 1:
		tick += 1
		if is_on_floor():
			$PoundSFX.play()
			ground_pounding = 0
			tick = 0
	
	if Global.pounding == 1:
		$AnimatedSprite2D.play("ground_pound")
	
	# Add the gravity.
	if not is_on_floor():
		if not is_on_wall():
			if falling == 0:
				if velocity.y >= 0:
					$AnimatedSprite2D.play("fall")
					falling = 1
		velocity.y += grav * delta
		if Input.is_key_pressed(KEY_S):
			Global.pounding = 1
			velocity.y = pound_power
			ground_pounding = 1
	else:
		if Global.pounding == 1:
			hit_floor = 1
		Global.pounding = 0
		falling = 0
		Global.wall_jumping = 0
		$AnimatedSprite2D.play("run")

	if Input.is_key_pressed(KEY_R):
		position.x = Global.checkpointx
		position.y = Global.checkpointy
		Global.direction = 1
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")
		$JumpSFX.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Global.direction == 1:
		velocity.x = Global.direction * SPEED
		$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = Global.direction * SPEED
		$AnimatedSprite2D.flip_h = true

	if is_on_wall():
		Global.pounding = 0
		time_on_wall += 1
		if time_on_wall == 40:
			Global.ded = 1
			$AnimatedSprite2D.modulate.a = 0
			time_on_wall = 0
		if pressed_space == 0:
			velocity.y = 3000 * delta
			$AnimatedSprite2D.play("wall_slide")
		if Input.is_action_just_pressed("ui_accept"):
			$AnimatedSprite2D.play("wall_jump")
			$JumpSFX.play()
			pressed_space = 1
			Global.wall_jumping = 1
			velocity.y = BOUNCE_HEIGHT
			if Global.direction == 1:
				Global.direction = -1
			else:
				Global.direction = 1
	else:
		pressed_space = 0
		time_on_wall = 0
	
	if Global.ded == 0:
		move_and_slide()
		$AnimatedSprite2D.modulate.a = 1
	else:
		$AnimatedSprite2D.modulate.a = 0
