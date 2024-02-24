extends Control

var children = []
var data = {}

var element_node_scene = load("res://scenes/ElementNode.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_data({"ice": 5, "poison": 1, "water": 3})

func set_data(data):
	self.data = $ElementResolver.resolve_elements(data)
	for child in children:
		child.queue_free()
		
	children = []
	
	for child in self.data.keys():
		var new_child = element_node_scene.instantiate()
		new_child.set_image_resource($ElementResolver.elements_definition[child].resource)
		new_child.type = child
		new_child.value = str(self.data[child])
		$MarginContainer.get_node("GridContainer").add_child(new_child)
		children.append(new_child)
