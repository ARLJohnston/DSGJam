extends Node2D

@onready var player = $Player
@onready var tilemap = $TileMap

@onready var plant_scene = preload("res://scenes/Plant.tscn")


const PLANTS_ON_MAP = 10
const BASE_SIZE = Vector2i(128, 128)
const TILE_SIZE = 64
const ORIGIN = Vector2i(BASE_SIZE.x / 2, BASE_SIZE.y / 2)

var plants: Array[Plant] = []

func _ready():
	_gen()
	player.can_walk_to_callback = self._player_can_walk_to
	_gen()

func _gen():
	const threshold_to_tiles = {
		# 0.5: 0,
		# 0.6: 1,
		0.33: 1,
		0.66: 2,
		1.0: 3,
	}

	var noise = FastNoiseLite.new()
	noise.seed = randi()

	# All tiles are water.
	for x in (BASE_SIZE.x):
		for y in (BASE_SIZE.y):
			tilemap.set_cell(0, Vector2(x, y), 2, Vector2(0, 0))

	for i in range(PLANTS_ON_MAP):
		var new_plant = plant_scene.instantiate()

		var plant_dir = Vector2(cos(i * 2 * PI / PLANTS_ON_MAP), sin(i * 2 * PI / PLANTS_ON_MAP)).normalized()
		var plant_pos = Vector2i(BASE_SIZE / 2 + Vector2i(plant_dir * randf_range(32, 50)))
		new_plant.position = _tilemap_to_position(Vector2i(plant_pos.x, plant_pos.y))

		add_child(new_plant)
		plants.append(new_plant)

	for plant in plants:
		var plant_tilemap_position = _position_to_tilemap(plant.position)
		var current = Vector2i(ORIGIN)

		while current != plant_tilemap_position:
			var diff = plant_tilemap_position - current
			var rand_dir = randi() % 2
			if rand_dir == 0:
				if diff.x != 0:
					current.x += sign(diff.x)
			else:
				if diff.y != 0:
					current.y += sign(diff.y)

			var noise_at_point = (noise.get_noise_2d(current.x * 4.0, current.y * 4.0) + 1.0) / 2.0
			var tile_type = threshold_to_tiles.values()[0]
			for threshold in threshold_to_tiles.keys():
				if noise_at_point < threshold:
					tile_type = threshold_to_tiles[threshold]
					break

			tilemap.set_cell(0, current, 2, Vector2(tile_type, 0))

	# Place ground around the plant.
	for plant in plants:
		var plant_tilemap_position = _position_to_tilemap(plant.position)
		for x in range(-1, 2):
			for y in range(-1, 2):
				tilemap.set_cell(0, plant_tilemap_position + Vector2i(x, y), 2, Vector2(3, 0))

	# Place ground around the base origin.
	for x in range(-2, 3):
		for y in range(-2, 3):
			tilemap.set_cell(0, ORIGIN + Vector2i(x, y), 2, Vector2(3, 0))
			
	
	print(tilemap.get_cell_tile_data(0, Vector2(0, 0)))
	print(tilemap.get_cell_tile_data(0, Vector2(65, 65)))

func _position_to_tilemap(pos: Vector2) -> Vector2i:
	return Vector2i(int(pos.x / TILE_SIZE), int(pos.y / TILE_SIZE))

func _tilemap_to_position(tile: Vector2i) -> Vector2:
	return Vector2(tile.x * TILE_SIZE, tile.y * TILE_SIZE) + Vector2(TILE_SIZE / 2, TILE_SIZE / 2)

func _random_tilemap_position() -> Vector2i:
	return Vector2i(randi() % BASE_SIZE.x, randi() % BASE_SIZE.y)

func _player_can_walk_to(pos: Vector2) -> bool:
	var tilepos = _position_to_tilemap(pos)
	var tile = tilemap.get_cell_tile_data(0, tilepos)
	if tile == null:
		return false

	return tile.get_custom_data("walkable")
