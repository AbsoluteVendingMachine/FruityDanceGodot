extends Window


@onready var main = get_node("/root/Main")
@onready var playing_status = $Control/VBoxContainer2/HBoxContainer3/TextureButton/Sprite2D
@onready var drag_offset_x = $Control/VBoxContainer2/HBoxContainer3/VBoxContainer4/HBoxContainer/LineEdit
@onready var drag_offset_y = $Control/VBoxContainer2/HBoxContainer3/VBoxContainer4/HBoxContainer2/LineEdit
@onready var control = $Control
#@onready var bpm = $Control/VBoxContainer2/HBoxContainer2/LineEdit
#@onready var speed = $Control/VBoxContainer2/HBoxContainer3/VBoxContainer/VSlider
##@onready var reflection : VSlider = $Control/VBoxContainer3/HBoxContainer3/VBoxContainer/VSlider
#@onready var animation = $Control/VBoxContainer2/HBoxContainer/Animations


var dir = DirAccess.open("user://")
var cfg = ConfigFile.new()


func _ready():
	await get_tree().create_timer(0.1).timeout
	if FileAccess.file_exists("user://settings.cfg"):
		#cfg.load("user://settings.cfg")
		#main.bpm = cfg.get_value("settings", "bpm", 60)
		#bpm.value = cfg.get_value("settings", "bpm", 60)
		#set_reflection(cfg.get_value("settings", "reflection", 100))
		#reflection.set_value_no_signal(cfg.get_value("settings", "reflection", 100))
		#set_speed(cfg.get_value("settings", "speed", 3))
		#speed.value = cfg.get_value("settings", "speed", 3)
		#main.animation_mode = cfg.get_value("settings", "animation", 0)
		#animation.select(cfg.get_value("settings", "animation", 0))
		#cfg.save("user://settings.cfg")
		#cfg.clear()
		return
	
	else:
		cfg.set_value("settings", "offset", Vector2(228, 160))
		#cfg.set_value("settings", "bpm", 60)
		#cfg.set_value("settings", "reflection", 100)
		#cfg.set_value("settings", "speed", 3)
		#cfg.set_value("settings", "animation", 0)
		#cfg.save("user://settings.cfg")
		cfg.clear()


func set_speed(input_value):
	if input_value < 3:
		main.animation_speed = (input_value + 1) / 4
	
	else:
		main.animation_speed = input_value - 2


func set_reflection(input_value):
	main.instantiated_dancing_window.sprite.reflection_sprite.modulate.a8 = input_value
	#main.instantiated_dancing_window.sprite2.reflection_sprite.modulate.a8 = input_value
	#main.instantiated_dancing_window.sprite3.reflection_sprite.modulate.a8 = input_value
	


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("resize"):
		if content_scale_factor == 1:
			size = Vector2i(640, 480)
			content_scale_factor = 2
		
		else:
			size = Vector2i(320, 240)
			content_scale_factor = 1
	
	if Input.is_action_just_pressed("hide"):
		match borderless:
			true:
				borderless = false
				control.modulate.a8 = 255
			
			false:
				borderless = true
				control.modulate.a8 = 0
				


func _on_animations_item_selected(index: int) -> void:
	main.animation_mode = index
	if FileAccess.file_exists("user://settings.cfg"):
		cfg.load("user://settings.cfg")
	
	cfg.set_value("settings", "animation", index)
	cfg.save("user://settings.cfg")
	print(main.animation_mode)


func _on_speed_value_changed(value: float) -> void:
	set_speed(value)
	if FileAccess.file_exists("user://settings.cfg"):
		cfg.load("user://settings.cfg")
	
	cfg.set_value("settings", "speed", value)
	cfg.save("user://settings.cfg")


func _on_reflection_value_changed(value: float) -> void:
	set_reflection(value)
	if FileAccess.file_exists("user://settings.cfg"):
		cfg.load("user://settings.cfg")
	
	cfg.set_value("settings", "reflection", value)
	cfg.save("user://settings.cfg")


func _on_bpm_edit_value_changed(value: float) -> void:
	main.bpm = value
	if FileAccess.file_exists("user://settings.cfg"):
		cfg.load("user://settings.cfg")
	
	cfg.set_value("settings", "bpm", value)
	cfg.save("user://settings.cfg")


func _on_button_pressed() -> void:
	dir.make_dir("ignore")
	OS.shell_open(ProjectSettings.globalize_path("user://"))


func _on_blend_slider_value_changed(value: float) -> void:
	if value > 0:
		main.instantiated_dancing_window.blend_animation_player.play("Blending (" + str(int(value)) + "%)")
	
	else:
		main.instantiated_dancing_window.blend_animation_player.play("RESET")


func _on_calibration_pressed() -> void:
	main.instantiated_dancing_window.calibration.play("Calibrate")


func _on_offset_y_value_changed(value: float) -> void:
	if FileAccess.file_exists("user://settings.cfg"):
		cfg.load("user://settings.cfg")
		cfg.set_value("settings", "offset", Vector2(cfg.get_value("settings", "offset").x, int(value)))
		main.calibration_offset.y = cfg.get_value("settings", "offset", Vector2(0, 0)).y
		cfg.save("user://settings.cfg")
		cfg.clear()
	
	else:
		cfg.set_value("settings", "offset", Vector2(228, 160))
		cfg.save("user://settings.cfg")
		main.calibration_offset = Vector2(228, 160)
		cfg.clear()


func _on_offset_x_value_changed(value: float) -> void:
	if FileAccess.file_exists("user://settings.cfg"):
		cfg.load("user://settings.cfg")
		cfg.set_value("settings", "offset", Vector2(int(value), cfg.get_value("settings", "offset").y))
		main.calibration_offset.x = cfg.get_value("settings", "offset", Vector2(0, 0)).x
		cfg.save("user://settings.cfg")
		cfg.clear()
	
	else:
		cfg.set_value("settings", "offset", Vector2(228, 160))
		cfg.save("user://settings.cfg")
		main.calibration_offset = Vector2(228, 160)
		cfg.clear()
