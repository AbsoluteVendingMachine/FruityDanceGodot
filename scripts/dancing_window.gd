extends Window


var window_moveable : bool = true


@onready var sprite : Sprite2D = $Sprite2D
@onready var sprite2 = $Dancer2
@onready var sprite3 = $Sprite2D2
@onready var blend_animation_player = $AnimationPlayer
@onready var calibration = $Calibration
@onready var main = get_node("/root/Main")


var cfg = ConfigFile.new()


func calibrate():
	cfg.set_value("settings", "offset", Vector2(position.x - main.mouse_position.x, position.y - main.position.y))
	cfg.save("user://settings.cfg")
	cfg.clear()
	cfg.load("user://settings.cfg")
	main.calibration_offset = cfg.get_value("settings", "offset", Vector2(0, 0))
	cfg.clear()


func _process(delta: float) -> void:
	window_moveable = not main.instantiated_settings_window.has_focus()
	#print(main.mouse_position.distance_to(position))
	#if main.mouse_position.distance_to(position) < 50:
		#window_moveable = true
	#
	#else:
		#window_moveable = false
#func _on_focus_entered() -> void:
	#window_moveable = true
#
#
#func _on_focus_exited() -> void:
	#window_moveable = false


func _ready() -> void:
	sprite2.hide()
	calibration.play("RESET")
