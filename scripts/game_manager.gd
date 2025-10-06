extends Node

const BOTTLE = 20
var score = 0
@onready var score_label: Label = $ScoreLabel
@onready var score_label_2: Label = $ScoreLabel2

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."
	if score != BOTTLE:
		score_label_2.text = "Feel like a drink? Sadly, you’re short " +  str(BOTTLE - score) + " coins :("
	else:
		score_label_2.text = "Feel like a drink? It costs 20 coins. Go on, treat yourself :)"
		
func drink():
	if BOTTLE - score == 0:
		score_label_2.text = "Enjoy! Drink responsibly :)"
		return true
	else:
		return false
