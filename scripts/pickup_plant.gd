extends Area2D

var player_in_range = false

func _input(event):
	if event.is_action_pressed("pickup") and player_in_range:
		print("picking up")

func _on_area_2d_body_entered(body):
	print("ranging")
	if body.is_in_group("player"):
		print("ranging")
		player_in_range = true
		
func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
