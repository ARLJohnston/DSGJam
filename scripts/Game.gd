extends Node2D

@onready var player = $Player
@onready var tilemap = $TileMap

@onready var plant_scene = preload("res://scenes/Plant.tscn")


const BASE_SIZE = Vector2(32, 16)
const TILE_SIZE = 64

var items = ItemProtoset
var plants: Array[Plant] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Shift player to the center of the world
	player.position = Vector2(BASE_SIZE.x * TILE_SIZE / 2 + TILE_SIZE/2, BASE_SIZE.y * TILE_SIZE / 2 + TILE_SIZE/2)

	_gen_plants()
	_gen_world()

func _gen_plants():
	for i in range(0, 5):
		var plant = plant_scene.instantiate()

		plant.position = Vector2(randi_range(0, BASE_SIZE.x - 1) * TILE_SIZE, randi_range(0, BASE_SIZE.y - 1) * TILE_SIZE)
		plant.position += Vector2(TILE_SIZE / 2, TILE_SIZE / 2)

		plant.get_node("Area2D").connect("body_entered", _on_plant_overlapped.bind(plant))

		add_child(plant)
		plants.append(plant)

func _gen_world():
	const threshold_to_tiles = {
		0.5: 0,
		0.6: 1,
		0.65: 2,
		0.8: 3,
		1.0: 4,
	}

	var perlin_noise = FastNoiseLite.new()
	perlin_noise.seed = randi()

	for x in (BASE_SIZE.x):
		for y in (BASE_SIZE.y):
			var noise_at_point = (perlin_noise.get_noise_2d(x, y) + 1.0) / 2.0

			var tile = 0
			for threshold in threshold_to_tiles.keys():
				if noise_at_point < threshold:
					tile = threshold_to_tiles[threshold]
					break


			tilemap.set_cell(0, Vector2(x, y), 2, Vector2(tile, 0))

func _on_plant_overlapped(_body, plant):
	var label = $CanvasLayer/Label

	var stats = plant.plant_stats
	var text = ""
	for k in stats.keys():
		text += k + ": " + str(stats[k]) + "\n"

	label.text = text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
