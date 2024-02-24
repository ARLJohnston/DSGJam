class_name Element

enum ElementType {
	NULL,
	FIRE,
	WATER,
	AIR,
	EARTH,
	ICE,
	MUD,
	LIGHTNING,
	LAVA
}

static func get_random_element():
	return ElementType.values()[randi() % ElementType.values().size()]

var name: String
var created_by

func _init(name: String, created_by = []):
	self.name = name
	self.created_by = created_by
