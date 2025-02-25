extends Node2D

@export var camera : Camera2D

var groundtile = load("res://Scenes/geometry/ground.tscn")
var center = Vector2.ZERO
var size = Vector2(9600, 9600)
var grounds = []

var temp = []

func _init() -> void:
	for x in range (0, 3):
		grounds.append([])
		temp.append(Sprite2D)
		for y in range(0, 3):
			grounds[x].append(Sprite2D)
	grounds[0][0] = newGroundTile(-size.x, -size.y)
	grounds[0][1] = newGroundTile(0, -size.y)
	grounds[0][2] = newGroundTile(size.x, -size.y)
	grounds[1][0] = newGroundTile(-size.x, 0)
	grounds[1][1] = newGroundTile(0, 0)
	grounds[1][2] = newGroundTile(size.x, 0)
	grounds[2][0] = newGroundTile(-size.x, size.y)
	grounds[2][1] = newGroundTile(0, size.y)
	grounds[2][2] = newGroundTile(size.x, size.y)

func newGroundTile(x : float, y : float) -> Sprite2D:
	var thisGroundTile = groundtile.instantiate()
	thisGroundTile.setPosition(x, y)
	add_child(thisGroundTile)
	#thisGroundTile.setPerlin()
	return thisGroundTile;

func _process(delta: float) -> void:
	if(camera.global_position.x - center.x > size.x / 2):
		for x in range(0,3):
			temp[x] = grounds[x][0]
			grounds[x][0] = grounds[x][1]
			grounds[x][1] = grounds[x][2]
			temp[x].addPosition(3 * size.x, 0)
			grounds[x][2] = temp[x]
		center += Vector2(size.x, 0)
	elif(camera.global_position.x - center.x < -size.x / 2):
		for x in range(0,3):
			temp[x] = grounds[x][2]
			grounds[x][2] = grounds[x][1]
			grounds[x][1] = grounds[x][0]
			temp[x].addPosition(-3 * size.x, 0)
			grounds[x][0] = temp[x]
		center += Vector2(-size.x, 0)
	elif(camera.global_position.y - center.y > size.y / 2):
		for x in range(0,3):
			temp[x] = grounds[0][x]
			grounds[0][x] = grounds[1][x]
			grounds[1][x] = grounds[2][x]
			temp[x].addPosition(0, 3 * size.y)
			grounds[2][x] = temp[x]
		center += Vector2(0, size.y)
	elif(camera.global_position.y - center.y < -size.y / 2):
		for x in range(0,3):
			temp[x] = grounds[2][x]
			grounds[2][x] = grounds[1][x]
			grounds[1][x] = grounds[0][x]
			temp[x].addPosition(0, -3 * size.y)
			grounds[0][x] = temp[x]
		center += Vector2(0, -size.y)
