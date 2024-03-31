extends Node
#@onready var points_label = %Label
@onready var blue_label = %"blue label"
@onready var purple_label = %"purple label"

var blue_gems = 0 
var purple_gems = 0

func add_blue(): 
	if(purple_gems != 4 and blue_gems != 4):
		blue_gems += 1
		print(blue_gems)
	#points_label.text = "Blue Gems: " + str(blue_gems) 
	#points_label.text = "Purple Gems: " + str(purple_gems) 
		blue_label.text = "Blue Gems: " + str(blue_gems)
		purple_label.text = "Purple Gems: " + str(purple_gems)
	else: 
		get_tree().change_scene_to_file("res://scenes/end.tscn")
	
func add_purple(): 
	if(purple_gems != 4 and blue_gems != 4):
		purple_gems += 1
		print(purple_gems)
	#points_label.text = "Purple Gems: " + str(purple_gems) 
	#points_label.text = "Purple Gems: " + str(blue_gems) 
		blue_label.text = "Blue Gems: " + str(blue_gems)
		purple_label.text = "Purple Gems: " + str(purple_gems)
	else: 
		get_tree().change_scene_to_file("res://scenes/end.tscn")
	

	
	

