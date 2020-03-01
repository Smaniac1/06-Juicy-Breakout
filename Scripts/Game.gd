extends Node2D

export var lives = 3
export var score = 0
var max_score = 0
var more_balls = 100

var new_ball = preload("res://Scenes/Ball.tscn")
onready var tile = get_node("Tiles")

func _ready():
	randomize()
	$MainTheme.playing = true
	$Score.update_score(score)
	$Lives.update_lives(lives)
	for tile in get_tree().get_nodes_in_group("Tiles"):
		var random_num = randi()%8+1
		tile.ready(random_num)
		max_score += tile.points

func change_score(s):
	if $MainTheme.playing == false:
		$MainTheme.playing = true
	score += s
	if score >= more_balls:
		more_balls = more_balls * 2.75
		make_extra_ball($Paddle/CollisionShape2D.position)
	var x = $Paddle/CollisionShape2D.scale.x
	x += .075
	$Paddle/CollisionShape2D.scale.x = x
	$Paddle/ColorRect.rect_scale.x = x
	$Score.update_score(score)
	#if there are no more tiles, show the winning screen
	if len(get_tree().get_nodes_in_group("Tiles")) == 1:
		get_tree().change_scene("res://Scenes/Win.tscn")

func change_lives(l):
	if $MainTheme.playing == false:
		$MainTheme.playing = true
	lives += l
	$Lives.update_lives(lives)
	#if there are no more lives show the game over screen
	if lives <= 0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")

func make_new_ball(pos):
	if $MainTheme.playing == false:
		$MainTheme.playing = true
	var x = $Paddle/CollisionShape2D.scale.x
	x = 1
	$Paddle/CollisionShape2D.scale.x = x
	$Paddle/ColorRect.rect_scale.x = x
	if len(get_tree().get_nodes_in_group("Ball")) == 0:
		var ball = new_ball.instance()
		ball.position = pos
		ball.name = "Ball"
		var vector = Vector2(0, -300)
		#choose a random direction, constraining it so we don't get too steep an angle
		if randi()%2:
			vector = vector.rotated(rand_range(PI/6,PI/3))
		else: 
			vector = vector.rotated(rand_range(-PI/3,-PI/6))
		ball.linear_velocity = vector
		add_child(ball)
	
func make_extra_ball(pos):
	if $MainTheme.playing == false:
		$MainTheme.playing = true
	var ball = new_ball.instance()
	ball.position = pos
	ball.name = "Ball"
	var vector = Vector2(0, -300)
	#choose a random direction, constraining it so we don't get too steep an angle
	if randi()%2:
		vector = vector.rotated(rand_range(PI/6,PI/3))
	else: 
		vector = vector.rotated(rand_range(-PI/3,-PI/6))
	ball.linear_velocity = vector
	add_child(ball)
