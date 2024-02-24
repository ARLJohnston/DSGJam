extends Node

func _on_timer_timeout():
	$Cauldron.add_flower({$Cauldron.get_node("ElementResolver").elements_definition.keys().pick_random(): 1})
