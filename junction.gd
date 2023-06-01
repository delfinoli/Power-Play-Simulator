extends Area2D

var clickPos = Vector2(0,0)
var canDraw = false
var inJunction = false
var currentBody

var redOwns

@export
var score = 5
@export
var id=[0,0]

var coneColor

# Called when the node enters the scene tree for the first time.
func _ready():
	clickPos = Vector2(position.x, position.y)
	pass # Replace with function body.

func _draw():
	if canDraw == true:
		draw_circle(Vector2(0,0),10,coneColor)
		
func _process(delta):
	if inJunction == true:
		if Input.is_action_just_pressed("leftClick"):
			clickPos = get_local_mouse_position()
		if currentBody.clickPos.distance_to(position) <= 20 and currentBody.hasCone == true and currentBody.inSubstation == false:
			currentBody.hasCone = false
			if currentBody.red == true:
				global.redScore += score
				coneColor = Color(255,0,0)
				if redOwns == null:
					global.redScore +=3
				elif redOwns == false:
					global.redScore += 3
					global.blueScore -= 3
				redOwns = true
				global.ownership[id[0]][id[1]] = false
			else:
				global.blueScore += score
				coneColor = Color(0,0,255)
				if redOwns == null:
					global.blueScore +=3
				elif redOwns == true:
					global.redScore -= 3
					global.blueScore += 3
				redOwns = false
				global.ownership[id[0]][id[1]] = true
			queue_redraw()
			print(global.ownership)

func _on_body_entered(body):
	if body.name == "Robot" or body.name == "oponent":
		canDraw = true
		inJunction = true
		currentBody = body
		print("entered " + str(id[0]) + ", " + str(id[1]))

func _on_body_exited(body):
	inJunction = false
