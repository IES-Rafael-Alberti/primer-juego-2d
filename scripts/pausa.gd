extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func pausar():
	get_tree().paused = !get_tree().paused
	visible = !visible
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pausar()

func _on_button_pressed() -> void:
	pausar()

func _on_button_close_pressed() -> void:
	get_tree().quit()
