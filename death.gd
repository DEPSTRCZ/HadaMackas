extends CanvasLayer

@onready var restart_button = $Panel/VBoxContainer/Button
@onready var score_label = $Panel/VBoxContainer/ScoreLabel

func _ready():
	restart_button.pressed.connect(_on_restart_pressed)
	hide()  # hide initially

func show_death():
	score_label.text = "Your final score was: %.2f" % Global.score
	show()  # show the death screen

func _on_restart_pressed():
	get_tree().reload_current_scene()  # restart game
