class_name ColoredSprite
extends Area2D

@onready var _sprite : Sprite2D = $Sprite2D

func _ready() -> void:
	# Give each instance its OWN material copy so colors don't bleed
	_sprite.material = _sprite.material.duplicate()

func set_color(color: Color) -> void:
	_sprite.material.set_shader_parameter("tint", color)

func flash(duration: float = 0.5) -> void:
	_sprite.material.set_shader_parameter("shimmer_speed",  5.0)
	_sprite.material.set_shader_parameter("shimmer_bright", 1.4)
	await get_tree().create_timer(duration).timeout
	_sprite.material.set_shader_parameter("shimmer_speed",  1.5)
	_sprite.material.set_shader_parameter("shimmer_bright", 0.5)


func get_random_point_in_circle(radius):
	var angle = randf_range(0, TAU)
	var r = sqrt(randf()) * radius
	return Vector2(cos(angle), sin(angle)) * r

func _on_body_entered(body):
	if body.is_in_group("player"):
		#print(self.scale,self.scale.
		body.add_xp(self.scale[0])
		self.position = get_random_point_in_circle(Global.world_size.x/2-100)
		self.set_color(Global.orb_colors[randi_range(0,15)])
