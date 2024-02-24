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

@export var plant_stats = {}

@export var dominant_plant_type = "air"

@onready var sprite = $Sprite2D

func _ready():
	dominant_plant_type = plant_types[randi() % plant_types.size()]
	plant_stats[dominant_plant_type] = randi() % 3 + 1

	var has_secondary_type = randf() < 0.5
	if has_secondary_type:
		var secondary_type = dominant_plant_type
		while secondary_type == dominant_plant_type:
			secondary_type = plant_types[randi() % plant_types.size()]

		plant_stats[secondary_type] = randi() % 1 + 1
	
	$ProximityElementDisplay.set_data(plant_stats)

	sprite.texture.gradient = sprite.texture.gradient.duplicate()
	sprite.texture.gradient.set_color(0, plant_type_to_color[dominant_plant_type])

func _process(delta):
	pass

func _get_dominant_plant_type():
	var max_type = "air"
	var max_count = 0
	for plant_type in plant_types:
		if plant_stats[plant_type] > max_count:
			max_type = plant_type
			max_count = plant_stats[plant_type]
	return max_type
