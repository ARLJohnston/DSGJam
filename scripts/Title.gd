extends Node2D

var player_tween
var grandma_tween
var frog_start = Vector2(380,700)
var grandma_start = Vector2(1000, 700)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !player_tween or !player_tween.is_running():
		player_tween = create_tween()
		var jump_height = randi_range(50, 300)
		
		var timing = randf_range(0.25, 0.5)
		player_tween.tween_property($FrogSprite, "position", frog_start, timing)
		player_tween.tween_property($FrogSprite, "position", Vector2(frog_start.x, frog_start.y - jump_height), timing)
		player_tween.play()
	elif player_tween && !player_tween.is_running():
		player_tween.kill()
		
	if !grandma_tween or !grandma_tween.is_running():
		grandma_tween = create_tween()
		var jump_height = randi_range(50, 250)
		var timing = randf_range(0.25, 0.8)
		grandma_tween.tween_property($GrandmaSprite, "position", grandma_start, timing)
		grandma_tween.tween_property($GrandmaSprite, "position", Vector2(grandma_start.x, grandma_start.y - jump_height), timing)
		grandma_tween.play()
	elif grandma_tween && !grandma_tween.is_running():
		grandma_tween.kill()

func _input(event):
	if event is InputEventKey:
		get_tree().change_scene_to_file("res://game.tscn")
		$BackgroundMusic.stop()
