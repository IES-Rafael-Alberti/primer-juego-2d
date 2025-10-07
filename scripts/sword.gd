extends Area2D

# Velocidad de la espada
const SPEED = 250
signal sword_destroyed 
# Dirección de movimiento (establecida por el personaje que lanza)
var direction = Vector2.RIGHT 

func _physics_process(delta):
	# Mueve la espada
	position += direction * SPEED * delta
	# Rota la espada para que apunte en la dirección del movimiento
	rotation = direction.angle()

func _on_body_entered(body: Node2D):
	if body.has_method("killable"):
		body.killable() 
	queue_free()
	sword_destroyed.emit()
	# Pone un límite al vuelo de la espada
func _on_timer_timeout() -> void:
	queue_free()
	sword_destroyed.emit()
