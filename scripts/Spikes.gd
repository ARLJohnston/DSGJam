extends Node2D

@onready var anim = $AnimatedSprite2D
var _timer
var _spikes_active = false
var _player_inside = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_spikes_active = randi() % 2 == 0

	_timer = Timer.new()
	_timer.set_wait_time(1)
	_timer.set_one_shot(true)
	_timer.connect("timeout", _on_timer)
	add_child(_timer)

	_on_timer()

func _on_timer():
	_spikes_active = not _spikes_active
	anim.frame = 1 if _spikes_active else 0
	_check_if_player_is_dead()
	_timer.start()

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		_player_inside = false
		_check_if_player_is_dead()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		_player_inside = true
		_check_if_player_is_dead()

func _check_if_player_is_dead():
	if _player_inside and _spikes_active:
		get_tree().change_scene_to_file("res://scenes/LoseScreen.tscn")
