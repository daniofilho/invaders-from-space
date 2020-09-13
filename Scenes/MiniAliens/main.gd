extends KinematicBody2D

signal ally_died()

const ACCELERATION = 10
const MAX_SPEED = 100
const FRICTON = 5

var velocity = Vector2.ZERO
var rng = 0

var x0 = position.x
var xRange = 20

# controla quanto tempo deve esperar até mudar de direção
var waiting = 0
var wait_time = 1
	
func _physics_process(delta):
	
	# aguarda um tempo até mudar de direção
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
	 
	pass
	
func onCollide():
	emit_signal('ally_died')
	queue_free() 
	
