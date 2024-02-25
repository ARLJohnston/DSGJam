extends Control

@export var contents = {}
@export var child_nodes = {}

var animation_queue = []
var animation_processing = false

var element_node_scene = load("res://scenes/ElementNode.tscn")

func _ready():
	$ElementResolver.connect("element_merged", _on_element_resolver_element_merged)
	$ElementResolver.connect("element_added", _on_element_resolver_element_added)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(animation_queue.size() > 0 and !animation_processing):
		animation_processing = true
		process_animation(animation_queue.pop_front())
		
func process_animation(animations_required):
	$Timer.wait_time = 1
	for anim in animations_required:
		print("processing anim " + str(anim))
		if anim[0] == "remove":
			var element = anim[1]
			if child_nodes.has(element):
				child_nodes[element].remove()
		elif anim[0] == "add":
			var element = anim[1]
			if child_nodes.has(element):
				child_nodes[element].add()
			else:
				if element != "null":
					var child = element_node_scene.instantiate()
					child.hide()
					child.set_image_resource($ElementResolver.elements_definition[element].resource)
					child.scale = Vector2(0,0)
					child.type = element
					child.connect("die_signal", on_child_die)
					add_child(child)
					child_nodes[element] = child
					child.show()

func on_child_die(type):
	if(child_nodes.has(type)):
		print("Wiped " + type)
		child_nodes.erase(type)
		
func add_flower(flower_data):
	print("Added flower data: " + str(flower_data))
	contents = $ElementResolver.merge_elements(flower_data, contents)

func _on_element_resolver_element_merged(first, second, result):
	print("Merged anim for ("+first+","+second+","+result+") to queue.")
	animation_queue.append([["remove", first], ["remove", second], ["add", result]])

func _on_element_resolver_element_added(element):
	print("Added element " + element)
	animation_queue.append([["add", element]])
	
func _on_timer_timeout():
	animation_processing = false
