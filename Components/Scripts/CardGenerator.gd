extends Node2D
class_name Card

@export var played := false
@export var data : Array[String]

func generate(a, b, c):
	data = [a,b,c]
	match c:
		"oficio":
			var oficio_a = preload("res://Components/Oficio.tscn").instantiate()
			var oficio_b = preload("res://Components/Oficio.tscn").instantiate()

			oficio_a.oficio = a
			oficio_b.oficio = b
			
			self.create_card($typeA,"res://Assets/Sprites/Cards/Oficios/" + a + ".png")
			self.create_card($typeB,"res://Assets/Sprites/Cards/Oficios/" + b + ".png")
			
			$typeA.add_child(oficio_a)
			$typeB.add_child(oficio_b)
		"oro":
			print("Oro")
			self.create_card($typeA,"res://Assets/Sprites/Cards/Oficios/" + a + ".png")
		"tentacion":
			print("tentacion")
		"maldicion":
			print("maldicion")
		"item":
			print("item")

func create_card(n,r):
	var s = load(r)
	n.get_child(1).texture = s
	
