extends Node2D

var converted

func _process(delta):
	if $Timer.time_left == 120:
		converted = "2:00"
	elif $Timer.time_left >= 70:
		converted = "1:" + str($Timer.time_left-60)
	elif $Timer.time_left > 60:
		converted = "1:0" + str($Timer.time_left-60)
	elif $Timer.time_left == 60:
		converted = "1:00"
	elif $Timer.time_left >= 10:
		converted = "0:" + str($Timer.time_left)
	else:
		converted = "0:0" + str($Timer.time_left)
	$Clock.text = converted

func _on_timer_timeout():
	$Robot.speed = 0
	$oponent.speed = 0
	if $terminal.inTerminal == true:
		if $terminal.currentBody.red == false:
			global.blueScore += 2
	if $terminal4.inTerminal == true:
		if $terminal4.currentBody.red == false:
			global.blueScore += 2
	if $terminal2.inTerminal == true:
		if $terminal2.currentBody.red == true:
			global.redScore += 2
	if $terminal3.inTerminal == true:
		if $terminal3.currentBody.red == true:
			global.redScore += 2
	if global.redScore > global.blueScore:
		$Winner.text = "Red Wins!"
	elif global.redScore < global.blueScore:
		$Winner.text = "Blue Wins!"
	else:
		$Winner.text = "Tie"
