extends Node2D

func _ready():
	$VictoryTheme.playing = true
	pass

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")
