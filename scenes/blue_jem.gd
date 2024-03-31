extends Area2D

@onready var game_manager = %"game manager"

var is_collected = false
func _on_body_entered(body):
	if(body.name == "main character") and not is_collected:
		is_collected = true
		$"../GemNoise".play()
		#queue_free()
		hide()
		queue_free()
		game_manager.add_blue()
#	if(body.name == "main character"):
#		queue_free()
#		game_manager.add_blue()
