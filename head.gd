extends CharacterBody2D

@export var speed:int = 400
@export var death_speed_threshold:float = 50.0  # If speed drops below this, player dies

var screen_size
var center_screen
var dir
var head
var current_direction = Vector2.RIGHT
var turn_speed = 4.5
var is_dead = false

var xp = 0

@onready var xp_bar = $Camera2D/ProgressBar
@onready var score_label = $Camera2D/ScoreLabel  # adjust path!
@onready var snake_head = $"../../Snake"



# Create a reference to the part scene
@export var part_scene: PackedScene  # Assign this in the inspector

# head.gd
func _ready():
	screen_size = get_viewport_rect().size
	center_screen = screen_size / 2
	head = get_child(1)
	xp_bar.max_value = Global.max_orbs_xp

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
	# Check collisions
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)  # KinematicCollision2D
		var collider_obj = collision.get_collider()  # actual object
		if collider_obj.is_in_group("border"):
			die()

func die():
	$DeathPlayer.play()
	
	
	if is_dead:
		return
	is_dead = true

	# Show death screen
	var death_screen = get_tree().get_current_scene().get_node("DeathScreen")
	print(death_screen)
	if death_screen:
		death_screen.show_death()
	
	# Stop player movement
	velocity = Vector2.ZERO
	set_process(false)
	Global.score = 0
		
func add_xp(amount):
	$ConsumePlayer.play()
	xp += amount
	Global.score += amount
	
	if (xp >= Global.max_orbs_xp):
		$BodyExpansionPlayer.play()
		snake_head.add_body_part()
		xp -= Global.max_orbs_xp
	
	xp_bar.value = xp
	score_label.text = "Score: %.2f" % Global.score
