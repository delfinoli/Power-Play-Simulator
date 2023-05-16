extends Control

@export
var red = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if red == true:
		$score.text = "Score: " + str(global.redScore)
		$conesInSubstation.text = "Cones in Substation: " + str(global.redSubstationCones)
	else:
		$score.text = "Score: " + str(global.blueScore)
		$conesInSubstation.text = "Cones in Substation: " + str(global.blueSubstationCones)
