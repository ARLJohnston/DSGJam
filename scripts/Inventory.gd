extends Control

var inventory_item_scene = load("res://scenes/InventoryItem.tscn")

var children = []

func _ready():
	var player_grouped = get_tree().get_nodes_in_group("player")
	for player in player_grouped:
		player.connect("toggle_inventory", toggle_inventory)
		
	for i in range(9*3):
		var child = inventory_item_scene.instantiate()
		child.clear()
		$MarginContainer.get_node("GridContainer").add_child(child)
		children.append(child)
		
func toggle_inventory():
	self.visible = !self.visible
	
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
			child.clear()
