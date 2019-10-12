extends Node



func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS  # work in pause mode
	pass

func _process(delta):
	pass

func _input(event):
	if Input.is_key_pressed(82):
		get_tree().change_scene("res://scene/stage01.tscn")
		get_tree().paused = false
		print("Restart")
	pass