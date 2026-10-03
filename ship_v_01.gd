extends CharacterBody3D

@export var spd = 10

@export var fall = 20

var targ_velocity = Vector3.ZERO
var direction = Vector3.ZERO
var trgspd = 0

func _physics_process(delta):
	
	if direction.x > 1:
		direction.x = 1
	if direction.x < -1:
		direction.x = -1
	if direction.z > 0:
		direction.z = 0
	if direction.z < -1:
		direction.z = -1
	
	
	if Input.is_action_pressed("m_right"):
		direction.x += 0.1
	if Input.is_action_pressed("m_left"):
		direction.x -= 0.1
	if Input.is_action_pressed("m_frv"):
		direction.z -= 0.1
	if Input.is_action_pressed("m_back"):
		direction.z += 0.1
	if Input.is_action_just_pressed("jump"):
		direction.y += 10
	
	if Input.is_action_just_pressed("faster"):
		trgspd = trgspd + 3
	if Input.is_action_just_pressed("slower"):
		trgspd = trgspd - 3
		
	if trgspd > 30:
		trgspd = 30 
	
	if trgspd < -15:
		trgspd = -15
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	$pivot.basis = Basis.looking_at(direction)
	
	#targ_velocity.x = direction.x * spd
	#targ_velocity.z = direction.z * spd
	#targ_velocity.y = direction.y * spd          
	
	targ_velocity.x = direction.x * trgspd
	targ_velocity.z = direction.z * trgspd
	targ_velocity.y = direction.y * spd
	
	
	if not is_on_floor():
		#targ_velocity.y = targ_velocity.y - (fall * delta)
		direction.y -= 0.3
	velocity = targ_velocity
	move_and_slide()
