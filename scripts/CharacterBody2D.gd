extends CharacterBody2D


@export var speed = 500
var input_direction = Vector2(0, 0)
var jumping = 0
var new_position = Vector2(0, 0)
var tween

func _ready():
	position = Vector2(20, -20)
	new_position = position

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")

func move(dir):
	if !tween or !tween.is_running():
		#move by 64*direction
		tween = create_tween()

		tween.tween_property(self, "position", position + 64*dir, 0.4)
		tween.play()
		get_node("AnimationPlayer").play("bounce")
	elif tween && !tween.is_running():
		tween.kill()

func _physics_process(delta):
	get_input()
	if input_direction != Vector2(0, 0):
		move(input_direction)
	move_and_slide()
