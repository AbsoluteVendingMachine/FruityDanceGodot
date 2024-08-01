extends Window


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if FileAccess.file_exists("user://Dance.png"):
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
