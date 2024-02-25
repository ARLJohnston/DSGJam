extends TextureRect

func _can_drop_data(position, data):
	print("Cauldron!")
	print(data.plant_stats)
	return data is PlantData
	
func _drop_data(position, data):
	print(data)
	$Controller.add_flower(data.plant_stats)
