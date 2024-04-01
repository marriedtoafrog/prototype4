extends CharacterBody2D

@export var moveSpeed : float = 150
@export var startingDirection : Vector2 = Vector2(0,1)

# parameters/idle/blend_position 
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")	
@onready var grass_footstep = $"GrassFootstep"

func _ready(): 
	update_animation_parameters(startingDirection)

func _physics_process(_delta):
	#gets input direction 
	#x = horizontal movement and y = vertical movement 
	var inputDirection = Vector2(
		Input.get_action_strength("right") - 
		Input.get_action_strength("left"),
		Input.get_action_strength("down") - 
		Input.get_action_strength("up")) #Positive value 
		
	update_animation_parameters(inputDirection)
		
#updates velocity
	velocity = inputDirection.normalized() * moveSpeed 
	
#move and slide function uses velocity of character body
	move_and_slide() 
	pick_new_state()
	
func update_animation_parameters(moveInput : Vector2):
	if(moveInput != Vector2.ZERO): 
		animation_tree.set("parameters/idle/blend_position", moveInput)
		animation_tree.set("parameters/walk/blend_position", moveInput)

func pick_new_state(): 
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
		
func play_grass_footstep():
	#grass_footstep.pitch_scale = randf_range(-0.8, 1)
	grass_footstep.volume_db = randf_range(-20,-18)
	grass_footstep.play()
