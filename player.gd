extends CharacterBody2D


@export var speed = 350  # speed in pixels/sec

@onready var ui_master = get_node("../CanvasLayer/UI")
@onready var ui_text = ui_master.get_node("VBoxContainer/HBoxContainer/Label")
@onready var ui_image_fight = ui_master.get_node("fight_screen")
@onready var ui_image_skip = ui_master.get_node("skip_screen")
@onready var ui_image_minigame = ui_master.get_node("minigame_screen")

var hp =3;

signal door_interact
signal enemy_interact

var is_colliding = false
var door = { 
	"fight" : "door_area_fight",
	"minigame" : "door_area_minigame",
	"skip" : "door_area_skip"
}

func _ready():
	pass
	
func get_input():
	#Movement
	
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed
	
	#Interaction
	if Input.is_action_just_pressed("interact"):
		if is_colliding:
			match door:
				"fight":
					door_interact.emit("fight")
					var enemy = load("res://enemy.tscn")
					var enemy_instanced = enemy.instantiate()
					get_node(".").add_child(enemy_instanced)
				"skip":
					door_interact.emit("skip")
				"minigame":
					door_interact.emit("minigame")
		else:
			ui_image_fight.visible = false
			ui_image_minigame.visible = false
			ui_image_skip.visible = false
			ui_text.visible = true
	if $RayCast2D.is_colliding():
		if Input.is_action_just_pressed("interact"):
			var collider = $RayCast2D.get_collider()
			print(collider.name)
			if collider.name=="Enemy":
				print("Colliding with " +$RayCast2D.get_collider().name)
				emit_signal("enemy_interact")
				
					
			

func _physics_process(delta):
	get_input()
	move_and_slide()


func _on_area_2d_area_entered(area):
	is_colliding = true
	print("Colliding with " + area.name)
	match area.name:
		"door_area_fight":
			door = "fight"
		"door_area_minigame":
			door = "minigame"
		"door_area_skip":
			door = "skip"
			
func _on_area_2d_area_exited(area):
	is_colliding = false
			

func _on_door_interact(area):
	match door:
		"fight":	
			match ui_image_fight.visible:
				true:
					#ui_image_fight.visible = false
					ui_text.text =""
				false:
					#ui_image_fight.visible = true
					ui_text.text ="Enemy room"
				_: pass
		"skip":	
			match ui_image_skip.visible:
				true:
					ui_image_skip.visible = false
				false:
					ui_image_skip.visible = true
				_: pass
		"minigame":	
			match ui_image_minigame.visible:
				true:
					ui_image_minigame.visible = false
				false:
					ui_image_minigame.visible = true
				_: pass
	
