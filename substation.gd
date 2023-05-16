extends Area2D

@export
var red = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Robot":
		body.inSubstation = true
		print("in substation: ", body.inSubstation)
		if body.red == true:
			if body.hasCone == false and global.redSubstationCones != 0:
				body.hasCone = true
				global.redSubstationCones -= 1
		else:
			if body.hasCone == false and global.blueSubstationCones != 0:
				body.hasCone = true
				global.blueSubstationCones -= 1
		


func _on_body_exited(body):
	if body.name == "Robot":
		body.inSubstation = false
