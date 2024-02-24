class_name Plant
extends Node2D

var plant_types

@export var plant_stats = {}

@export var dominant_plant_type = "air"
@export var petal_rotation = 0

@onready var sprite = $Sprite2D

func _ready():
	plant_types = $ElementResolver.elements_definition.keys()
	plant_types.erase("null")
	
	dominant_plant_type = plant_types[randi() % plant_types.size()]
	plant_stats[dominant_plant_type] = randi() % 3 + 1
	petal_rotation = 360/(plant_stats[dominant_plant_type])

	var has_secondary_type = randf() < 0.5
	var secondary_type = dominant_plant_type
	if has_secondary_type:
		while secondary_type == dominant_plant_type:
			secondary_type = plant_types[randi() % plant_types.size()]
			
		plant_stats[secondary_type] = randi() % plant_stats[dominant_plant_type] + 1
		petal_rotation = 360/(plant_stats[dominant_plant_type]*plant_stats[secondary_type]) % 360
	
	$ProximityElementDisplay.set_data(plant_stats)
	
	$flower_base.self_modulate = Color($ElementResolver.elements_definition[dominant_plant_type].color)
	var image_resource = "assets/flower_base_" + str([1,2,3].pick_random()) + ".png"
	$flower_base.texture = load(image_resource)
	
	$flower_petals.self_modulate = Color($ElementResolver.elements_definition[secondary_type].color)
	$flower_petals.rotation_degrees = petal_rotation
	$flower_petals.rotate(rotation_degrees)
	
	image_resource = "assets/flower_petals_" + str([1,2,3].pick_random()) + ".png"
	$flower_petals.texture = load(image_resource)

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
