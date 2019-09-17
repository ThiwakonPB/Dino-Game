extends KinematicBody2D

var velocity = Vector2()
const GROUND = Vector2(0,-1)


var speed = 200
var jump = 400
var gravity = 20
var is_falling : bool = false  # This bool is true when Dino is falling (velocity.y > 0) checkout function handle_falling

func _ready():
	pass
	
	
func _physics_process(delta):
	_debug_print() # Only printing stuff
	
	_handle_falling()
	_move()
	_gravity()
	_jump()
	velocity = move_and_slide(velocity, GROUND)
	pass
	
func _debug_print(): # This function is just for printing debuging thigns
	print('is_falling: %s'%is_falling)
	
func _jump(): # added proper jump mechanic which player can choose jump height base on their release timing of jump button
	if Input.is_action_pressed("ui_up") && is_on_floor(): 
		velocity.y -= jump
	elif Input.is_action_just_released("ui_up") && !is_falling:
		velocity.y = 0
	
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
		
		
		
		
		
		
		
		
	
