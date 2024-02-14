extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	var label = get_node("VBoxContainer/HBoxContainer/Label")
	label.text = "Use WASD to Move, SPACE to interact"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
