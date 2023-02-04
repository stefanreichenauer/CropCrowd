extends KinematicBody2D

enum MoveDirection {LEFT, RIGHT}

var _move_direction = MoveDirection.LEFT;
var _velocity = Vector2(-100,0);

func _physics_process(delta):
	var velocity = _velocity;
	velocity = move_and_slide(velocity);
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider is PickupVeggie2:
			collision.collider.queue_free();
			
	if abs(position.x) > 1000:
		queue_free();		
