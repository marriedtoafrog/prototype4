extends CharacterBody2D

#for enemy 
#var enemy_inattack = false 
var enemy_cooldown = true 
var health = 100 
var player_alive = true 

@export var moveSpeed : float = 150
@export var startingDirection : Vector2 = Vector2(0,1)

# parameters/idle/blend_position 
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")	
@onready var grass_footstep = $"GrassFootstep"

func _ready(): 
	update_animation_parameters(startingDirection)

func _physics_process(_delta):
	#enemy_attack()  
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
	
##check player health
	if health <= 0: 
		player_alive = false 
		health = 0 
		print("player has been killed")
		get_tree().change_scene_to_file("res://scenes/death scene.tscn")  
	
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
	grass_footstep.volume_db = randf_range(-10,-5)
	grass_footstep.play()

#connects with bat_enemy health 
func lost_health(): 
	health = health - 20 
	print("player health: " + str(health))

	
#enemy attack 
#func player(): 
#	pass 

#func _on_player_hitbox_body_entered(body):
	#if body.is_in_group("bat enemy"):
#		enemy_inattack = true 

#func _on_player_hitbox_body_exited(body):
#	if body.is_in_group("bat enemy"):
#		enemy_inattack = false 
		
#func enemy_attack():
#	if (enemy_inattack == true): 
#		print("player took damage")
		


