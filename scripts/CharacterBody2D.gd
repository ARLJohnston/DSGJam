extends CharacterBody2D

@export var friction = 0.2
@export var speed = 500
var input_direction = 0

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")

func _physics_process(delta):
	get_input()
	if input_direction[0] != 0 or input_direction[1] != 0:
		velocity = input_direction * speed
	else:
		velocity = velocity * (1 - friction)
	move_and_slide()
