extends Sprite2D

var noise : Image
var base : Image

func _ready() -> void:
	noise = load("res://Sprites/perlin_noise.png")
	base = load("res://Sprites/ground.png")
	#add the noise texture to the current texture
	base.blend_rect(noise, base.get_used_rect(), Vector2i.ZERO)
	var made = ImageTexture.create_from_image(base)
	texture = made;
