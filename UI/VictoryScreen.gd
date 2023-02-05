extends Control

export (Resource) var points;

func _ready():
	pass

func show_victory_screen():
	visible = true;
	print("fff")
	if points.points_p1 > points.points_p2:
		$ColorRect/Label.text = "Player 1 wins"
	elif points.points_p1 < points.points_p2:
		$ColorRect/Label.text = "Player 2 wins"
	else:
		$ColorRect/Label.text = "Draw"
