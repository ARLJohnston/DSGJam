extends Control

var element_node_scene = load("res://scenes/ElementNode.tscn")

var children = []

func add_plant_to_inventory(plant_data):
	var plant_child = load("res://scenes/Plant.tscn").instantiate()
	plant_child.load_from(plant_data)
	
	#Need to proper instantiate and set stuff here
	
	$GridContainer.add_child(plant_child)
	children.append(plant_child)
	
	for child in children:
		print(child)
	
	$Pickup.play()
