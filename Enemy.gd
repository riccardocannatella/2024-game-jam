extends RigidBody2D


const SPEED = 300
const JUMP_VELOCITY = -400.0

var movement = Vector2()
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hp =3;

func _ready():
	pass
func _process(delta):
	#if a second passed
	#decide if move 
	#if move assign a casual direction
	if ($Timer2.time_left ==0):
		$Timer2.start()
		if(randf()<0.5):
			movement = Vector2()
		else:
			movement = get_random_direction()
		if get_colliding_bodies():
			movement = get_random_direction()
		
	
		
	move_and_collide(movement*SPEED*delta)
	
func get_random_direction():
	var random_direction = Vector2()
	var random_float = randf()
	if (random_float)<0.25:
		random_direction.x = -1;
	elif (random_float)>=0.25 and (random_float)<0.5:
		random_direction.x = 1;	
	elif (random_float)>=0.5 and (random_float)<0.75:
		random_direction.y = -1;	
	else:
		random_direction.y = 1;
		
	return random_direction
