extends Node

@export var contents = {}
@export var child_nodes = {}

var animation_queue = []
var animation_processing = false
var current_process_count = 0

var element_node_scene = load("res://scenes/ElementNode.tscn")

func _ready():
	$ElementResolver.connect("element_merged", _on_element_resolver_element_merged)
	$ElementResolver.connect("element_added", _on_element_resolver_element_added)
	add_flower({"ice":1})
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(animation_queue.size() > 0 and !animation_processing):
		animation_processing = true
		process_animation(animation_queue.pop_front())
	
func animation_process_callback(anim):
	current_process_count -= 1
	if current_process_count == 0:
		animation_processing = false
		
func process_animation(animations_required):
	print("processing animation " + str(animations_required))
	current_process_count = animations_required.size()
	for anim in animations_required:
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
					child.set_image_resource($ElementResolver.elements_definition[element].resource)
					child.connect("die_signal", on_child_die)
					child.get_node("AnimationPlayer").connect("animation_finished", animation_process_callback)
					add_child(child)

func on_child_die(type):
	if(child_nodes.has(type) and !is_instance_valid(child_nodes[type])):
		child_nodes.erase(type)
		
func add_flower(flower_data):
	print("Added flower data")
	contents = $ElementResolver.merge_elements(flower_data, contents)

func _on_element_resolver_element_merged(first, second, result):
	print("Merged anim for ("+first+","+second+","+result+") to queue.")
	animation_queue.append([["remove", first], ["remove", second], ["add", result]])

func _on_element_resolver_element_added(element):
	print("Added element " + element)
	animation_queue.append([["add", element]])
