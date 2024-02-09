extends CharacterBody2D

var health = 20
var is_dead = false
var player = null
var player_in_range = false
var time_between_attacks = 0.5
var time_since_last_attacked = 0.0
var track_player = false


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Enemy")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# _physics_process function is called every physics frame (typically 60 times per second)
func _physics_process(delta):
	if player:
		if player_in_range:
			time_since_last_attacked += delta
			if time_since_last_attacked >= time_between_attacks:
				if player.is_attacking:
					time_since_last_attacked = 0
					$AnimatedSprite2D.play("hurt_left")
					$Hurt1.play()
					if Global.selected_item.contains("shovel"):
						health -= 2
					elif Global.selected_item.contains("pickaxe"):
						health -= 3
					elif Global.selected_item.contains("axe"):
						health -= 4
					elif Global.selected_item.contains("sword"):
						health -= 5
					else:
						health -= 1
		update_healthbar()
		if health <= 0 and not is_dead:
			die()


func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true


func _on_hitbox_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false


func _on_territory_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		track_player = true
		$Say1.play()

func _on_territory_body_exited(body):
	if body.is_in_group("Player"):
		player = null
		track_player = false

func die():
	#$Death.play()
	queue_free()


func update_healthbar():
	pass
