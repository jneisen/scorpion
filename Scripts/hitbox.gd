extends CollisionObject2D

@export var health = 3
@export var death_sprite : Texture2D
@onready var collider = $CollisionShape2D
@onready var sprite = $Sprite2D

var scaleAnimation = false
@onready var initialScale = sprite.scale
@onready var targetScale = sprite.scale * 1.25
var time = 0

func set_health(healthToSet):
	health = healthToSet

func get_health():
	return health;

func takeDamage():
	health -= 1
	z_index = 3
	if(health <= 0): deleteObject()
	else: scaleAnimation = true

func takeDamageAmount(damageAmount):
	health -= damageAmount
	z_index = 3
	if(health <= 0): deleteObject()
	else: scaleAnimation = true

func deleteObject():
	z_index = -2
	collider.queue_free()
	sprite.texture = death_sprite
	
func _process(delta: float) -> void:
	if(scaleAnimation):
		time += delta * 4
		if(time < 1):
			sprite.scale = lerp(sprite.scale, targetScale, time)
		elif(time < 2):
			sprite.scale = lerp(sprite.scale, initialScale, time - 1)
		else:
			scaleAnimation = false
			time = 0
