class_name Plant
extends Node2D

const plant_types = [
	Element.ElementType.FIRE,
	Element.ElementType.WATER,
	Element.ElementType.EARTH,
	Element.ElementType.AIR
]

const plant_type_to_color = {
	Element.ElementType.FIRE: Color(1, 0, 0, 1),
	Element.ElementType.WATER: Color(0, 0, 1, 1),
	Element.ElementType.EARTH: Color(0, 1, 0, 1),
	Element.ElementType.AIR: Color(1, 0.5, 1, 1)
}

@export var plant_type: Element.ElementType

@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.plant_type = plant_types[randi() % plant_types.size()]

	sprite.texture.gradient = sprite.texture.gradient.duplicate()
	sprite.texture.gradient.set_color(0, plant_type_to_color[plant_type])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
