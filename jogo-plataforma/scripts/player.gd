extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 100.0
const JUMP_VELOCITY = -800.0
var alive = true

func _physics_process(delta: float) -> void:
	
	if !alive:
		return
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "run"
	else:
		animated_sprite_2d.animation = "idle"
	
	if not is_on_floor():
		animated_sprite_2d.animation = "jump"
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("pular") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("esquerda", "direita")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0:
		animated_sprite_2d.flip_h = true
		
func die() -> void:
	animated_sprite_2d.animation = "die"
	alive = false
	
func is_alive() -> bool:
	return alive
