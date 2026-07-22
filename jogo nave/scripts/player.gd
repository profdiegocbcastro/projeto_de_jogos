extends CharacterBody2D

@export var speed := 100
var direction = ""
var vivo := true
@onready var nave: Sprite2D = $Nave
@onready var flash: Sprite2D = $Flash
@onready var timer: Timer = $Timer
const TIRO = preload("uid://dhqcp0ybnl8rt")
@onready var son_tiro: AudioStreamPlayer2D = $son_tiro

var tamanho_tela : Vector2
var margem := 10

func _ready() -> void:
	tamanho_tela = get_viewport_rect().size
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if not vivo:
		return

	velocity.x = Input.get_axis("esquerda", "direita") * speed
	velocity.y = Input.get_axis("cima", "baixo") * speed
	
	if velocity.x > 0:
		nave.frame = 1
	elif velocity.x < 0:
		nave.frame = 4
	else:
		nave.frame = 2
		
	if Input.is_action_just_pressed("tiro"):
		flash.visible = true
		timer.start()
		
		var tiro = TIRO.instantiate()
		tiro.global_position = global_position + Vector2(0,-20)
		get_parent().add_child(tiro)
		
		son_tiro.play()

	move_and_slide()
	
	global_position.x = clamp(global_position.x, 0 + margem, tamanho_tela.x - margem)
	global_position.y = clamp(global_position.y, 0  + margem, tamanho_tela.y - margem)


func _on_timer_timeout() -> void:
	flash.visible = false

func morrer() -> void:
	if not vivo:
		return
	vivo = false
	visible = false
	Global.encerrar_jogo()
