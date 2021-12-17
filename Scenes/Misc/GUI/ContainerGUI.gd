extends HBoxContainer


onready var lCount = $LifeCount
onready var cCount = $CoinCount


func updateText(health, coins):
	lCount.text = str(health)
	cCount.text = str(coins)
