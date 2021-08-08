extends Spatial


onready var player_pos = $Spawn


func _ready():
	var player = preload("res://Scenes/Player2.tscn").instance()
	player.global_transform = player_pos.global_transform
	add_child(player)


func _process(_delta):
	if GameRun.show_counter == 0:
		$FPSCounter.hide()
	if GameRun.show_counter == 1:
		$FPSCounter.show()
