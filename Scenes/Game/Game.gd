extends Node2D

var ally_left = 3

func gameOver():
	yield( get_tree().create_timer(0.2), 'timeout' )
	var _change_scene = get_tree().change_scene("res://Scenes/GameOver/GameOver.tscn")
	
func playerWin():
	yield( get_tree().create_timer(0.2), 'timeout' )
	var _change_scene = get_tree().change_scene("res://Scenes/YouWin/YouWin.tscn")

func _ally_died():
	ally_left -= 1
	if( ally_left <= 0):
		ally_left = 0
		gameOver()
 
func _process(_delta):
	$GUI/ALIADOS_COUNT.set_text( str(ally_left) )


func _on_MiniAlienShip_ally_died():
	_ally_died()
func _on_MiniAlienShip2_ally_died():
	_ally_died()
func _on_MiniAlienShip3_ally_died():
	_ally_died()
func _on_MiniAlienShip4_ally_died():
	_ally_died()
func _on_MiniAlienShip5_ally_died():
	_ally_died()
func _on_MiniAlienShip6_ally_died():
	_ally_died()
func _on_MiniAlienShip7_ally_died():
	_ally_died()
func _on_MiniAlienShip8_ally_died():
	_ally_died()
func _on_MiniAlienShip9_ally_died():
	_ally_died()
func _on_MiniAlienShip10_ally_died():
	_ally_died()
func _on_MiniAlienShip11_ally_died():
	_ally_died()
func _on_MiniAlienShip12_ally_died():
	_ally_died()
func _on_MiniAlienShip13_ally_died():
	_ally_died()
func _on_MiniAlienShip14_ally_died():
	_ally_died()
func _on_MiniAlienShip15_ally_died():
	_ally_died()
func _on_MiniAlienShip16_ally_died():
	_ally_died()
func _on_MiniAlienShip17_ally_died():
	_ally_died()
func _on_MiniAlienShip18_ally_died():
	_ally_died()


func _on_HumanShip_human_died():
	playerWin()
