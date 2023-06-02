extends CharacterBody2D

@export
var robotNum = 1
@export
var red = false

var hasCone = false
var inSubstation = false
var atTarget = false

var speed = 150.0 
var clickPos = Vector2(0,0)
@onready var navigationAgent = $NavigationAgent2D
var moveDir = Vector2.ZERO
var lastMoveVelo = Vector2.ZERO

var width = 100
var height = 100
var robotShape = Vector2(width,height)
var robotColor = Color(0,0,0)

var coneColor = Color(0,0,255)

func _ready():
	clickPos = Vector2(position.x, position.y)
	queue_redraw()
	pass

func _draw():
	var rect = Rect2(Vector2(-width/2,-height/2), robotShape)
	draw_rect(rect, robotColor)
	if hasCone == true:
		draw_circle(Vector2(0,0),15,coneColor)

func _process(delta):
	queue_redraw()

func findPole() -> Vector2:
	for y in range(5):
		for x in range(5):
			if global.ownership[x][y] == false:
				return Vector2((x-2)*180,(y-2)*180)
	return Vector2(0,-180)

func findNextPos() -> Vector2:
	if global.blueSubstationCones > 0 or hasCone == true:
		if inSubstation == true:
			return findPole()
		else:
			return Vector2(0,-450)
	else:
		if position.distance_to(Vector2(-490,-490)) < position.distance_to(Vector2(490,490)):
			return Vector2(-490,-490)
		else:
			return Vector2(490,490)


func setTargetPos(target:Vector2) -> void:
	atTarget = false
	navigationAgent.set_target_position(target)

func _physics_process(delta):
	if atTarget == true:
		setTargetPos(findNextPos())
		clickPos = findNextPos()
	
	var moveDir = position.direction_to(navigationAgent.get_next_path_position())
	velocity = moveDir * speed
	lookAtDirection(moveDir)
	navigationAgent.set_velocity(velocity)
	
	if not arrivedAtTarget():
		move_and_slide()
	elif not atTarget:
		atTarget = true

func lookAtDirection(dir:Vector2) -> void:
	dir = dir.normalized()
	moveDir = dir
	

func arrivedAtTarget() -> bool:
	return navigationAgent.is_navigation_finished()
