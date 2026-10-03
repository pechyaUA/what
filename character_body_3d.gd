extends CharacterBody3D

@export var spd = 20

@export var fall = 50

var targ_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("m_right"):
		direction.x += 1
	if Input.is_action_pressed("m_left"):
		direction.x -= 1
	if Input.is_action_pressed("m_frv"):
		direction.z -= 1
	if Input.is_action_pressed("m_back"):
		direction.z += 1
	if Input.is_action_pressed("jump"):
		direction.y += 10
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$pivot.basis = Basis.looking_at(direction)
		
	targ_velocity.x = direction.x * spd
	targ_velocity.z = direction.z * spd
	targ_velocity.y = direction.y * spd
	
	if not is_on_floor():
		targ_velocity.y = targ_velocity.y - (fall * delta)

	velocity = targ_velocity
	move_and_slide()
