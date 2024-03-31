extends Node
#@onready var points_label = %Label
@onready var blue_label = %"Blue Label"
@onready var purple_label = %"Purple Label"

var blue_gems = 0 
var purple_gems = 0

func add_blue(): 
	blue_gems += 1
	print(blue_gems)
	#points_label.text = "Blue Gems: " + str(blue_gems) 
	#points_label.text = "Purple Gems: " + str(purple_gems) 
	blue_label.text = "Blue Gems: " + str(blue_gems)
	purple_label.text = "Purple Gems: " + str(purple_gems)
	
func add_purple(): 
	purple_gems += 1
	print(purple_gems)
	#points_label.text = "Purple Gems: " + str(purple_gems) 
	#points_label.text = "Purple Gems: " + str(blue_gems) 
	blue_label.text = "Blue Gems: " + str(blue_gems)
	purple_label.text = "Purple Gems: " + str(purple_gems)
	
	

