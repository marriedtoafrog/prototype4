extends CharacterBody2D

const speed = 50

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D


func _physics_process(_delta:float) -> void:
	
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	#printerr("dir", dir)
	move_and_slide()
	

func make_path() -> void:
	print("making path")
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	make_path() 
