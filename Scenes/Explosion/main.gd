extends Node2D

func _ready():
	# após X tempo, detroi
	yield( get_tree().create_timer(0.2), 'timeout' )
	queue_free() 
