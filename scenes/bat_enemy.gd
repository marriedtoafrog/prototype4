extends CharacterBody2D

const speed = 50

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var exclaim_sprite := $ExclaimationMark as AnimatedSprite2D

# follow only if the player is in range
@export var trigger_distance: float
var do_spotted_anim = false 

func _physics_process(_delta:float) -> void:
	
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	
	if (nav_agent.distance_to_target() <= trigger_distance):
		if (!do_spotted_anim):
			exclaim_sprite.show()
			animate_exclaimation()
		move_and_slide()
	else:
		do_spotted_anim = false
		exclaim_sprite.hide()
	

func make_path() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	# make a path every _ seconds
	make_path() 

func animate_exclaimation():
	exclaim_sprite.play("default")
