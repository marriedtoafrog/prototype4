extends CharacterBody2D

var speed = 50
var playerChase = false 
var player = null 

func _physics_process(delta):
	if playerChase:
		position += (player.position - position).normalized() * speed * delta
		move_and_collide(Vector2(0,0)) 
		if(player.position.x - position.x) < 0: 
			#$AnimatedSprite2D.flip_h = true 
			$AnimatedSprite2D.play("move left")
			#$AnimatedSprite2D.flip_h = true #going left 
		else: 
			#$AnimatedSprite2D.flip_h = false 
			$AnimatedSprite2D.play("move right")
			
	else:
		velocity = lerp(velocity, Vector2.ZERO, 0.05)
		move_and_collide(velocity) 
		$AnimatedSprite2D.play("move front") 
		
		
		
#enters the zone 
func _on_detection_area_body_entered(body):
	player = body 
	playerChase = true 


func _on_detection_area_body_exited(body):
	player = null 
	playerChase = false 
