extends Node2D

var request = {}
var min_timer_amount = 60
var task_complete = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var map = get_tree().get_first_node_in_group("map")
	if map:
		self.position = map._tilemap_to_position(Vector2i(map.BASE_SIZE.x / 2 - 1, map.BASE_SIZE.y / 2))
		make_request(map)
	else:
		request = {"ice": 5}
		$ProximityElementDisplay.set_data(request)

func make_request(map):
	
	var plants = map.plants
	if plants.size() == 0:
		return
		
	var indexes = [0,0,0]
	var unique = false
	while !unique:
		indexes = [randi()%plants.size(), randi()%plants.size(), randi()%plants.size()]
		# big brain
		if indexes[0] != indexes[1] && indexes[1] != indexes[2] && indexes[0] != indexes[2]:
			unique = true
			
	var new_plants = [plants[indexes[0]], plants[indexes[1]], plants[indexes[2]]]
	
	for plant in new_plants:
		request = $ElementResolver.merge_elements(request, plant.data.plant_stats)
		
	if request == {}:
		lose()
		
	$ProximityElementDisplay.set_data(request)
		
func _on_request_timeout_timer_timeout():
	var map = get_tree().get_first_node_in_group("map")
	if map:
		make_request(map)
	$RequestTimeoutTimer.wait_time = (randi() % 5) * 60 + min_timer_amount


func _on_request_complete_poll_timer_timeout():
	var cauldron = get_tree().get_first_node_in_group("cauldron_controller")
	if !task_complete:
		if cauldron.contents == request:
			task_complete = true
			
	if task_complete:
		$AnimationPlayer.play("potiontime")
		if cauldron.contents != {}:
			cauldron.clear_layer()
		else:
			win()
			
	$RequestCompletePollTimer.wait_time = 1

func win():
	print("You win")

func lose():
	print("You lose")
