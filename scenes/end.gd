extends Node

func _on_go_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/start menu.tscn")

func _on_restart_game_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
