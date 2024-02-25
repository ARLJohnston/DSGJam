extends Node2D

func _ready():
	$ElementDisplay.visible = false;
	
func set_data(data, resolve=true):
	$ElementDisplay.set_data(data, resolve)
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		$ElementDisplay.visible = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		$ElementDisplay.visible = false
