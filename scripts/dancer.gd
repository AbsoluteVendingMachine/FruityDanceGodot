extends Sprite2D


@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var main := get_node("/root/Main")
@onready var reflection_sprite : Sprite2D = $SubViewportContainer/SubViewport/Sprite2D


var rng = RandomNumberGenerator.new()


func _ready():
		var image := Image.new()
		if FileAccess.file_exists("user://Dance.png"):
			var error := image.load("user://Dance.png")
			var tex := ImageTexture.create_from_image(image)
			texture = tex
			$SubViewportContainer/SubViewport/Sprite2D.texture = tex
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	rng.randomize()
	if not rng.randi_range(1, 9) == main.animation_mode:
		match rng.randi_range(1, 9):
			1:
				main.freestyle_animation = "Waiting"
			
			2:
				main.freestyle_animation = "Stepping"
			
			3:
				main.freestyle_animation = "Jumping"
			
			4:
				main.freestyle_animation = "Zombie"
			
			5:
				main.freestyle_animation = "Waving"
			
			6:
				main.freestyle_animation = "Hula"
			
			7:
				main.freestyle_animation = "Windmill"
			
			8:
				main.freestyle_animation = "Zitabata"
			
			9:
				main.freestyle_animation = "Dervish"
	else:
		_on_animation_player_animation_finished("")
