extends Area2D

var clickPos = Vector2(0,0)
var canDraw = false

# Called when the node enters the scene tree for the first time.
func _ready():
	clickPos = Vector2(position.x, position.y)
	pass # Replace with function body.

func _draw():
	if canDraw == true:
		draw_circle(Vector2(0,0),15,Color(255,0,0))

func _on_body_entered(body):
	canDraw = true
	if Input.is_action_just_pressed("leftClick"):
		clickPos = get_local_mouse_position()
	if global.atTarget == true and global.hasCone == true and global.inSubstation:
		global.hasCone = false
		global.score += 5
		queue_redraw()
