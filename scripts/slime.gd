extends Node2D

const SPEED = 60
var direction = 1
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var floor_check_left: RayCast2D = $FloorCheckLeft
@onready var floor_check_right: RayCast2D = $FloorCheckRight
@onready var timer: Timer = $CollisionShape2D/Timer
@onready var enemy_check_up: RayCast2D = $EnemyCheckUp
@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding() or !floor_check_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding() or !floor_check_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	if enemy_check_up.is_colliding():
		var pj = enemy_check_up.get_collider()
		killable()
		if pj and pj.has_method("nockback"):
			pj.nockback()
	position.x += direction * SPEED * delta
	
func killable():
	set_process(false)
	area_2d.queue_free()
	collision_shape_2d.queue_free()
	animated_sprite_2d.play("death")
	await animated_sprite_2d.animation_finished
	queue_free()
	
func _on_body_entered(body: Node2D):
	
	if body.has_method("damage"):
		body.damage()
