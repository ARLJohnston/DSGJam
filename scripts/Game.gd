extends Node2D

@onready var tilemap = $TileMap
@onready var inventory_ui = $inventory

const BASE_SIZE = Vector2(256,256)

var inventory: InventoryGrid
var item: InventoryItem

# Called when the node enters the scene tree for the first time.
func _ready():
	var perlin_noise = FastNoiseLite.new()
	perlin_noise.seed = randi()

	inventory_ui.get_node("CtrlInventoryGrid").show()
	# var deviation = Vector2(randi_range(-50,50), randi_range(-50,50))
		
	for x in (BASE_SIZE.x):
		for y in (BASE_SIZE.y):
			var noise_at_point = (perlin_noise.get_noise_2d(x, y) + 1.0) / 2.0

			if noise_at_point > 0.5:
				tilemap.set_cell(0, Vector2(x, y), 1, Vector2(0, 0))
			else:
				tilemap.set_cell(0, Vector2(x, y), 0, Vector2(0, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
