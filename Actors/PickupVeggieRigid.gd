extends RigidBody2D

var ready = false;
var is_pickable = false;
var run_speed = 250
var velocity = Vector2.ZERO
var player = null

func _ready():
	$Timer.connect("timeout", self, "on_timeout");

func on_timeout():
	ready = true;
	
func _on_Area2D_body_entered(body):
	if ready:
		is_pickable = true;
		player = body;

func _on_Area2D_body_exited(body):
	is_pickable = false;


func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * run_speed
	velocity = apply_central_impulse(velocity);
