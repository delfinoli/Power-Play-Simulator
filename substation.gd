extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	global.inSubstation = true
	print("in substation: ", global.inSubstation)
	if global.hasCone == false and global.substationCones != 0:
		global.hasCone = true
		global.substationCones -= 1
		


func _on_body_exited(body):
	global.inSubstation = false
