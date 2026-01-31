extends Area2D

@onready var ray_cast: RayCast2D = $RayCast2D

var ramificar : bool

@export var oficio : String

func check_raycast_legal_move():
	if ray_cast.is_colliding():
		var col = ray_cast.get_collider()
		if col.name.contains("A"):
			var card = col.get_parent()
			var d = card.data[0]
		elif col.name.contains("B"):
			var card = col.get_parent()
			var d = card.data[1]
			
			
