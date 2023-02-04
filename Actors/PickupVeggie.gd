extends KinematicBody2D

var ready = false;
var picked_up = false;
var is_pickable = false;
var run_speed = 250
var velocity = Vector2.ZERO
var player = null

func _ready():
	$Timer.connect("timeout", self, "on_timeout");

func on_timeout():
	ready = true;
	
func _on_Area2D_body_entered(body):
	if ready && not picked_up:
		is_pickable = true;
		player = body;
		body.emit_signal("on_picked_up", self)
		picked_up = true;


func _on_Area2D_body_exited(body):
	is_pickable = false;


func _physics_process(delta):
	pass
#	velocity = Vector2.ZERO
#	if player:
#		velocity = position.direction_to(player.position) * run_speed
#	velocity = move_and_slide(velocity);
