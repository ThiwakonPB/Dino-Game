extends KinematicBody2D

var velocity = Vector2()
const GROUND = Vector2(0,-1)


var speed = 200
var jump = 400
var gravity = 20


func _ready():
	pass
	
	
func _physics_process(delta):
	_move()
	_gravity()
	_jump()
	velocity = move_and_slide(velocity)
	pass
	
func _jump():
	if Input.is_action_just_pressed("ui_up"):
		velocity.y -= jump
	pass
func _move():
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	else:
		velocity.x = 0
		
func _gravity():
	velocity.y += gravity
	
