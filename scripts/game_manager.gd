extends Node

const BOTTLE = 20

var score = 0
@onready var score_label: Label = $ScoreLabel
@onready var score_label_2: Label = $ScoreLabel2

func add_point():
	score += 1
	score_label.text = "Has tomado " + str(score) + " Monedas."
	if score != BOTTLE:
		score_label_2.text = "¿Te apetece una bebida? Una pena que te falten " +  str(BOTTLE - score) + " monedas :("
	else:
		score_label_2.text = "¿Te apetece una bebida? Cuesta 20 monedas. Para algo has tomado todas esas monedas, ¿no? :)"
		
func drink():
	if BOTTLE - score == 0:
		score_label_2.text = "Disfrutala! Pero bebe responsablemente :)"
		return true
	else:
		return false
