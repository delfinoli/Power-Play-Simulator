extends CharacterBody2D

@export
var robotNum = 1
@export
var red = true

var hasCone = false
var inSubstation = false
var atTarget = false

var speed = 300.0 
var clickPos = Vector2(0,0)
@onready var navigationAgent = $NavigationAgent2D
var moveDir = Vector2.ZERO
var lastMoveVelo = Vector2.ZERO

var width = 100
var height = 100
var robotShape = Vector2(width,height)
var robotColor = Color(0,0,0)

var coneColor = Color(255,0,0)

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

func setTargetPos(target:Vector2) -> void:
	atTarget = false
	navigationAgent.set_target_position(target)

func _physics_process(delta):
	if Input.is_action_just_pressed("switchColor") and red == true:
		red = false
		coneColor = Color(0,0,255)
	elif Input.is_action_just_pressed("switchColor") and red == false:
		red = true
		coneColor = Color(255,0,0)
	if Input.is_action_just_pressed("leftClick"):
		setTargetPos(get_global_mouse_position())
	
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
