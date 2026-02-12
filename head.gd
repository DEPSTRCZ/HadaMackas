extends CharacterBody2D

@export var speed:int = 400
var screen_size
var center_screen
var dir


# Create a reference to the part scene
@export var part_scene: PackedScene  # Assign this in the inspector

func _ready():
	screen_size = get_viewport_rect().size
	center_screen = screen_size/2
	#self.name = "head"
	
func _process(_delta):
	dir = ((center_screen-get_viewport().get_mouse_position())/center_screen).normalized()
	#print(self.position)
	self.velocity = -dir * speed
		 
	#print(get_viewport().get_mouse_position())
	
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
