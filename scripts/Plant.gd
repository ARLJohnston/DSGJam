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
	
	$ProximityElementDisplay.set_data(plant_stats)
	$PlantDataSprites.load_from(data)

func _input(event):
	if event.is_action_pressed("pickup") and player_in_range:
		#Somehow need to connect to inventory
		var inventory_group = get_tree().get_nodes_in_group("inventory")
		if inventory_group.size() > 0:
			var result = inventory_group[0].add_plant_to_inventory(data)
			if result:
				self.queue_free()

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		player_in_range = true

func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		player_in_range = false
