extends Area2D

@export var id : int
var is_full :bool

func fill():
	is_full = true

func free_slot():
	is_full = false
