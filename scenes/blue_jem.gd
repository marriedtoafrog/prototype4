extends Area2D

@onready var game_manager = %"game manager"

func _on_body_entered(body):
	if(body.name == "main character"):
		queue_free()
		game_manager.add_blue()
