extends Camera2D

@export var marker : Marker2D

const FOLLOW_SPEED = 0.1

func _physics_process(_delta: float) -> void:
	position = position.lerp(marker.global_position, FOLLOW_SPEED)
