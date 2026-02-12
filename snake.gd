extends Node2D

@export var body_part_scene: PackedScene  # Assign BodyPart.tscn in inspector
@export var body_spacing: float = 6.0  # Distance between body parts

var body_parts: Array[Node2D] = []
var position_history: Array[Vector2] = []
var max_history_length: int = 1000

@onready var head: CharacterBody2D = $CharacterBody2D

func _ready():
	if not head: # dej mi hlavu ;)
		push_error("No CharacterBody2D found as child of Snake!")
		return
	
	# Initialize position history with head's starting position
	position_history.append(head.global_position)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			add_body_part()

func _process(delta):
	# Add current head position to history
	position_history.push_front(head.global_position)
	
	# Limit history size
	if position_history.size() > max_history_length:
		position_history.pop_back()
	
	# Update body part positions
	update_body_parts()

func add_body_part():
	if not body_part_scene:
		push_error("BodyPart scene not assigned!")
		return
	
	var new_part = body_part_scene.instantiate()
	add_child(new_part)
	
	# Position new part at the end of the snake
	if body_parts.is_empty():
		print("emptyyy")
		# First body part - place behind head
		new_part.global_position = head.position
	else:
		# Place behind last body part
		new_part.global_position = body_parts[-1].global_position
	
	body_parts.append(new_part)

func update_body_parts():
	for i in range(body_parts.size()):
		var history_index = int((i + 1) * body_spacing)
		
		if history_index < position_history.size():
			# Smooth interpolation instead of instant positioning
			var target_pos = position_history[history_index]
			body_parts[i].global_position = body_parts[i].global_position.lerp(target_pos, 0.2)
