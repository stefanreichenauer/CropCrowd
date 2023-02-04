extends Area2D


var amount_to_collect = 10;

signal collect_veggie;


func _ready():
	connect("collect_veggie", self, "on_collect_veggie");

func on_collect_veggie():
	amount_to_collect -= 1;
	print(amount_to_collect)
	if amount_to_collect <= 0:
		queue_free();


func _on_LoadingZone_body_entered(body):
	
	print("Player entered")


func _on_LoadingZone_area_entered(area):
	print("Player entered area")
