extends CharacterBody2D

const chase_speed = 50
const wander_speed = 20
const investigate_speed = 45

var wandering_dir = Vector2.ZERO
@export var wander_change: float
var change_wander_dir = false

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var exclaim_sprite := $ExclaimationMark as AnimatedSprite2D
@onready var question_sprite := $QuestionMark as AnimatedSprite2D

@onready var suspicion_timer := $SuspicionTimer as Timer

# When the player is within range, the bat chases the player no matter what
@export var trigger_distance: float

# if the player makes a noise within this radius, the bat will investigate noise
@export var earshot_radius: float

# should we play exclaimation?
var did_spotted_anim = false 

# this flag should be true if the player is out of distance range but making noise.
var is_suspicious = false;

### PHYSICS LOOP ###
func _physics_process(_delta:float) -> void:
	# 3 options: wander (default), investigate, chase
	
	var dir;
	var speed;
	
	# chase if in range
	if (nav_agent.distance_to_target() <= trigger_distance):
		dir = to_local(nav_agent.get_next_path_position()).normalized()
		speed = chase_speed
		if (!did_spotted_anim):
			# if we haven't shown the surprise anim yet, do it.
			animate_spotted()
			
		
	# investigate if suspicious
	elif (is_suspicious):	
		animate_suspicious()
		dir = to_local(nav_agent.get_next_path_position()).normalized()
		speed = investigate_speed
		did_spotted_anim = false
	else:
		
		speed = wander_speed
		
		if (change_wander_dir):
			# else, change direction a little bit			
			wandering_dir.x += wander_change * randf_range(-1,1)
			wandering_dir.y += wander_change * randf_range(-1,1)
			change_wander_dir = false
			
		dir = wandering_dir.normalized()
		did_spotted_anim = false
		

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

func _on_change_wander_dir_timeout():
	change_wander_dir = true
	
### REACTION SPRITE ANIMATIONS ###
func animate_spotted():
	exclaim_sprite.show()	
	exclaim_sprite.play("default")
	did_spotted_anim = true

func _on_exclaimation_mark_animation_finished():
	exclaim_sprite.hide()

func animate_suspicious():
	question_sprite.play("default")
	is_suspicious = true
	suspicion_timer.start()

func _on_question_mark_animation_finished():
	question_sprite.hide()




