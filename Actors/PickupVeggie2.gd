class_name PickupVeggie2
extends KinematicBody2D

var ready = false;
var picked_up = false;
var is_pickable = false;
var run_speed = 450
var velocity = Vector2.ZERO
var player = null

signal on_collide_with_player;
export (Resource) var follower_veggies

enum Status {GROWING, READY, FOLLOWING}
enum Type {CARROT, POTATO} 
var status = Status.GROWING;

var type = Type.CARROT;

var following_player;

func _ready():
	$Timer.connect("timeout", self, "on_timeout");
	connect("on_collide_with_player", self, "_on_collide_with_player");
	$Sprite.scale.y = 0.01;

func on_timeout():
	ready = true;
	status = Status.READY;
	
func _on_Area2D_body_entered(body):
	if ready && not picked_up:
		is_pickable = true;
		player = body;
		$Sprite.texture = load("res://Images/Carrot.png")
#		body.emit_signal("on_picked_up", self)
#		picked_up = true;


func _on_Area2D_body_exited(body):
	is_pickable = false;

var lerp_time = 0;
func _physics_process(delta):
	match status:
		Status.GROWING:
			lerp_time += delta;
			$Sprite.scale.y  = lerp(0.01 , 0.05, lerp_time/$Timer.wait_time);
		Status.READY:
			pass
		Status.FOLLOWING:	
			velocity = Vector2.ZERO
			if player:
				velocity = position.direction_to(player.position) * run_speed
			velocity = move_and_slide(velocity);
	

func _on_collide_with_player(body, player_number):
	status = Status.FOLLOWING;
	follower_veggies.add_follower(self, player_number);
	$Sprite.texture = load("res://Images/Carrot.png")
	player = body;
	set_collision_layer_bit(0, true);
	follower_veggies.increase_followers(1);
