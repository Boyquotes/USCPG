extends Node2D


func _ready():
	get_tree().connect("network_peer_connected", self, "_connected")

func _on_HostButton_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(6969,2)
	get_tree().set_network_peer(peer)


func _on_JoinButton_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client("127.0.0.1", 6969)
	get_tree().set_network_peer(peer)

func _connected(client_id):
	PlayerSpawn.user_id = client_id
	var game = preload("res://Scenes/MPTest.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()



func _on_SingleButton_pressed():
	var game = preload("res://Scenes/test.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()


func _on_CloseButton_pressed():
	get_node("Container").show()
	get_node("Container2").hide()
	get_node("gradient").hide()
	get_node("Version").show()


func _on_StartButton_pressed():
	get_node("Container2").show()
	get_node("Container").hide()
	get_node("gradient").show()
	get_node("Version").hide()


func _on_QuitButton_pressed():
	get_tree().quit()
