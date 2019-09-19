extends Area2D

export var velocity = Vector2()
export var timer = 20 
func _ready():
	#process callback 
	set_process(true)
	pass 
	
func _process(delta):
	translate(velocity * delta)
	timer -= delta
	
	#delete when off screen 
	if timer == 0 :
		queue_free()