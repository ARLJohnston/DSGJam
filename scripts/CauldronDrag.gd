extends TextureRect

func _can_drop_data(position, data):
	print("Cauldron!")
	print(data.plant_stats)
	return data is PlantData
	
func _drop_data(position, data):
	print(data)
	$ElementDisplay/MarginContainer/Controller.add_flower(data.plant_stats)
	var inventory = get_tree().get_first_node_in_group("inventory")
	if inventory:
		inventory.remove_plant(data)


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		$ElementDisplay.visible = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		$ElementDisplay.visible = false
