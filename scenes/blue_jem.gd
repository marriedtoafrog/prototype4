extends Area2D

@onready var game_manager = %"game manager"

func _on_body_entered(body):
<<<<<<< HEAD
	if(body.name == "main character") and not is_collected:
		is_collected = true
		$"../AudioStreamPlayer".play()
		#queue_free()
		hide()
=======
	if(body.name == "main character"):
		queue_free()
>>>>>>> 0c1b84236017f8fc8ae5f9cdd26b2742a2324c60
		game_manager.add_blue()
