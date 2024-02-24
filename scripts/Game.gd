extends Node2D

@onready var player = $Player
@onready var tilemap = $TileMap

@onready var plant_scene = preload("res://scenes/Plant.tscn")


const BASE_SIZE = Vector2i(32, 16)
const TILE_SIZE = 64

var items = ItemProtoset
var plants: Array[Plant] = []

func _ready():
	# Shift player to the center of the world
	player.position = _tilemap_to_position(Vector2i(BASE_SIZE.x / 2, BASE_SIZE.y / 2))
	_gen()

func _gen():
	for i in range(5):
		var new_plant = plant_scene.instantiate()

		if plants.size() == 0:
			new_plant.position = _tilemap_to_position(_random_tilemap_position())
		else:
			var candidate_position = _position_to_tilemap(plants[0].position)
			while true:
				candidate_position = _random_tilemap_position()

				var is_good = true
				for plant in plants:
					var distance = (_position_to_tilemap(plant.position) - candidate_position).length()
					if distance < 5:
						is_good = false
						break

				if is_good:
					new_plant.position = _tilemap_to_position(candidate_position)
					break


		new_plant.get_node("Area2D").connect("body_entered", _on_plant_overlapped.bind(new_plant))

		add_child(new_plant)
		plants.append(new_plant)

	# const threshold_to_tiles = {
	# 	0.5: 0,
	# 	0.6: 1,
	# 	0.65: 2,
	# 	0.8: 3,
	# 	1.0: 4,
	# }

	# var perlin_noise = FastNoiseLite.new()
	# perlin_noise.seed = randi()

	# for x in (BASE_SIZE.x):
	# 	for y in (BASE_SIZE.y):
	# 		var noise_at_point = (perlin_noise.get_noise_2d(x, y) + 1.0) / 2.0

	# 		var tile = 0
	# 		for threshold in threshold_to_tiles.keys():
	# 			if noise_at_point < threshold:
	# 				tile = threshold_to_tiles[threshold]
	# 				break


	# 		tilemap.set_cell(0, Vector2(x, y), 2, Vector2(tile, 0))

func _on_plant_overlapped(_body, plant):
	var label = $CanvasLayer/Label

	var stats = plant.plant_stats
	var text = ""
	for k in stats.keys():
		text += k + ": " + str(stats[k]) + "\n"

	label.text = text

func _position_to_tilemap(pos: Vector2) -> Vector2i:
	return Vector2i(int(pos.x / TILE_SIZE), int(pos.y / TILE_SIZE))

func _tilemap_to_position(tile: Vector2i) -> Vector2:
	return Vector2(tile.x * TILE_SIZE, tile.y * TILE_SIZE) + Vector2(TILE_SIZE / 2, TILE_SIZE / 2)

func _random_tilemap_position() -> Vector2i:
	return Vector2i(randi() % BASE_SIZE.x, randi() % BASE_SIZE.y)
