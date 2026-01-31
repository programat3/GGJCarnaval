extends Node2D

var card_being_dragged
var screen_size
var types : Array
var first :bool
var gold := 0

var slot
var freed = []
@onready var gold_label: Label = $GoldCounter
@onready var exchangeZone = $"../ExchangeZone"

func _ready() -> void:
	screen_size = get_viewport_rect().size
	first = true

func _process(delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		card_being_dragged.position = Vector2(clamp(mouse_pos.x, 0 , screen_size.x), clamp(mouse_pos.y, 0, screen_size.y))

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			var card = raycast_check_card()
			slot = raycast_check_slot()
			if card:
				if card.played:
					card_being_dragged = null
				else:
					card.save_position()
					card_being_dragged = card
					
		elif event.is_released():
			if card_being_dragged:
				var played := false
				
				exchangeZone.force_shapecast_update()
				var n = exchangeZone.get_collision_count()
				
				for i in range(n):
					var collider = exchangeZone.get_collider(i)
					if collider.get_parent() == card_being_dragged:
						played = resolve_play_gold(card_being_dragged)
						break
						
				if not played:
					reject_play(card_being_dragged)
					
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
	
func raycast_check_slot():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 2
	var result = space_state.intersect_point(parameters)
	if result.is_empty():
		return null
	for i in result:
		if i.collider.name.contains("slot"):
			return i.collider
	return null

func pop_card(i : int):
	var c = Globals.deck.pop_at(i)
	var s = find_slot()
	if s:
		print("popping")
		s.fill()
		var card = preload("res://Components/Card.tscn").instantiate()
		self.add_child(card)
		card.position = s.position
		card.generate(c[0], c[1], c[2])

func find_slot():
	var children = get_children()
	for k in children:
		if k.name.contains("slot"):
			if k.id in freed:
				k.free_slot()
				freed.pop_back()
			print("slot:", k.id, "is", k.is_full)
			if k.is_full == false:
				return k
	return null

func _on_card_spawn_pressed() -> void:
	if (find_slot()):
		if first:
			pop_card(-1)
			first = false
		else:
			var random_g = RandomNumberGenerator.new()
			var r_i = random_g.randi_range(0,Globals.deck.size() - 1)
			pop_card(r_i)

func resolve_play_gold(card) -> bool:
	if card.played:
		return true

	if card.data[2] == "oro":
		card.played = true
		add_gold()
		freed.append(slot.id)
		card.queue_free()

	return false

func reject_play(card):
	slot.fill()
	card.position = card.start_position
	card.rotation = 0

func add_gold():
	gold += 1
	gold_label.text = "Oro: %d" % gold

func _on_timeout():
	pass
