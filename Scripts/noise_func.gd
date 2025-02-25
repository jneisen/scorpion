extends Sprite2D

var noise = load("res://Sprites/Geometry/perlin_noise.png")
var base = load("res://Sprites/Geometry/ground.png")

func redraw():
	base.blend_rect(noise, base.get_used_rect(), Vector2i.ZERO)
	var made = ImageTexture.create_from_image(base)
	texture = made;
	
func setPosition(x : float, y : float):
	global_position = Vector2(x, y)
	newNoise()

func addPosition(x : float, y: float):
	global_position += Vector2(x, y)
	newNoise()

func newNoise():
	#using the position we have to figure out the noise sample
	redraw()
	return
