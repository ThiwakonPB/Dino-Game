extends KinematicBody2D


# Configurable
var speed = 200
var jump = 1200
var gravity = 50
var is_falling : bool = false  # This bool is true when Dino is falling (velocity.y > 0) checkout function handle_falling

# cache
var velocity = Vector2()
const GROUND = Vector2(0,-1)
var jump_release : bool = false # Use to help with jump level height

# signal
signal dino_dead
signal dino_jump

func _ready():
	pass
	
	
func _physics_process(delta):
	
	_handle_falling()
	_move()
	_gravity()
	_jump()
	velocity = move_and_slide(velocity, GROUND)
	
	pass



func _jump(): 
# added proper jump mechanic which player can choose jump height base on their release timing of jump button
# Implemented jump level height
	if Input.is_action_pressed("ui_up") && is_on_floor(): 
		emit_signal("dino_jump")
		jump_release = false
		velocity.y -= jump
	elif !Input.is_action_pressed("ui_up") && velocity.y == -800:
		velocity.y = -500
		print("Level 1 Jump")
	elif Input.is_action_just_pressed("ui_down") && !is_on_floor():
		velocity.y = 1000

	# elif Input.is_action_just_released("ui_up") && !is_falling:
	# 	velocity.y = 0
	
	
	
func _move():
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	else:
		velocity.x = 0
		
func _gravity():
	velocity.y += gravity
	
func _handle_falling(): # If Dino is falling then is_falling is true
	if velocity.y > 0:
		is_falling = true
	else:
		is_falling = false
		
	


func _on_Area2D_area_entered(area):
	print(area.get_node("./..").name)
	emit_signal("dino_dead")
	queue_free()

	get_tree().paused = true


