extends CharacterBody2D

@export var speed = 500
var input_direction = 0

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")

func _physics_process(delta):
	get_input()
	position += input_direction
	move_and_slide()
