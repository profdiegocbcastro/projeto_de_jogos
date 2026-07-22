extends Node

signal score_changed(novo_valor: int)
signal game_over

var score := 0
var jogo_ativo := true

func add_score(pontos: int) -> void:
	if not jogo_ativo:
		return
	score += pontos
	score_changed.emit(score)

func reset() -> void:
	score = 0
	jogo_ativo = true
	score_changed.emit(score)

func encerrar_jogo() -> void:
	if not jogo_ativo:
		return
	jogo_ativo = false
	game_over.emit()
