extends Node2D

class_name PlantData

@export var plant_stats = {}
@export var dominant_plant_type = "air"
@export var petal_rotation = 0
@export var main_color = "#FFFFFF"
@export var petal_color = "#FFFFFF"
var main_sprite
var petal_sprite

func _init(plant_stats, petal_rotation, main_sprite, main_color, petal_sprite, petal_color):
	self.plant_stats = plant_stats
	self.petal_rotation = petal_rotation
	self.main_sprite = main_sprite
	self.petal_sprite = petal_sprite
	self.main_color = main_color
	self.petal_color = petal_color
