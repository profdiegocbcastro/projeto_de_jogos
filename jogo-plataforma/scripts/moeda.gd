extends Area2D

signal collected

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	collected.emit()
