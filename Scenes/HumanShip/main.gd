extends KinematicBody2D

signal human_died()

const ACCELERATION = 100
const MAX_SPEED = 500
const FRICTON = 5

var velocity = Vector2.ZERO
var rng = 0

# controla quanto tempo deve esperar até mudar de direção
var waiting = 0
var wait_time = 1

# quanto tempo até conseguir atirar novamente
var shot_wait_time = 4
var can_shoot = true

var projectile = load("res://Scenes/HumanShip/Bullet_Human.tscn")

func shoot():
	can_shoot = false
	
	var bullet_instance = projectile.instance()
	bullet_instance.position = $BulletStart.get_global_position()
	bullet_instance.rotation = $BulletStart.get_global_rotation()
	get_parent().add_child(bullet_instance)
	
	yield( get_tree().create_timer(shot_wait_time), 'timeout' )
	can_shoot = true
		
func _physics_process(delta):
	
	# aguarda um tempo até
	if(waiting <= 0):
		
		# seleciona um número aleatório para determinar onde irá se movimentar
		randomize()
		rng = rand_range(-1,1)
		
		# adiciona esse movimento aleatório
		var input_vector = Vector2.ZERO
		input_vector.x = rng
		input_vector = input_vector.normalized() # retorna o vetor normalizado (para movimentos X e Y)
		
		# define a aceleração e velocidade máxima
		if input_vector != Vector2.ZERO:
			velocity = velocity.move_toward(input_vector * MAX_SPEED,  ACCELERATION)  
		else :
			# se nada for pressionado, para o movimento
			#velocity -= input_vector * ACCELERATION * delta
			velocity = velocity.move_toward(Vector2.ZERO, FRICTON)
			
		waiting = wait_time
	
	waiting -= delta
	
	# efetua o movimento	
	velocity = move_and_slide(velocity)	
	
	# Atira
	if( can_shoot == true):
		shoot()
	pass

func onCollide():
	emit_signal("human_died")
	queue_free() 

