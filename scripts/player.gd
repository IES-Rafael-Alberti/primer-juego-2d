extends CharacterBody2D


const SPEED = 140.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
const SWORD_SCENE = preload("res://scenes/sword.tscn")
var can_fire = true 
const LIFE = 3
var actualLife = 3
@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_material: ShaderMaterial = $AnimatedSprite2D.material
@onready var hp_bar: ProgressBar = $HPBar
@onready var hp_timer: Timer = $HPTimer


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#gets the imput direction -1, 0 or 1
	var direction := Input.get_axis("move_left", "move_right")
	
	#flips the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	#play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	#applies the movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	if Input.is_action_just_pressed("fire") and can_fire: 
		launch_sword()
		can_fire = false 

		
func launch_sword():
	# Crea una instancia de la escena de la espada
	var sword = SWORD_SCENE.instantiate()
	
	# Define la posición de inicio (justo al lado del personaje)
	sword.global_position = global_position
	
	
	#Define la dirección
	if animated_sprite.flip_h: 
		sword.direction = Vector2.LEFT
	else:
		sword.direction = Vector2.RIGHT
		
	#Ajusta la posición para que no aparezca en el centro
	sword.global_position += sword.direction * 20
	sword.global_position.y += -10
	#Añade la espada al árbol de escenas.
	get_tree().root.add_child(sword)
	sword.sword_destroyed.connect(_on_sword_destroyed) 

func _on_sword_destroyed():
	can_fire = true
	flash_ready()
func nockback():
	var knockback = 400
	velocity.x =  knockback
	velocity.y = -250 
func damage():
	flash_damage()
	actualLife -= 1
	hp_bar.value = actualLife
	hp_bar.visible = true
	hp_timer.start()
	if actualLife == 0:
		Engine.time_scale = 0.5
		timer.start()
		collision_shape_2d.queue_free()
	nockback()
func flash_damage():
	if not sprite_material:
		return
	var tween = create_tween()
	tween.tween_property(sprite_material, "shader_parameter/flash_strength", 1.0, 0.05)
	tween.tween_property(sprite_material, "shader_parameter/flash_strength", 0.0, 0.2)
func flash_ready():
	if not sprite_material:
		return
	var tween = create_tween()
	tween.tween_property(sprite_material, "shader_parameter/ready_strength", 1.0, 0.05)
	tween.tween_property(sprite_material, "shader_parameter/ready_strength", 0.0, 0.2)
	
func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func _on_hp_timer_timeout() -> void:
	hp_bar.visible = false
