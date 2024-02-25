extends Node2D

@onready var anim = $AnimatedSprite2D
var _timer
var _spikes_active = false

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
	anim.frame = 0 if _spikes_active else 1
	_timer.start()
