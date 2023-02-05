class_name Rabbit
extends KinematicBody2D

enum MoveDirection {LEFT, RIGHT}

var _move_direction = MoveDirection.LEFT;
var _velocity = Vector2(-100,0);
export (Resource) var followers

signal spawn;

func _ready():
	connect("spawn", self, "on_spawn");

func _physics_process(delta):
	var velocity = _velocity;
	velocity = move_and_slide(velocity);
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider is PickupVeggie2:
			followers.remove_distinct_follower(collision.collider);
#			collision.collider.queue_free();
			
	if abs(position.x) > 1000:
		queue_free();		

func on_spawn(facing_left):
	print(facing_left)
	if facing_left:
		_velocity = Vector2(-100,0);
		$AnimatedSprite.flip_h = false;
	else:
		_velocity = Vector2(100,0);
		$AnimatedSprite.flip_h = true;
	
