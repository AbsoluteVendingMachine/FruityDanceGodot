extends Node2D


@onready var root_window := get_node("/root") as Window
@export_enum ("Freestyle", "Waiting", "Stepping", "Jumping", "Zombie", "Waving", "Hula", "Windmill", "Zitabata", "Dervish") var animation_mode : int = 0



var dancing_window = preload("res://scenes/dancing_window.tscn")
var settings_window = preload("res://scenes/settings_window.tscn")
var warning_window = preload("res://scenes/warning_window.tscn")
var instantiated_dancing_window
var instantiated_settings_window
var instantiated_warning_window
var animation_speed : float = 1
var mouse_position
var bpm : float = 60
var freestyle_animation : String = "Stepping"
var playing : bool
var initialized : bool
var calibration_offset : Vector2
var cfg = ConfigFile.new()


func _on_background_input_capture_bg_key_pressed(node, keys_pressed):
	var keyStrings = []
	
	for i in keys_pressed:
		if keys_pressed[i]:
			keyStrings.append(OS.get_keycode_string(i) if !OS.get_keycode_string(i).strip_edges().is_empty() else "Keycode" + str(i))

func _ready():
	root_window.borderless = true
	root_window.mouse_passthrough = true
	root_window.unfocusable = true
	get_viewport().set_embedding_subwindows(false)
	var window_instance = dancing_window.instantiate()
	var settings_instance = settings_window.instantiate()
	var warning_instance = warning_window.instantiate()
	add_child(warning_instance)
	#warning_instance.position.x += 400
	add_child(settings_instance)
	#settings_instance.position = Vector2(1000, 600)
	add_child(window_instance)
	window_instance.add_to_group("dance")
	settings_instance.add_to_group("settings")
	warning_instance.add_to_group("warning")
	instantiated_dancing_window = get_tree().get_first_node_in_group("dance")
	instantiated_settings_window = get_tree().get_first_node_in_group("settings")
	instantiated_warning_window = get_tree().get_first_node_in_group("warning")
	if FileAccess.file_exists("user://settings.cfg"):
		cfg.load("user://settings.cfg")
		calibration_offset = cfg.get_value("settings", "offset", Vector2(0, 0))
		instantiated_settings_window.drag_offset_x.value = calibration_offset.x
		instantiated_settings_window.drag_offset_y.value = calibration_offset.y
		cfg.clear()
	
	else:
		cfg.set_value("settings", "offset", Vector2(228, 160))
		calibration_offset = Vector2(160, 228)
		cfg.save("user://settings.cfg")
		cfg.clear()
	#window_instance.position = Vector2(desktop_resolution.x / 2, desktop_resolution.y / 2) 


#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("play"):
		#print("YEAH!")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if not FileAccess.file_exists("user://Dance.png"):
		instantiated_dancing_window.position.x += 300
		#instantiated_settings_window.position.x += 300
		#instantiated_warning_window.position.x -= 300
		#initialized = true
	mouse_position = get_global_mouse_position()
	#print(mouse_position)
	if Input.is_action_pressed("click") and instantiated_dancing_window.window_moveable:
		instantiated_dancing_window.sprite.animation_player.play("Held")
		instantiated_dancing_window.sprite2.animation_player.play("Held")
		instantiated_dancing_window.sprite3.animation_player.play("Held")
		instantiated_dancing_window.position.x = lerp(instantiated_dancing_window.position.x + int(calibration_offset.x), int(get_global_mouse_position().x), 0.3)
		instantiated_dancing_window.position.y = lerp(instantiated_dancing_window.position.y + int(calibration_offset.y), int(get_global_mouse_position().y), 0.3)
	
	else:
		instantiated_dancing_window.sprite.animation_player.speed_scale = (bpm / 60) * animation_speed
		instantiated_dancing_window.sprite2.animation_player.speed_scale = (bpm / 60) * animation_speed
		instantiated_dancing_window.sprite3.animation_player.speed_scale = (bpm / 60) * animation_speed
		instantiated_dancing_window.blend_animation_player.speed_scale = (bpm / 60) * animation_speed
		match animation_mode:
			0:
				instantiated_dancing_window.sprite.animation_player.play(str(freestyle_animation))
				instantiated_dancing_window.sprite2.animation_player.play(str(freestyle_animation))
				instantiated_dancing_window.sprite3.animation_player.play(str(freestyle_animation))
			1:
				instantiated_dancing_window.sprite.animation_player.play("Waiting")
				instantiated_dancing_window.sprite2.animation_player.play("Waiting")
				instantiated_dancing_window.sprite3.animation_player.play("Waiting")
			
			2:
				instantiated_dancing_window.sprite.animation_player.play("Stepping")
				instantiated_dancing_window.sprite2.animation_player.play("Stepping")
				instantiated_dancing_window.sprite3.animation_player.play("Stepping")
			
			3:
				instantiated_dancing_window.sprite.animation_player.play("Jumping")
				instantiated_dancing_window.sprite2.animation_player.play("Jumping")
				instantiated_dancing_window.sprite3.animation_player.play("Jumping")
			
			4:
				instantiated_dancing_window.sprite.animation_player.play("Zombie")
				instantiated_dancing_window.sprite2.animation_player.play("Zombie")
				instantiated_dancing_window.sprite3.animation_player.play("Zombie")
			
			5:
				instantiated_dancing_window.sprite.animation_player.play("Waving")
				instantiated_dancing_window.sprite2.animation_player.play("Waving")
				instantiated_dancing_window.sprite3.animation_player.play("Waving")
			
			6:
				instantiated_dancing_window.sprite.animation_player.play("Hula")
				instantiated_dancing_window.sprite2.animation_player.play("Hula")
				instantiated_dancing_window.sprite3.animation_player.play("Hula")
			
			7:
				instantiated_dancing_window.sprite.animation_player.play("Windmill")
				instantiated_dancing_window.sprite2.animation_player.play("Windmill")
				instantiated_dancing_window.sprite3.animation_player.play("Windmill")
			
			8:
				instantiated_dancing_window.sprite.animation_player.play("Zitabata")
				instantiated_dancing_window.sprite2.animation_player.play("Zitabata")
				instantiated_dancing_window.sprite3.animation_player.play("Zitabata")
			
			9:
				instantiated_dancing_window.sprite.animation_player.play("Dervish")
				instantiated_dancing_window.sprite2.animation_player.play("Dervish")
				instantiated_dancing_window.sprite3.animation_player.play("Dervish")
		
		#else:
			#instantiated_settings_window.playing_status.texture = load("res://pause.png")
			#instantiated_dancing_window.sprite.animation_player.play("Stepping")
			#instantiated_dancing_window.sprite2.animation_player.play("Stepping")
			#instantiated_dancing_window.sprite3.animation_player.play("Stepping")
