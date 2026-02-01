extends Area2D

@onready var ray_cast: RayCast2D = $RayCast2D

var ramificar : bool

@export var oficio : String
var d
var is_legal := true

func _process(delta: float) -> void:
	if ray_cast.is_colliding():
		var col = ray_cast.get_collider()
		if col.name.contains("A"):
			var card = col.get_parent()
			var d = card.data[0]
		elif col.name.contains("B"):
			var card = col.get_parent()
			var d = card.data[1]

func check_raycast_legal_move():
	if d != oficio or Globals.hist_cards.size() > 1:
		is_legal = false
	else:
		is_legal = true
		
