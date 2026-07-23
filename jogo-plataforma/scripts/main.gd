extends Node2D
@onready var label: Label = $CanvasLayer/Panel/Label

var levels: Array[PackedScene] = [
	preload("res://cenas/level_root.tscn"),
	preload("res://cenas/level2.tscn"),
]

var current_level_root: Node2D
var pontos = 0
var level = 0

func _ready() -> void:
	current_level_root = $levelRoot
	_setup_level()

func _load_level(level_number: int) -> void:
	if current_level_root:
		current_level_root.queue_free()

	level = level_number % levels.size()
	current_level_root = levels[level].instantiate()
	add_child(current_level_root)
	_setup_level()

func _setup_level() -> void:
	var exit = current_level_root.get_node_or_null("Exit")
	if exit:
		exit.body_entered.connect(exit_level)

	var moedas = current_level_root.get_node_or_null("moedas")
	if moedas:
		for moeda in moedas.get_children():
			moeda.collected.connect(somar_pontos)

	var inimigos = current_level_root.get_node_or_null("inimigos")
	if inimigos:
		for inimigo in inimigos.get_children():
			inimigo.player_died.connect(_on_player_died)

func _on_player_died(body):
	body.die()

func somar_pontos():
	pontos += 1
	label.text = "SCORE: %s" % pontos

func exit_level(body: Node2D):
	if body.name == "Player":
		print("entrou")
		_load_level(level + 1)
