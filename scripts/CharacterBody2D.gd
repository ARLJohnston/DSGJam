extends CharacterBody2D


@export var speed = 500
var prev_direction = Vector2(0, 0)
var input_direction = Vector2(0, 0)
var jumping = 0
var new_position = Vector2(0, 0)
var tween

func _can_walk_to_noop(pos_) -> bool:
	return true

@export var can_walk_to_callback = _can_walk_to_noop

func _ready():
	position = Vector2(20, -20)
	new_position = position

func get_input():
	prev_direction = input_direction
	input_direction = round(Input.get_vector("left", "right", "up", "down"))
	if input_direction[0] != 0 and input_direction[1] != 0:
		if prev_direction[0] == 0 or prev_direction[1] == 0:
			input_direction = prev_direction
		else:
			input_direction = Vector2(0, 0)

func move(dir):
	var next_position = position + 64*dir
	if not can_walk_to_callback.call(next_position):
		return

	if !tween or !tween.is_running():
		#move by 64*direction
		tween = create_tween()

		tween.tween_property(self, "position", next_position, 0.2)
		tween.play()
		get_node("AnimationPlayer").play("bounce")
	elif tween && !tween.is_running():
		tween.kill()

func _physics_process(delta):
	get_input()
	if input_direction != Vector2(0, 0):
		move(input_direction)
	move_and_slide()
