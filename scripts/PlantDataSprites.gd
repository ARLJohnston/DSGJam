extends Node

var data
	
func is_empty():
	return data == null
	
func load_from(plant_data):
	data = plant_data
	$flower_base.self_modulate = Color(plant_data.main_color)
	$flower_base.texture = load(plant_data.main_sprite)
	
	$flower_petals.self_modulate = Color(plant_data.petal_color)
	$flower_petals.rotation_degrees = plant_data.petal_rotation
	$flower_petals.texture = load(plant_data.petal_sprite)

func clear():
	data = null
	$flower_base.texture = null
	$flower_petals.texture = null
