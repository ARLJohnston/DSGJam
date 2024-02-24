class_name Element

var name: String
var created_by
var resource
	
func _init(name: String, created_by = [], resource = "res://assets/elements/"+name+".png"):
	self.name = name
	self.created_by = created_by
	self.resource = resource
