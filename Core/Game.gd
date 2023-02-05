extends Node

var start_count = 3;
var game_timer = 60;
var end_timer = 3;

export (Resource) var followers
export (Resource) var points;

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true;
	$CanvasLayer/TimerUI/Label.text = str(game_timer);
	points.reset();
	followers.reset();

func _process(delta):
#	$CanvasLayer/CenterContainer/CountdownLabel.text = str($GameStartTimer.wait_time);
	if Input.is_action_just_pressed('ui_cancel'):
		get_tree().quit();


func _on_GameStartTimer_timeout():
	start_count -= 1;
	$CanvasLayer/ColorRect/CountdownLabel.text = str(start_count);
	if start_count <= 0:
		$GameStartTimer.stop();
		get_tree().paused = false;
		$CanvasLayer/ColorRect.visible = false;


func _on_GameTimer_timeout():
	game_timer -= 1;
	$CanvasLayer/TimerUI/Label.text = str(game_timer);
	if game_timer <= 0:
		$CanvasLayer/VictoryScreen.show_victory_screen();
		get_tree().paused = true;
		yield(get_tree().create_timer(3), "timeout");
		get_tree().reload_current_scene();
