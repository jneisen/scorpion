extends CharacterBody2D

@export var rotation_speed : float
@export var forward_speed : int

var player_rotation = 0
var player_movement = Vector2.ZERO
var forward_direction = Vector2(0, -1)
@onready var marker = $Marker2D

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
		player_movement = Vector2(forward_speed, 0)
	else:
		player_movement = Vector2(smooth_to_zero(player_movement.x), 0)
		
func _physics_process(delta: float) -> void:
	# rotate and then set rotation to zero
	rotate(player_rotation * delta)
	
	forward_direction = marker.global_position - global_position
	velocity = forward_direction * player_movement.x
	move_and_slide()

func smooth_to_zero(value):
	return value * 0.95
	
