extends CharacterBody2D


const speed = 100

var is_attacking = false
var attack_timer = 0.0
var attack_duration = 0.5

func setup_test():
	# Give player "wood_axe"
	var item = {}
	item.id = "wood_axe"
	item.stack_size = 1
	item.quantity = 1
	item.texture = "res://textures/wood_axe.png"
	Global.add_item_to_inventory(item)
	# Give player "wood_hoe"
	item = {}
	item.id = "wood_hoe"
	item.stack_size = 1
	item.quantity = 1
	item.texture = "res://textures/wood_hoe.png"
	Global.add_item_to_inventory(item)
	# Give player "wood_pickaxe"
	item = {}
	item.id = "wood_pickaxe"
	item.stack_size = 1
	item.quantity = 1
	item.texture = "res://textures/wood_pickaxe.png"
	Global.add_item_to_inventory(item)
	# Give player "wood_shovel"
	item = {}
	item.id = "wood_shovel"
	item.stack_size = 1
	item.quantity = 1
	item.texture = "res://textures/wood_shovel.png"
	Global.add_item_to_inventory(item)
	# Give player "wood_sword"
	item = {}
	item.id = "wood_sword"
	item.stack_size = 1
	item.quantity = 1
	item.texture = "res://textures/wood_sword.png"	
	Global.add_item_to_inventory(item)
	# Give the player "seeds_wheat"
	item = {}
	item.id = "seeds_wheat"
	item.stack_size = 1
	item.quantity = 1
	item.texture = "res://textures/seeds_wheat.png"	
	Global.add_item_to_inventory(item)
	# Update the UI
	var hud_node = $hud
	hud_node.show_actionbar_items()
	hud_node.show_inventory_items()


func _ready():
	add_to_group("Player")
	setup_test()


func _physics_process(delta):
	update_animation()
	move_and_slide()
	if is_attacking:
		attack_timer += delta
		if attack_timer >= attack_duration:
			is_attacking = false
			attack_timer = 0.0


func _input(event):
	if event.is_action_pressed("ui_select"):
		is_attacking = true
		attack_timer = 0.0
		$strong1.play()


func update_animation():
	if is_attacking:
		if Global.last_direction.y < 0:
			#$AnimatedSprite2D.play("attack_up")
			pass
		elif Global.last_direction.y > 0:
			#$AnimatedSprite2D.play("attack_down")
			pass
		elif Global.last_direction.x > 0:
			$AnimatedSprite2D.play("attack_right")
			if Global.selected_item == "wood_axe": $AttackRight.play("wood_axe")
			if Global.selected_item == "wood_hoe": $AttackRight.play("wood_hoe")
			if Global.selected_item == "wood_pickaxe": $AttackRight.play("wood_pickaxe")
			if Global.selected_item == "wood_shovel": $AttackRight.play("wood_shovel")
			if Global.selected_item == "wood_sword": $AttackRight.play("wood_sword")
		elif Global.last_direction.x < 0:
			$AnimatedSprite2D.play("attack_left")
			if Global.selected_item == "wood_axe": $AttackLeft.play("wood_axe")
			if Global.selected_item == "wood_hoe": $AttackLeft.play("wood_hoe")
			if Global.selected_item == "wood_pickaxe": $AttackLeft.play("wood_pickaxe")
			if Global.selected_item == "wood_shovel": $AttackLeft.play("wood_shovel")
			if Global.selected_item == "wood_sword": $AttackLeft.play("wood_sword")
		velocity.x = velocity.x/1.25
		velocity.y = velocity.y/1.25
		return
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	if direction != Vector2.ZERO:
		Global.last_direction = direction.normalized()
	if Input.is_action_pressed("ui_down"):
		velocity.y = speed
		#$AnimatedSprite2D.play("walk_down")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		$AnimatedSprite2D.play("walk_left")
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  speed
		$AnimatedSprite2D.play("walk_right")
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -speed
		#$AnimatedSprite2D.play("walk_up")
	elif direction == Vector2.ZERO:
		$AttackLeft.play("idle")
		$AttackRight.play("idle")
		if Global.last_direction.y > 0:
			#$AnimatedSprite2D.play("idle_down")
			pass
		elif Global.last_direction.x < 0:
			$AnimatedSprite2D.play("idle_left")
		elif Global.last_direction.x > 0:
			$AnimatedSprite2D.play("idle_right")
		elif Global.last_direction.y < 0:
			#$AnimatedSprite2D.play("idle_up")
			pass
