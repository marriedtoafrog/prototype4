extends CharacterBody2D

const chase_speed = 50
const wander_speed = 20
const investigate_speed = 33

var wandering_dir = Vector2.ZERO
@export var wander_change: float
var change_wander_dir = false

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var exclaim_sprite := $ExclaimationMark as AnimatedSprite2D
@onready var question_sprite := $QuestionMark as AnimatedSprite2D

@onready var suspicion_timer := $SuspicionTimer as Timer

# When the player is within range, bat STARTS chasing
@export var trigger_distance: float

# if the player makes a noise within this radius, the bat will investigate noise
@export var earshot_radius: float

# is the bat currently pursuing the player (! anim has been played)
var is_chasing = false 

# this flag should be true if the player is out of distance range but making noise.
var is_suspicious = false;

### PHYSICS LOOP ###
func _physics_process(_delta:float) -> void:
	# 3 options: wander (default), investigate, chase
	
	var dir
	var speed
	
	is_suspicious = get_enemy_suspicion()
	is_chasing = get_enemy_chase_status()
				
	# chase if in range
	if (is_chasing):
		dir = to_local(nav_agent.get_next_path_position()).normalized()
		speed = chase_speed
		
	# investigate if suspicious
	elif (is_suspicious):	
		exclaim_sprite.hide()
		animate_suspicious()
		dir = to_local(nav_agent.get_next_path_position()).normalized()
		speed = investigate_speed
		is_chasing = false
	else:
		
		speed = wander_speed
		
		if (change_wander_dir):
			# else, change direction a little bit			
			wandering_dir.x += wander_change * randf_range(-1,1)
			wandering_dir.y += wander_change * randf_range(-1,1)
			change_wander_dir = false
			
		dir = wandering_dir.normalized()
		is_chasing = false
		

	velocity = dir * speed
	wandering_dir = dir
	move_and_slide()
	

	
### AI BEHAVIOR ### 
func make_path() -> void:
	nav_agent.target_position = player.global_position

func _on_path_regen_timeout():
	# make a path every _ seconds
	make_path() 

func _on_suspicion_timer_timeout():
	is_suspicious = false
	question_sprite.hide()
	suspicion_timer.stop()

	print('no longer suspicious!')
	

func _on_change_wander_dir_timeout():
	change_wander_dir = true
	
func get_enemy_suspicion() -> bool:
	# helper function to ask if the bat should be suspicious.
	# conditions: nonzero input and within earshot and NOT seen
	
	var has_nonzero_input: bool = Vector2(Input.get_action_strength("right") - 
		Input.get_action_strength("left"),
		Input.get_action_strength("down") - 
		Input.get_action_strength("up")).length() != 0
		
	var is_within_earshot: bool = self.position.distance_to(player.position) <= earshot_radius
	
	var is_not_seen: bool = nav_agent.distance_to_target() > trigger_distance
	return  has_nonzero_input && is_within_earshot && is_not_seen


func get_enemy_chase_status() -> bool:
	# if already chasing, then chase radius increases
	var chase_boost = 50 if is_chasing else 0
	
	# if not currently chasing but in range, do ! anim
	if ( !is_chasing && nav_agent.distance_to_target() <= trigger_distance ):
		animate_spotted()
		
	return nav_agent.distance_to_target() <= trigger_distance + chase_boost 
 
	
### REACTION SPRITE ANIMATIONS ###
func animate_spotted():
	question_sprite.hide()
	exclaim_sprite.show()	
	exclaim_sprite.play("default")
	is_chasing = true

func _on_exclaimation_mark_animation_finished():
	exclaim_sprite.hide()

func animate_suspicious():
	question_sprite.show()
	exclaim_sprite.hide()
	question_sprite.play("default")
	is_suspicious = true
	suspicion_timer.start()

func _on_question_mark_animation_finished():
	question_sprite.hide()




