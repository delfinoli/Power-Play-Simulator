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
var mouseInTerminal = false
var currentBody
var inTerminal


# Called when the node enters the scene tree for the first time.
func _ready():
	clickPos = Vector2(position.x, position.y)
	pass # Replace with function body.

func _draw():
	if canDraw == true:
		draw_circle(Vector2(20,-20),10,coneColor)
		
func _process(delta):
	if inTerminal  == true and Input.is_action_just_pressed("leftClick") and mouseInTerminal == true and currentBody.hasCone == true and currentBody.inSubstation == false:
		currentBody.hasCone = false
		if currentBody.red == true and red == true:
			global.redScore += 1
			coneColor = Color(255,0,0)
		elif currentBody.red == false and red == false:
			global.blueScore += 1
			coneColor = Color(0,0,255)
		queue_redraw()

func _on_body_entered(body):
	if body.name == "Robot":
		canDraw = true
		currentBody = body
		inTerminal = true
		if Input.is_action_just_pressed("leftClick") and mouseInTerminal == true and currentBody.hasCone == true and currentBody.inSubstation == false:
			currentBody.hasCone = false
			if currentBody.red == true and red == true:
				global.redScore += 1
				coneColor = Color(255,0,0)
			elif currentBody.red == false and red == false:
				global.blueScore += 1
				coneColor = Color(0,0,255)
			queue_redraw()

func _on_mouse_entered():
	mouseInTerminal = true

func _on_mouse_exited():
	mouseInTerminal = false

func _on_body_exited(body):
	inTerminal = false
