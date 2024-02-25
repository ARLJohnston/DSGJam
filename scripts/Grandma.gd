extends Node2D

var request = {}
var min_timer_amount = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	var map = get_tree().get_first_node_in_group("map")
	if map:
		self.position = map._tilemap_to_position(Vector2i(map.BASE_SIZE.x / 2, map.BASE_SIZE.y / 2))
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
	$ProximityElementDisplay.set_data(request)
		
func _on_timer_timeout():
	var map = get_tree().get_first_node_in_group("map")
	if map:
		make_request(map)
	$Timer.wait_time = (randi() % 5) * 60 + min_timer_amount
