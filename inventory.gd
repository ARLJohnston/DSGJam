extends Node2D

const TEST_PROTOSET = preload("res://assets/item_definitions.tres")

@export var inventory: InventoryGrid
var item: InventoryItem

func create_inventory(protoset: ItemProtoset, size: Vector2i) -> InventoryGrid:
	var inv = InventoryGrid.new()
	inv.item_protoset = protoset
	inv.size = size
	return inv

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = create_inventory(TEST_PROTOSET, Vector2i(6, 6))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
