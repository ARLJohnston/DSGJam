class_name Element

var name: String
var created_by
var resource
var color
	
func _init(name: String, created_by = [], color="#FFFFFF", resource = "res://assets/elements/"+name+".png"):
	self.name = name
	self.created_by = created_by
	self.color = color
	self.resource = resource
