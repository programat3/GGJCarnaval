extends Node
class_name Globals

static var deck_final := [
  ["bailarin_con_mascara", "bailarina_nortena", "oficio"],
  ["bailarin_con_mascara", "pareja_bailarines", "oficio"],
  ["bailarin_con_mascara", "musico_guitarra", "oficio"],
  ["bailarin_con_mascara", "musico_zampona", "oficio"],
  ["bailarin_con_mascara", "batucada", "oficio"],
  ["bailarin_con_mascara", "simbolo2", "oficio"],
  ["bailarina_nortena", "pareja_bailarines", "oficio"],
  ["bailarina_nortena", "musico_guitarra", "oficio"],
  ["bailarina_nortena", "musico_zampona", "oficio"],
  ["bailarina_nortena", "batucada", "oficio"],
  ["bailarina_nortena", "simbolo2", "oficio"],
  ["pareja_bailarines", "musico_guitarra", "oficio"],
  ["pareja_bailarines", "musico_zampona", "oficio"],
  ["pareja_bailarines", "batucada", "oficio"],
  ["pareja_bailarines", "simbolo2", "oficio"],
  ["musico_guitarra", "musico_zampona", "oficio"],
  ["musico_guitarra", "batucada", "oficio"],
  ["musico_guitarra", "simbolo2", "oficio"],
  ["musico_zampona", "batucada", "oficio"],
  ["musico_zampona", "simbolo2", "oficio"],
  ["batucada", "simbolo2", "oficio"],


  ["mascara_demonio", "falda_colorida", "item"],
  ["mascara_demonio", "pompones", "item"],
  ["mascara_demonio", "guitarra", "item"],
  ["mascara_demonio", "zampona", "item"],
  ["mascara_demonio", "tambores", "item"],
  ["falda_colorida", "pompones", "item"],
  ["falda_colorida", "guitarra", "item"],
  ["falda_colorida", "zampona", "item"],
  ["falda_colorida", "tambores", "item"],
  ["pompones", "guitarra", "item"],
  ["pompones", "zampona", "item"],
  ["pompones", "tambores", "item"],
  ["guitarra", "zampona", "item"],
  ["guitarra", "tambores", "item"],
  ["zampona", "tambores", "item"],

  ["oro", "1", "oro"],
  ["oro", "1", "oro"],
  ["oro", "1", "oro"],
  ["oro", "1", "oro"],
  ["oro", "1", "oro"],
  ["oro", "1", "oro"],
  ["oro", "1", "oro"],
  ["oro", "1", "oro"],
  ["oro", "1", "oro"],
  ["oro", "1", "oro"],

  ["tentacion", "5", "tentacion"],
  ["tentacion", "3", "tentacion"],
  ["tentacion", "4", "tentacion"],

  ["simbolo", "simbolo", "oficio"]
]
static var deck_maldicion = [
	["maldicion", "0", "maldicion"],
  ["maldicion", "0", "maldicion"],
  ["maldicion", "0", "maldicion"],
  ["maldicion", "0", "maldicion"],
  ["maldicion", "0", "maldicion"],
  ["maldicion", "-3", "maldicion"],
  ["maldicion", "-3", "maldicion"],
  ["maldicion", "-4", "maldicion"],
  ["maldicion", "-4", "maldicion"],
  ["maldicion", "-5", "maldicion"]
]

static var deck = [
	["bailarin_con_mascara", "musico_zampona", "oficio"],
	["musico_zampona", "musico_zampona", "oficio"],
	["bailarin_con_mascara", "bailarin_con_mascara", "oficio"],
	["simbolo", "simbolo", "oficio"],
	["oro", "1", "oro"],	
]

static var hist_cards = []

static var is_playing = false
static var slots_full = false

static var play_zone = false
static var exchange_zone = false

static var coins = 10

static func get_gold(q):
	coins += q

static func pay_cost(cost):
	coins -= cost
