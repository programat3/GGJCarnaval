extends Node2D

var card_being_dragged
var screen_size
var types : Array
var first :bool
var gold := 0

@onready var gold_label = $/GoldCounter

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$PlayZone/Timer.connect("timeout", _on_timeout)
	first = true

func _process(delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		card_being_dragged.position = Vector2(clamp(mouse_pos.x, 0 , screen_size.x), clamp(mouse_pos.y, 0, screen_size.y))

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			var card = raycast_check_card()
			if card:
				if card.played:
					card_being_dragged = null
					print("played")
				else:
					card_being_dragged = card
					
		elif event.is_released():
			if card_being_dragged:
				$PlayZone.force_shapecast_update()

				var n = $PlayZone.get_collision_count()
				for i in range(n):
					var collider = $PlayZone.get_collider(i)

					if collider == card_being_dragged:
						resolve_play(card_being_dragged)

			card_being_dragged = null
			
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_R and card_being_dragged:
				card_being_dragged.rotation_degrees += 45

func check_legal_move(t):
	var legal = t.get_node("Oficio").check_raycast_legal_move()
	return legal

func raycast_check_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 2
	var result = space_state.intersect_point(parameters)

	if result.is_empty():
		return null
	for i in result:
		if i.collider.name == "FullCard":
			var c = i.collider.get_parent()
			return c
	return null

func pop_card(i : int):
	print("Popping")
	var c = Globals.deck.pop_at(i)
	var s = find_slot()
	print("c:", c)
	print("s:", s)
	if s:
		var card = preload("res://Components/Card.tscn").instantiate()
		self.add_child(card)
		card.position = s.position
		card.generate(c[0], c[1], c[2])
	else:
		print("No more slots")

func find_slot():
	var children = get_children()
	for k in children:
		if k.name.contains("slot"):
			if !k.is_full:
				k.is_full = true
				return k
	Globals.slots_full = true
	return null

func _on_card_spawn_pressed() -> void:
	if (!Globals.slots_full):
		if first:
			pop_card(-1)
			first = false
		else:
			var random_g = RandomNumberGenerator.new()
			var r_i = random_g.randi_range(0,Globals.deck.size() - 1)
			pop_card(r_i)

func resolve_play(card):
	if card.played:
		return

	card.played = true

	match card.data[2]:
		"oro":
			add_gold()
			card.queue_free()
		_:
			print("Carta jugada:", card.data[2])

func add_gold():
	gold += 1
	gold_label.text = "Oro: %d" % gold

func _on_timeout():
	pass
