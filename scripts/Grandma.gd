extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var map_group = get_tree().get_nodes_in_group("map")
	if map_group.size() > 0:
		var map = map_group[0]
		self.position = map._tilemap_to_position(Vector2i(map.BASE_SIZE.x / 2, map.BASE_SIZE.y / 2))
		make_request(map)
	else:
		$ProximityElementDisplay.set_data({"ice": 5})

func make_request(map):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
