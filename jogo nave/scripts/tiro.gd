extends Area2D

@export var speed := -150
@export var de_inimigo := false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	position.y += speed * delta


func _on_screen_exit() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if de_inimigo:
		return
	if area is Inimigo:
		area.tomar_dano(1)
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if not de_inimigo:
		return
	if body.is_in_group("player"):
		body.morrer()
		queue_free()
