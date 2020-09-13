extends TextureButton

func _on_TextureButton_pressed():
	var _change_scene = get_tree().change_scene("res://Scenes/Game/Game.tscn")

func _on_GithubLink_pressed():
	var _shell_open = OS.shell_open("https://github.com/daniofilho/invaders-from-space")
