extends CharacterBody2D

@export
var robotNum = 1
@export
var red = true

var hasCone = false
var inSubstation = false
var atTarget = true

var speed = 300.0 
var velo = Vector2(0,0)
var clickPos = Vector2(0,0)

var width = 100
var height = 100
var robotShape = Vector2(width,height)
var robotColor = Color(0,0,0)

var coneColor = Color(255,0,0)


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

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

func _physics_process(delta):
	if Input.is_action_just_pressed("switchColor") and red == true:
		red = false
		coneColor = Color(0,0,255)
	elif Input.is_action_just_pressed("switchColor") and red == false:
		red = true
		coneColor = Color(255,0,0)
	if Input.is_action_just_pressed("leftClick"):
		clickPos = get_global_mouse_position()
		atTarget = false
	
	var targetPos = (clickPos-position).normalized()
	
	if position.distance_to(clickPos) > 3:
		velocity = targetPos * speed
		move_and_slide()
	if position.distance_to(clickPos) < 110:
		atTarget = true
