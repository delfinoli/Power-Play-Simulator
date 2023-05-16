extends Area2D

var clickPos = Vector2(0,0)
var canDraw = false

var redOwns

@export
var score = 5

var coneColor

# Called when the node enters the scene tree for the first time.
func _ready():
	clickPos = Vector2(position.x, position.y)
	pass # Replace with function body.

func _draw():
	if canDraw == true:
		draw_circle(Vector2(0,0),10,coneColor)

func _on_body_entered(body):
	if body.name == "Robot":
		canDraw = true
		if Input.is_action_just_pressed("leftClick"):
			clickPos = get_local_mouse_position()
		if body.atTarget == true and body.hasCone == true and body.inSubstation == false:
			body.hasCone = false
			if body.red == true:
				global.redScore += score
				coneColor = Color(255,0,0)
				if redOwns == null:
					global.redScore +=3
				elif redOwns == false:
					global.redScore += 3
					global.blueScore -= 3
				redOwns = true
			else:
				global.blueScore += score
				coneColor = Color(0,0,255)
				if redOwns == null:
					global.blueScore +=3
				elif redOwns == true:
					global.redScore -= 3
					global.blueScore += 3
				redOwns = false
			queue_redraw()
