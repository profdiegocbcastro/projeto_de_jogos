extends Node2D

@export var inimigos: Array[PackedScene] = []
@export var intervalo_min := 0.5
@export var intervalo_max := 1.5
@export var margem := 16.0

@onready var timer: Timer = $Timer

var tamanho_tela: Vector2

func _ready() -> void:
	tamanho_tela = get_viewport_rect().size
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	Global.game_over.connect(_on_game_over)
	_agendar_proximo()

func _agendar_proximo() -> void:
	timer.start(randf_range(intervalo_min, intervalo_max))

func _on_timer_timeout() -> void:
	_spawnar_inimigo()
	_agendar_proximo()

func _on_game_over() -> void:
	timer.stop()

func _spawnar_inimigo() -> void:
	if inimigos.is_empty():
		return
	var cena: PackedScene = inimigos[randi() % inimigos.size()]
	var inimigo := cena.instantiate()
	var x := randf_range(margem, tamanho_tela.x - margem)
	inimigo.position = Vector2(x, -margem)
	get_parent().add_child(inimigo)
