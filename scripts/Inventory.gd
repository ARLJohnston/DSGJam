extends Control

var inventory_item_scene = load("res://scenes/InventoryItem.tscn")

@export var children = []

func _ready():
	var player_grouped = get_tree().get_nodes_in_group("player")
	for player in player_grouped:
		player.connect("toggle_inventory", toggle_inventory)
		
	for i in range(9*3):
		add_new_child()
		
func add_new_child():
	var child = inventory_item_scene.instantiate()
	child.clear()
	$MarginContainer.get_node("GridContainer").add_child(child)
	children.append(child)
		
func toggle_inventory():
	self.visible = !self.visible
	
	var map = get_tree().get_first_node_in_group("map")
	if map:
		children[0].load_from(map.plants.pick_random().data)
	
func add_plant_to_inventory(plant_data):
	#Need to proper instantiate and set stuff here
	print("Pickup entered" + str(plant_data))
	for child in children:
		if child.is_empty():
			print("Picked up" + str(plant_data))
			child.load_from(plant_data)
			$Pickup.play()
			return true
	return false
	
func remove_plant(plant_data):
	for child in children:
		if child.data_equals(plant_data):
			child.queue_free()
			children.erase(child)
			add_new_child()
			break
