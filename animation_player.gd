extends AnimationPlayer

func _ready():
	randomize()
	current_animation = "clap"
	seek(0, true)
	stop()

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		play_clap()
	if Input.is_action_just_pressed("ui_cancel"):
		seek(0, true)
		stop()


func _on_animation_finished(anim_name):
	seek(0, true)
	stop()

func play_clap():
	stop()
	play("explode" if randi() % 5 == 0 else "clap")
