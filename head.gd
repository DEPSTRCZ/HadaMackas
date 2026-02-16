extends CharacterBody2D

@export var speed:int = 400
var screen_size
var center_screen
var dir
var head
var current_direction = Vector2.RIGHT
var turn_speed = 4.5


# Create a reference to the part scene
@export var part_scene: PackedScene  # Assign this in the inspector

func _ready():
	screen_size = get_viewport_rect().size
	center_screen = screen_size/2
	head = get_child(1)
	print(head)
	#self.name = "head"
	
func _process(delta):
	# Calculate target direction
	var target_dir = ((center_screen - get_viewport().get_mouse_position()) / center_screen).normalized()
	
	# Smoothly interpolate current direction toward target
	current_direction = current_direction.lerp(-target_dir, turn_speed * delta).normalized()
	
	# Use the smoothed direction for movement
	self.velocity = current_direction * speed
	
	# Rotate head to match current direction
	var rotated_vector = current_direction.rotated(deg_to_rad(90))
	head.rotation_degrees = rad_to_deg(atan2(rotated_vector[1], rotated_vector[0]))
	
	move_and_slide()
		
	
		
		
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		
		#self.add_child(part)
	
		#spawn_new_part()

#func spawn_new_part():
#	var original_part = $part
#	print("Original part script: ", original_part.get_script())
	
#	var new_part = original_part.duplicate(DUPLICATE_USE_INSTANTIATION | DUPLICATE_SCRIPTS)
#	print("New part script: ", new_part.get_script())
#	print("New part has initialize: ", new_part.has_method("initialize"))
	
#	new_part.position = self.position
#	add_child(new_part)
	
#	print("New part spawned at index: ", new_part.get_index())
