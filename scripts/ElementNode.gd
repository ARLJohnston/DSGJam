extends Node2D

var value = 1
var last_animation

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = value

func remove():
	value -= 1
	$Label.text = str(value)
	if value <= 0:
		$AnimationPlayer.play("die")
	else:
		$AnimationPlayer.play("modify_down")

func add():
	value += 1
	$Label.text = str(value)
	$AnimationPlayer.play("modify_up")

func _on_animation_player_animation_finished(anim_name):
	last_animation = anim_name
	if(anim_name == "die"):
		queue_free()
