extends Sprite2D


# I have no clue why the modulate decides to be in full, TRANSPARENCY PLZ!
func _ready():
	modulate = Color(1,1,1,0)

func _input(event):
	if(Input.is_action_just_pressed("ui_cancel")):
		modulate = Color(1,1,1,0)
