extends CharacterBody2D


const speed = 100
var last_direction = Vector2.RIGHT
var is_attacking = false
var attack_timer = 0.0
var attack_duration = 0.5


func _ready():
	add_to_group("Player")


func _physics_process(delta):
	update_animation()
	move_and_slide()
	if is_attacking:
		attack_timer += delta
		if attack_timer >= attack_duration:
			is_attacking = false
			attack_timer = 0.0


func _input(event):
	# 🅱
	if event.is_action_pressed("ui_select"):
		is_attacking = true
		attack_timer = 0.0
		$AudioStreamPlayer2D.play()


func update_animation():
	# 🅱
	if is_attacking:
		if last_direction.y < 0:
			#$AnimatedSprite2D.play("attack_up")
			pass
		elif last_direction.y > 0:
			#$AnimatedSprite2D.play("attack_down")
			pass
		elif last_direction.x > 0:
			$AnimatedSprite2D.play("attack_right")
			$AttackRight.play("wooden_sword")
		elif last_direction.x < 0:
			$AnimatedSprite2D.play("attack_left")
			$AttackLeft.play("wooden_sword")
		velocity.x = velocity.x/1.25
		velocity.y = velocity.y/1.25
		return
	# ⬇⬅➡⬆
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	if direction != Vector2.ZERO:
		last_direction = direction.normalized()
	# ⬇
	if Input.is_action_pressed("ui_down"):
		velocity.y = speed
		#$AnimatedSprite2D.play("walk_down")
	# ⬅
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		$AnimatedSprite2D.play("walk_left")
	# ➡
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  speed
		$AnimatedSprite2D.play("walk_right")
	# ⬆
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -speed
		#$AnimatedSprite2D.play("walk_up")
	elif direction == Vector2.ZERO:
		$AttackLeft.play("idle")
		$AttackRight.play("idle")
		if last_direction.y > 0:
			#$AnimatedSprite2D.play("idle_down")
			pass
		elif last_direction.x < 0:
			$AnimatedSprite2D.play("idle_left")
		elif last_direction.x > 0:
			$AnimatedSprite2D.play("idle_right")
		elif last_direction.y < 0:
			#$AnimatedSprite2D.play("idle_up")
			pass
