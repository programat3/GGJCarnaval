extends Area2D

@export var item : String


func _on_area_entered(area: Area2D) -> void:
	var p = area.get_parent()
	if p.is_class("OficioComponent"):
		if p.get_class().contains(item):
			p.ramificar = true
