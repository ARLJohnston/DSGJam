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

var sprites = [
	"1",
	"2",
	"3"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	self_modulate = Color(colours.pick_random())
	rotation_degrees = randi_range(0,359)
	self.rotate(rotation_degrees)
	var image_resource = "assets/flower_petals_" + sprites.pick_random() + ".png"
	texture = load(image_resource)
