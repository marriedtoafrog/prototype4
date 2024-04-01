extends Node
@onready var blue_label = %"blue label"
@onready var purple_label = %"purple label"

var blue_gems = 0 
var purple_gems = 0

func add_blue(): 
	if not(purple_gems >= 4 && blue_gems >= 4): 
		blue_gems += 1
		print(blue_gems)
		blue_label.text = "Blue Gems: " + str(blue_gems)
		purple_label.text = "Purple Gems: " + str(purple_gems)
	
	check_end_scene()
		
func add_purple(): 
	if not(purple_gems >= 4 && blue_gems >= 4): 
		purple_gems += 1
		print(purple_gems)
		blue_label.text = "Blue Gems: " + str(blue_gems)
		purple_label.text = "Purple Gems: " + str(purple_gems)
	check_end_scene() 
	
func check_end_scene():
	print("end_scene called: blue_gems =", blue_gems, "purple_gems =", purple_gems) 
	if(purple_gems >= 4 && blue_gems >= 4):
		get_tree().change_scene_to_file("res://scenes/end.tscn")
	

	
	

