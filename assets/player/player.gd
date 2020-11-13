extends KinematicBody2D

var velocity = Vector2.ZERO

const ACCELERATION = 100
const MAXSPEED = 50
const FRICTION = 150

onready var animationPlayer = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")


func _physics_process(delta):
	var input_vec = Vector2.ZERO
	input_vec.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vec.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vec = input_vec.normalized()
	
	if input_vec != Vector2.ZERO:
		# print_debug("Moving")
		velocity = velocity.move_toward(input_vec * MAXSPEED, ACCELERATION * delta)
		# animationPlayer.play("WalkRight")
		animTree.set("parameters/Idle/blend_position", input_vec)
		animTree.set("parameters/WalkAnim/blend_position", input_vec)
		animState.travel("WalkAnim")
		
		
	else:
		# print_debug("Staph")
		#animationPlayer.play("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		# velocity = Vector2.ZERO
		animState.travel("Idle")
	velocity = move_and_slide(velocity)
