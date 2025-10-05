extends Node

@onready var game_manager: Node = %GameManager


func _on_body_entered(body: Node2D):
	game_manager.add_point()
	queue_free()
