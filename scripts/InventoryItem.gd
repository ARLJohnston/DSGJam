extends CenterContainer


func _ready():
	$DraggableControl.get_node("ElementDisplay").visible = false;

func is_empty():
	return $DraggableControl.get_node("PlantDataSprites").is_empty()

func clear():
	$DraggableControl.get_node("PlantDataSprites").clear()

func data_equals(data):
	return $DraggableControl/PlantDataSprites.data == data
	
func load_from(data):
	$DraggableControl.get_node("PlantDataSprites").load_from(data)
	$DraggableControl.get_node("ElementDisplay").set_data(data.plant_stats)

func _on_plant_data_sprites_mouse_entered():
	if $DraggableControl.get_node("ElementDisplay").data != {}:
		$DraggableControl.get_node("ElementDisplay").visible = true

func _on_plant_data_sprites_mouse_exited():
	#var mouse_is_inside = self.get_global_rect().has_point(self.get_global_mouse_position())
	#if !mouse_is_inside:
		$DraggableControl.get_node("ElementDisplay").visible = false
