extends Spatial

onready var playerPos = $Spawn

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var player = preload("res://Scenes/Player2.tscn").instance()
	player.set_name(str(get_tree().get_network_unique_id()))
	player.set_network_master(get_tree().get_network_unique_id())
	player.global_transform = playerPos.global_transform
	add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
