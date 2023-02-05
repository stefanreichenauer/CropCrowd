extends Area2D


var amount_to_collect = 10;

signal collect_veggie;
export (Resource) var followers
export (Resource) var points;

var veggie_type: int = PickupVeggie2.Type.CARROT;

func _ready():
	var veggie_types = [PickupVeggie2.Type.CARROT]
	veggie_type = veggie_types[randi() % veggie_types.size()]
	connect("collect_veggie", self, "on_collect_veggie");
	$Sprite/VeggieCount.text = str(amount_to_collect);

func on_collect_veggie(player):
	followers.reduce_followers(1);
	var found = followers.remove_follower(veggie_type, player);
	if found:
		amount_to_collect -= 1;
		points.add_points(player);
		$Sprite/VeggieCount.text = str(amount_to_collect);
		if amount_to_collect <= 0:
			queue_free();


func _on_LoadingZone_body_entered(body):
	
	print("Player entered")


func _on_LoadingZone_area_entered(area):
	print("Player entered area")
