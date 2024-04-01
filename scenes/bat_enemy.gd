extends CharacterBody2D

const speed = 50

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var exclaim_sprite := $ExclaimationMark as AnimatedSprite2D

# follow only if the player is in range
@export var trigger_distance: float
var did_spotted_anim = false 

func _physics_process(_delta:float) -> void:
	
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	
	if (nav_agent.distance_to_target() <= trigger_distance):
		if (!did_spotted_anim):
			# if we haven't shown the surprise anim yet, do it.
			exclaim_sprite.show()
			animate_spotted()
		move_and_slide()
	else:
		# we are out of range, so we can show the anim again when we are in range again
		did_spotted_anim = false
	

func make_path() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	# make a path every _ seconds
	make_path() 

func animate_spotted():
	exclaim_sprite.play("default")
	did_spotted_anim = true

func _on_exclaimation_mark_animation_finished():
	exclaim_sprite.hide()
