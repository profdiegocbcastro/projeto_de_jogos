extends Node2D

@onready var label_pontos: Label = $CanvasLayer/LabelPontos
@onready var label_game_over: Label = $CanvasLayer/GameOver

func _ready() -> void:
	Global.reset()
	label_pontos.text = "Pontos: 0"
	label_game_over.visible = false
	Global.score_changed.connect(_on_score_changed)
	Global.game_over.connect(_on_game_over)

func _on_score_changed(novo_valor: int) -> void:
	label_pontos.text = "Pontos: %d" % novo_valor

func _on_game_over() -> void:
	label_game_over.visible = true

func _unhandled_input(event: InputEvent) -> void:
	if not Global.jogo_ativo and event.is_action_pressed("tiro"):
		get_tree().reload_current_scene()
