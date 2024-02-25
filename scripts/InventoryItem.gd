extends CenterContainer


func _ready():
	$DraggableControl.get_node("ElementDisplay").visible = false;

func is_empty():
	return $DraggableControl.get_node("PlantDataSprites").is_empty()

func clear():
	$DraggableControl.get_node("PlantDataSprites").clear()
	$DraggableControl.get_node("ElementDisplay").set_data({})

func data_equals(data):
	return $DraggableControl/PlantDataSprites.data == data
	
func load_from(data):
	$DraggableControl.get_node("PlantDataSprites").load_from(data)
	$DraggableControl.get_node("ElementDisplay").set_data(data.plant_stats, false)

func _on_plant_data_sprites_mouse_entered():
	if $DraggableControl.get_node("ElementDisplay").data != {}:
		$DraggableControl.get_node("ElementDisplay").visible = true

func _on_plant_data_sprites_mouse_exited():
	$DraggableControl.get_node("ElementDisplay").visible = false
