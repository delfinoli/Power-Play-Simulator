extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$score.text = "Score: " + str(global.score)
	$conesInSubstation.text = "Cones in Substation: " + str(global.substationCones)
