extends Resource


signal follower_count_changed

var current_value = 0
var following_veggies = [];
var following_veggies_p2 = [];
	
func reset():
	current_value = 0
	following_veggies = [];
	following_veggies_p2 = [];
	

func reduce_followers(amount):
	current_value = max(0, current_value - amount)
	emit_signal("follower_count_changed", current_value)
	

func increase_followers(amount):
	current_value = current_value + amount
	emit_signal("follower_count_changed", current_value)

func add_follower(veggie, player):
	if player == 1:
		following_veggies.push_back(veggie);
	else:
		following_veggies_p2.push_back(veggie);

func remove_follower(type: int, player):
	var found = false;
	if player == 1:
		for i in following_veggies.size():
			if not is_instance_valid(following_veggies[i]):
				break;
			var veggie = following_veggies[i] as PickupVeggie2;
			if veggie.type == type:
				following_veggies.remove(i);
				veggie.queue_free();
				found = true;
				break;
	else:
		for i in following_veggies_p2.size():
			if not is_instance_valid(following_veggies_p2[i]):
				break;
			var veggie = following_veggies_p2[i] as PickupVeggie2;
			if veggie.type == type:
				following_veggies_p2.remove(i);
				veggie.queue_free();
				found = true;
				break;
	return found;

func remove_distinct_follower(follower: PickupVeggie2):
	if following_veggies.find(follower):
		following_veggies.erase(follower);
	else:
		following_veggies_p2.erase(follower);
	follower.queue_free();
