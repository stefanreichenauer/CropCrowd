extends Resource

var points_p1 = 0;
var points_p2 = 0;

signal change_points_p1;
signal change_points_p2;

	
func reset():
	points_p1 = 0;
	points_p2 = 0;
	

func add_points(player):
	if player == 1:
		points_p1 += 1;
		emit_signal("change_points_p1", points_p1);
	else:
		points_p2 += 1;
		emit_signal("change_points_p2", points_p2);

func get_points(player):
	if player == 1:
		return points_p1;
	else:
		return points_p2;
