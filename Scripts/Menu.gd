extends Node2D


var timer_limit = 2.0
var timer = 0.0


func _ready():
# warning-ignore:return_value_discarded
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
	GameRun.user_id = client_id
	var game = preload("res://Scenes/MPTest.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()
	$AudioStreamPlayer.playing = false


func _on_SingleButton_pressed():
	var game = preload("res://Scenes/test.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()
	$AudioStreamPlayer.playing = false


func _on_CloseButton_pressed():
	get_node("Control/Container").show()
	get_node("Control/Container2").hide()
	get_node("gradient").hide()
	get_node("Version").show()


func _on_StartButton_pressed():
	$Control/Container2.show()
	$Control/Container.hide()
	$gradient.show()
	$Version.hide()


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_OptionsButton_pressed():
	$Control/Container.hide()
	$Control/Control.show()


func _on_OptCloseButton_pressed():
	$Control/Container.show()
	$Control/Control.hide()


func _on_CheckButton_pressed():
	GameRun.show_counter += 1


func _process(delta):
	if GameRun.show_counter == 2:
		GameRun.show_counter = 0
	if GameRun.show_counter == 1:
		$FPSCounter.show()
	if GameRun.show_counter == 0:
		$FPSCounter.hide()
