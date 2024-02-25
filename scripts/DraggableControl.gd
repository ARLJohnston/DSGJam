extends Control

var PlantDataSprites = load("res://scenes/PlantDataSprites.tscn")

func _get_drag_data(_position: Vector2):
	var prev = $PlantDataSprites.duplicate()
	prev.z_index = 25
	$PlantDataSprites.hide()
	set_drag_preview(prev)

	print("Dragging control")
	return $PlantDataSprites.data
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if !is_drag_successful():
			$PlantDataSprites.show()
