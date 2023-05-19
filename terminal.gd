extends Area2D

@export
var red = true

@export 
var num = 1

var clickPos = Vector2(0,0)
var canDraw = false
var Owned = false
var coneColor
var clickedIn
var inTerminal


# Called when the node enters the scene tree for the first time.
func _ready():
	clickPos = Vector2(position.x, position.y)
	pass # Replace with function body.

func _draw():
	if canDraw == true:
		draw_circle(Vector2(20,-20),10,coneColor)
		
func _process(delta):
	if Input.is_action_just_pressed("leftClick"):
		if inTerminal == true:
			clickedIn = true
		else:
			clickedIn = false

func _on_body_entered(body):
	if body.name == "Robot":
		canDraw = true
		if Input.is_action_just_pressed("leftClick"):
			clickPos = get_local_mouse_position()
		if clickedIn and body.hasCone == true and body.inSubstation == false:
			body.hasCone = false
			if body.red == true and red == true:
				global.redScore += 1
				coneColor = Color(255,0,0)
			elif body.red == false and red == false:
				global.blueScore += 1
				coneColor = Color(0,0,255)
			queue_redraw()

func _on_mouse_entered():
	inTerminal = true

func _on_mouse_exited():
	inTerminal = false
