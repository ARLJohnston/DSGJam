extends GutTest

var element_node = load('res://scenes/ElementNode.tscn')
var node_instance

# Called when the node enters the scene tree for the first time.
func before_each():
	node_instance = element_node.instantiate()

func test_add():
	node_instance.add()
	assert_eq(node_instance.value, 2)
	assert_eq(node_instance.get_node("AnimationPlayer").current_animation, "modify_up")
	
func test_remove():
	node_instance.add()
	node_instance.remove()
	assert_eq(node_instance.value, 1)
	assert_eq(node_instance.get_node("AnimationPlayer").current_animation, "modify_down")
	
func test_die():
	node_instance.remove()
	assert_eq(node_instance.value, 0)
	assert_eq(node_instance.get_node("AnimationPlayer").current_animation, "die")
	
