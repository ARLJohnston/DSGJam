extends Control

#var element_node_scene = load("res://scenes/ElementNode.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var plant_child = load("res://scenes/Plant.tscn")
	self.add_child(plant_child.instantiate()) 

func add_plant_to_inventory(plant_data):
	var plant_child = load("res://scenes/Plant.tscn").instantiate()
	print(plant_data.plant_stats)
	
	self.add_child(plant_child)
