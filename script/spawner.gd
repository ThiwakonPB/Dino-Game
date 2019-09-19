extends Node

#refrence 
const obj_cactuse = preload("res://obj_cactuse.tscn")
#adjustable values
export var pos = Vector2()
export (float) var min_timer = 0
export (float) var max_timer = 0 

func _ready():
	_spawn()
	pass 
	
func _spawn() :
	while true :
		#randomize the seed
		randomize()
		#int
		var obj = obj_cactuse.instance()
		#setting the position
		obj.position = pos 
		#adds the obj to this node
		get_node("container").add_child(obj)
		#timer for the loop 
		yield(get_tree().create_timer(rand_range(min_timer,max_timer)), "timeout")