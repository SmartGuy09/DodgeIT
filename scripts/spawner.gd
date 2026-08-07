extends Node

@onready var nodeL = [$NodeL1, $NodeL2]
@onready var nodeR = [$NodeR1, $NodeR2]

var goodclicker_scene = preload("res://prefabs/goodclicker.tscn")
var badclicker_scene = preload("res://prefabs/badclicker.tscn")

@onready var clickgroup = [
	goodclicker_scene,
	goodclicker_scene,
	badclicker_scene,
	goodclicker_scene
]

var timer := randf_range(0.5, 0.8)

func _process(delta):
	timer -= delta
	if timer <= 0.0 and !GameManager.gameEnded:
		spawn(nodeL)
		spawn(nodeR)
		timer = randf_range(0.5, 0.8)
		
func spawn(node_group):
	var target_node = node_group.pick_random()
	var clicker_scene = clickgroup.pick_random()
	var clicker = clicker_scene.instantiate()
	add_child(clicker)
	clicker.global_position = target_node.global_position
	return clicker
	
	
