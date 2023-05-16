extends Area2D

var clickPos = Vector2(0,0)
var canDraw = false

var redOwns

@export
var score = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	clickPos = Vector2(position.x, position.y)
	pass # Replace with function body.

func _draw():
	if canDraw == true:
		draw_circle(Vector2(0,0),15,Color(255,0,0))

func _on_body_entered(body):
	if body.name == "Robot":
		canDraw = true
		if Input.is_action_just_pressed("leftClick"):
			clickPos = get_local_mouse_position()
		if body.atTarget == true and body.hasCone == true and body.inSubstation == false:
			body.hasCone = false
			if body.red == true:
				global.redScore += score
				if redOwns == false:
					global.redScore += 3
					global.blueScore -= 3
			else:
				global.blueScore += score
				if redOwns == true:
					global.redScore -= 3
					global.blueScore += 3
			queue_redraw()
