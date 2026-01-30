extends Area2D

@onready var ray_cast: RayCast2D = $RayCast2D

var ramificar : bool

@export var oficio : String

func check_raycast_legal_move():
	if ray_cast.is_colliding():
		var col = ray_cast.get_collider()
		if col.name == "typeA" or col.name == "typeB":
			var cs = col.get_children()
			for c in cs:
				if c.name == "Oficio":
					print("oficio: ", c.oficio, "v/s", self.oficio)
					if c.oficio == oficio:
						return true
					else:
						return false
				return false
			return false
		return false
	return false
			
