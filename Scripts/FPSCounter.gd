extends Label

func _process(_delta):
	text = ""
	text += "FPS: " + str(Engine.get_frames_per_second())
