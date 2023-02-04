extends KinematicBody2D

var speed = 500  # speed in pixels/sec
var velocity = Vector2.ZERO

signal on_picked_up
export (Resource) var followers

enum Player { PLAYER_1, PLAYER_2 }
export (Player) var player = Player.PLAYER_1;

var action_suffix = "";
var loading_zone_in_range = null;
onready var viewport_size = get_viewport().get_visible_rect().size;
var limit_offset = 50;

func _ready():
	connect("on_picked_up", self, "_on_PickupVeggie_on_picked_up");
	if followers:
		followers.connect("follower_count_changed", self, "_on_follower_count_changed")
		
	if player == Player.PLAYER_2:
		action_suffix = "_p2";
		$Sprite.texture = load("res://Images/Potato.png");

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('move_right' + action_suffix):
		velocity.x += 1
	if Input.is_action_pressed('move_left' + action_suffix):
		velocity.x -= 1
	if Input.is_action_pressed('move_down' + action_suffix):
		velocity.y += 1
	if Input.is_action_pressed('move_up' + action_suffix):
		velocity.y -= 1
	if Input.is_action_just_pressed('action' + action_suffix):
		if loading_zone_in_range:
			loading_zone_in_range.emit_signal("collect_veggie");
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed
	
	position.x = clamp(position.x, -viewport_size.x/2+limit_offset, viewport_size.x/2-limit_offset)
	position.y = clamp(position.y, -viewport_size.y/2+limit_offset, viewport_size.y/2-limit_offset)

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Veggie"):
		body.emit_signal("on_collide_with_player", self);
		
		


func _on_follower_count_changed(current_value):
	if current_value == 0:
		print("GAME OVER");


func _on_Area2D_area_entered(area):
	if area.is_in_group("LoadingZone"):
		loading_zone_in_range = area;

func _on_Area2D_area_exited(area):
	if area.is_in_group("LoadingZone"):
		loading_zone_in_range = null;
