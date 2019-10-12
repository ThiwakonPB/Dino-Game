extends Node



func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS  # work in pause mode
	pass # Replace with function body.

func _process(delta):
	pass

func _input(event):
	if Input.is_key_pressed(82):
		print("R is press")
	pass