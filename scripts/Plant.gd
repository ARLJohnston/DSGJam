class_name Plant
extends Node2D

const plant_types = [
	"air",
	"earth",
	"fire",
	"water",
]

const plant_type_to_color = {
	"air": Color(1, 0.5, 1, 1),
	"earth": Color(0, 1, 0, 1),
	"fire": Color(1, 0, 0, 1),
	"water": Color(0, 0, 1, 1),
}

@export var plant_type = plant_types[0]

@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.plant_type = plant_types[randi() % plant_types.size()]

	sprite.texture.gradient = sprite.texture.gradient.duplicate()
	sprite.texture.gradient.set_color(0, plant_type_to_color[plant_type])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
