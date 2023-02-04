extends Resource


signal follower_count_changed

var current_value = 0

	

func reduce_followers(amount):
	current_value = max(0, current_value - amount)
	emit_signal("follower_count_changed", current_value)
	

func increase_followers(amount):
	current_value = current_value + amount
	emit_signal("follower_count_changed", current_value)
