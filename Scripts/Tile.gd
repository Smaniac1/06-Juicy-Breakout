extends StaticBody2D

var points = 5

func ready(random_num):
	if random_num == 1:
		$ColorRect.color = Color(0,0,0)
	if random_num == 2:
		$ColorRect.color = Color(0,0,255)
		points = 10
	if random_num == 3:
		$ColorRect.color = Color(0,255,0)
		points = 15
	if random_num == 4:
		$ColorRect.color = Color(255,0,0)
		points = 20
	if random_num == 5:
		$ColorRect.color = Color(255,255,0)
		points = 25
	if random_num == 6:
		$ColorRect.color = Color(0,255,255)
		points = 30
	if random_num == 7:
		$ColorRect.color = Color(255,0,255)
		points = 35
	if random_num == 8:
		$ColorRect.color = Color(255,255,255)
		points = 40
