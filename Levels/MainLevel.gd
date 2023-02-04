extends Node


const LIMIT_LEFT = -315
const LIMIT_TOP = -250
const LIMIT_RIGHT = 955
const LIMIT_BOTTOM = 690

var goatSpawner = [];
var rand = RandomNumberGenerator.new()
var veggieScene = load("res://Actors/PickupVeggie2.tscn");
var goatScene = load("res://Actors/Goat.tscn");

var veggie_offset = 20;

func _ready():
	$VeggieGrowTimer.connect("timeout", self, "on_timeout");
	$GoatSpawnTimer.connect("timeout", self, "on_GoatSpawnTimer_timeout");
	goatSpawner = get_tree().get_nodes_in_group("GoatSpawner");

func on_timeout():
	rand.randomize()	
	var screen_size = get_viewport().get_visible_rect().size
	var x = rand.randf_range(-screen_size.x/2+veggie_offset,screen_size.x/2-veggie_offset)
	rand.randomize()
	var y = rand.randf_range(-screen_size.y/2+veggie_offset,screen_size.y/2-veggie_offset)
	var veggie = veggieScene.instance()
	veggie.position.y = y
	veggie.position.x = x
	add_child(veggie)
	
	
func on_GoatSpawnTimer_timeout():
	rand.randomize()	
	var spawner = goatSpawner[randi() % goatSpawner.size()]
	var goat = goatScene.instance()
	goat.position = spawner.position;
	
	if spawner.direction == "left":
		goat._velocity = Vector2(-100,0);
	else:
		goat._velocity = Vector2(100,0);	
	add_child(goat)
	
	
	
	
	
	
