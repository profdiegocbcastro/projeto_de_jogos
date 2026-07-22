extends Area2D
class_name Inimigo

@export var velocidade := 20
@export var vida := 1
@export var pontos := 1
@export var pode_atirar := true
@export var intervalo_tiro_min := 1.0
@export var intervalo_tiro_max := 2.5
@export var velocidade_tiro := 100

const TIRO = preload("uid://dhqcp0ybnl8rt")

@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var timer_tiro: Timer = $TimerTiro

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	notifier.screen_exited.connect(_on_screen_exited)
	if pode_atirar:
		timer_tiro.one_shot = true
		timer_tiro.timeout.connect(_on_timer_tiro_timeout)
		Global.game_over.connect(_on_game_over)
		_agendar_tiro()

func _process(delta: float) -> void:
	position.y += velocidade * delta

func tomar_dano(dano: int) -> void:
	vida -= dano
	if vida <= 0:
		die()

func die() -> void:
	Global.add_score(pontos)
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.morrer()
		queue_free()

func _on_screen_exited() -> void:
	queue_free()

func _on_game_over() -> void:
	timer_tiro.stop()

func _agendar_tiro() -> void:
	timer_tiro.start(randf_range(intervalo_tiro_min, intervalo_tiro_max))

func _on_timer_tiro_timeout() -> void:
	if Global.jogo_ativo and notifier.is_on_screen():
		var tiro = TIRO.instantiate()
		tiro.de_inimigo = true
		tiro.speed = velocidade_tiro
		tiro.global_position = global_position + Vector2(0, 12)
		get_parent().add_child(tiro)
		tiro.get_node("AnimatedSprite2D").flip_v = true
	_agendar_tiro()
