extends KinematicBody2D

const ACCELERATION = 10
const MAX_SPEED = 200
const FRICTON = 10

var velocity = Vector2.ZERO


# preload da scene
var projectile = load("res://Scenes/Player/Bullet_Alien.tscn")

var can_fire = true;
var rate_of_fire = 0.4

var swipe_action = Vector2.ZERO # swap começa inativo

var action_pressed = 0

# Executa a cada frame, mas relacionado a física
func _physics_process(_delta):
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	#se houve swipe, substitui o valor
	if( swipe_action.x != 0 ):
		input_vector.x = swipe_action.x * - 1 # 1 porque o swipe retorna valor invertido do movimento
	
	input_vector = input_vector.normalized() # retorna o vetor normalizado (para movimentos X e Y)
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED,  ACCELERATION)  
	else :
		# se nada for pressionado, para o movimento
		velocity = velocity.move_toward(Vector2.ZERO, FRICTON)
	
	#move_and_slide já considera o delta - também colide se bater em algum objeto
	velocity = move_and_slide(velocity) 	
	 
	# Shoot
	if( (Input.get_action_strength("S_KEY")  or swipe_action.y == -1) and can_fire == true):
		shoot()

func shoot():
	# desabilita o tiro
	can_fire = false
	swipe_action = Vector2.ZERO
	
	# instancia a scene da bala e joga na tela a frente da nave
	var bullet_instance = projectile.instance()
	bullet_instance.position = $BulletStart.get_global_position()
	get_parent().add_child(bullet_instance)
	
	# após X tempo, retorna a habilita de atirar
	yield( get_tree().create_timer(rate_of_fire), 'timeout' )
	can_fire = true
	
func onCollide():
	var _change_scene = get_tree().change_scene("res://Scenes/GameOver/GameOver.tscn")
	queue_free() 


func _on_SwipeDetection_swiped(direction):
	swipe_action = direction
	pass # Replace with function body.

func _on_SwipeDetection_swiped_canceled(_start_position):
	swipe_action = Vector2.ZERO
