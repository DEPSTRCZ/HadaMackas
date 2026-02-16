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
	
	# Position new part right behind the head
	var history_index = int(body_spacing)
	
	if history_index < position_history.size():
		new_part.global_position = position_history[history_index]
	else:
		new_part.global_position = head.global_position
	
	# Insert at the FRONT of the array (closest to head)
	body_parts.push_front(new_part)

func update_body_parts():
	for i in range(body_parts.size()):
		# Each part follows the position spacing from the head
		var history_index = int((i + 1) * body_spacing)
		
		if history_index < position_history.size():
			# Direct positioning - no lerp, no stutter
			body_parts[i].global_position = position_history[history_index]
