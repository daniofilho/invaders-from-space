extends RigidBody2D

var projectile_speed = 400
var life_time = 3

# preload da scene
var explosion_scene = load("res://Scenes/Explosion/Explosion.tscn")

func selfDestruct():
	yield( get_tree().create_timer(life_time), 'timeout' )
	queue_free()

func _ready():
	apply_impulse( Vector2(), Vector2(projectile_speed, 0).rotated(rotation) )
	selfDestruct()

# Detecta colisão

# no objeto, ative o Contact Report e defina o número para 1 pelo menos

# em seguida clique no Node do RigidBody, vá em Node na lateral direita
# e conecte ele com o RigidBody na função body_entered para ativar o listener abaixo
func _on_Bullet_body_entered(body):
	
	# executa a função de onCollide do objeto que acertou
	body.onCollide()
	 
	# esconde a bala
	visible = false
	
	# instancia a scene da bala e joga na tela a frente da nave
	var explosion_instance = explosion_scene.instance()
	explosion_instance.position = position
	get_parent().add_child(explosion_instance)
	
	queue_free() # destroi a bala
	 
