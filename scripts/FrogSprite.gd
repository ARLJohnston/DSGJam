extends Sprite2D

var colours = [
	"#000080",
	"#0000FF",
	"#0040FF",
	"#0080FF",
	"#00BFFF",
	"#00FFFF",
	"#40FFBF",
	"#80FF80",
	"#BFFF40",
	"#FFFF00",
	"#FFD700",
	"#FFA500",
	"#FF8000",
	"#FF4000",
	"#FF0000",
	"#FF4040",
	"#FF8080",
	"#FFBFBF",
	"#FFD9D9",
	"#FFFFFF" 
]

# Called when the node enters the scene tree for the first time.
func _ready():
	self_modulate= Color(colours.pick_random()) 

#func _input(event):
#	if event is InputEventMouseButton:
#		_ready()
#	
