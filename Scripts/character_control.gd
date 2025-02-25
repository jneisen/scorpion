extends CharacterBody2D

@export var rotation_speed : float
@export var forward_speed : int
@export var backward_speed : int

var player_rotation = 0
var player_movement = 0
var forward_direction = Vector2(0, -1)
@onready var marker = $Marker2D
@onready var attack_raycast2D = $RayCast2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _tail_anim = $TailAnim
@onready var _walking_particles = $GPUParticles2D

func _ready() -> void:
	_tail_anim.play("idle")

func _process(_delta: float) -> void:
	#get the character input
	var left = Input.is_action_pressed("Left")
	var right = Input.is_action_pressed("Right")
	
	if(left && !right):
		player_rotation = -rotation_speed
	elif(right && !left):
		player_rotation = rotation_speed
	else:
		player_rotation = smooth_to_zero(player_rotation)
		
	if(Input.is_action_pressed("Forward")):
		player_movement = forward_speed
	elif(Input.is_action_pressed("Backward")):
		player_movement = -backward_speed
	else:
		player_movement = smooth_to_zero(player_movement)
	
	#animation
	if(abs(player_movement) <= 0.1):
		if(player_rotation == 0):
			_animated_sprite.stop()
		else:
			_animated_sprite.play()
		_walking_particles.emitting = false
	else:
		_animated_sprite.play()
		_walking_particles.emitting = true
		
	if(Input.is_action_pressed("Attack") && _tail_anim.current_animation == "idle"):
		_tail_anim.current_animation = "fire"
		_tail_anim.queue("reset")
		_tail_anim.queue("idle")
		attack_raycast2D.enabled = true
	elif(_tail_anim.current_animation == "idle" || _tail_anim.current_animation == "reset"):
		attack_raycast2D.enabled = false
		
		
func _physics_process(delta: float) -> void:
	#check the attack_raycast
	if(attack_raycast2D.enabled && attack_raycast2D.is_colliding()):
		if(attack_raycast2D.get_collider().collision_layer == 2):
			attack_raycast2D.get_collider().takeDamage()
		attack_raycast2D.enabled = false
	# rotate and then set rotation to zero
	rotate(player_rotation * delta)
	
	forward_direction = marker.global_position - global_position
	velocity = forward_direction * player_movement
	move_and_slide()

func smooth_to_zero(value):
	if(abs(value) < 0.01):
		return 0
	return value * 0.90
