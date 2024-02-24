class_name Plant
extends Node2D

var plant_types
var data
var player_in_range = false

func _ready():
	plant_types = $ElementResolver.elements_definition.keys()
	plant_types.erase("null")
	var plant_stats = {}
	var dominant_plant_type = plant_types[randi() % plant_types.size()]
	plant_stats[dominant_plant_type] = randi() % 3 + 1
	var petal_rotation = 360/(plant_stats[dominant_plant_type])

	var has_secondary_type = randf() < 0.5
	var secondary_type = dominant_plant_type
	if has_secondary_type:
		while secondary_type == dominant_plant_type:
			secondary_type = plant_types[randi() % plant_types.size()]
			
		plant_stats[secondary_type] = randi() % plant_stats[dominant_plant_type] + 1
		petal_rotation = 360/(plant_stats[dominant_plant_type]*plant_stats[secondary_type]) % 360
	
	var main_sprite = "assets/flower_base_" + str([1,2,3].pick_random()) + ".png"
	var main_color = $ElementResolver.elements_definition[dominant_plant_type].color
	var petal_sprite = "assets/flower_petals_" + str([1,2,3].pick_random()) + ".png"
	var petal_color = $ElementResolver.elements_definition[secondary_type].color
	
	data = PlantData.new(plant_stats, petal_rotation, main_sprite, main_color, petal_sprite, petal_color)
	
	load_from(data)
	
func load_from(plant_data):
	$ProximityElementDisplay.set_data(plant_data.plant_stats)
	
	$flower_base.self_modulate = Color(plant_data.main_color)
	$flower_base.texture = load(plant_data.main_sprite)
	
	$flower_petals.self_modulate = Color(plant_data.petal_color)
	$flower_petals.rotation_degrees = plant_data.petal_rotation
	$flower_petals.rotate(rotation_degrees)
	$flower_petals.texture = load(plant_data.petal_sprite)

func _get_dominant_plant_type(plant_stats):
	var max_type = "air"
	var max_count = 0
	for plant_type in plant_types:
		if plant_stats[plant_type] > max_count:
			max_type = plant_type
			max_count = plant_stats[plant_type]
	return max_type

func _input(event):
	if event.is_action_pressed("pickup") and player_in_range:
		#Somehow need to connect to inventory
		$"/root/items".add_plant_to_inventory(data)
		self.queue_free()

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		player_in_range = true

func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		player_in_range = false
