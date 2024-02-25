class_name Plant
extends Node2D

var plant_types
var data
var player_in_range = false

func _ready():
	plant_types = $ElementResolver.elements_definition.keys()
	plant_types.erase("null")
	
	var plant_stats = {}
	var dominant_plant_type = get_weighted_type(plant_types)
	plant_stats[dominant_plant_type] = randi() % 3 + 1
	var petal_rotation = 360/(plant_stats[dominant_plant_type])

	var has_secondary_type = randf() < 0.8
	var secondary_type = dominant_plant_type
	if has_secondary_type:
		while secondary_type == dominant_plant_type:
			secondary_type = get_weighted_type(plant_types)
			
		plant_stats[secondary_type] = randi() % plant_stats[dominant_plant_type] + 1
		petal_rotation = 360/(plant_stats[dominant_plant_type]*plant_stats[secondary_type]) % 360
	
	var main_sprite = "assets/flower_base_" + str([1,2,3].pick_random()) + ".png"
	var main_color = $ElementResolver.elements_definition[dominant_plant_type].color
	var petal_sprite = "assets/flower_petals_" + str([1,2,3].pick_random()) + ".png"
	var petal_color = $ElementResolver.elements_definition[secondary_type].color
	
	data = PlantData.new(plant_stats, petal_rotation, main_sprite, main_color, petal_sprite, petal_color)
	
	$ProximityElementDisplay.set_data(plant_stats, false)
	$PlantDataSprites.load_from(data)

func get_weighted_type(plant_types):
	var distribution = randf()
	var num_common = 4
	var num_uncommon = 4
	
	var plant_type
	if distribution < 0.8:
		plant_type = plant_types.slice(0,num_common-1)
	elif distribution < 0.95:
		plant_type = plant_types.slice(num_common,num_common+num_uncommon-1)
	else:
		plant_type = plant_types.slice(num_common+num_uncommon,plant_types.size()-1)
		
	return plant_type[randi() % (plant_type.size()-1)]
	
	
func _input(event):
	if event.is_action_pressed("pickup") and player_in_range:
		#Somehow need to connect to inventory
		var inventory = get_tree().get_first_node_in_group("inventory")
		if inventory:
			var result = inventory.add_plant_to_inventory(data)
			if result == true:
				self.queue_free()

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		player_in_range = true

func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		player_in_range = false
