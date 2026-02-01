extends Node2D
signal timer_ready
@export var max_time = 5
var count_time = max_time
var card_data
var card
var legal = false
var pos
var flag = true
# Example for a CircleShape sweep

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#$PlayZone/Timer.connect("timeout", _timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $PlayZone.is_colliding():
		print("coliding")
		var cs = $PlayZone.get_collision_count()
		for c in cs:
			var col = $PlayZone.get_collider(c)
			print(col)
			card_data = col.get_parent().data
			card = col.get_parent()
			print(card_data)
			if card_data[2] not in ["oro", "maldicion", "tentacion"]:
				print("legal")
				if card_data not in Globals.hist_cards :
					if legal and card_data[2] not in ["oro", "maldicion", "tentacion"]:
						Globals.hist_cards.append(card_data)
						card.play_card(pos)
						count_time = max_time
			
#func _timeout():
	#count_time -= 1
	#if count_time < 0:
		#if legal and card_data[2] not in ["oro", "maldicion", "tentacion"]:
			#Globals.hist_cards.append(card_data)
			#card.play_card(pos)
			#count_time = max_time
			#flag = true
			#$Timer.text = ""
		#pass
	#else:
		#$PlayZone/Timer.start()
		#$Timer.text = str(count_time)

func _resolve_game_oficio(card, pos) -> bool:
		self.card = card
		self.card_data = card.data
		self.pos = pos
		if Globals.hist_cards.is_empty():
			legal = true
			return legal
		if card.get_node("typeA").get_node("Oficio").check_raycast_legal_move():
			legal = true
			return legal
		if card.get_node("typeB").get_node("Oficio").check_raycast_legal_move():
			legal = true
			return legal
		else:
			legal = false
			return legal
		
	
