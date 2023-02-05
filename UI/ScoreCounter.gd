extends Panel

export (Resource) var points;

export var player = 1;

func _ready():
	if player == 1:
		points.connect("change_points_p1", self, "on_change_points");
	else:
		points.connect("change_points_p2", self, "on_change_points");		

func on_change_points(new_value):
	$Label.text = str(new_value);
