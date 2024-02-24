extends Node

var value = 1
var type
var image_resource

signal die_signal(type)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = str(value)
	
func set_image_resource(image_resource):
	self.image_resource = image_resource
	$Sprite.texture = load(image_resource)
	
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
	if(anim_name == "die"):
		die_signal.emit(type)
		queue_free()
