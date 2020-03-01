extends RigidBody2D

onready var Game = get_node("/root/Game")
onready var Starting = get_node("/root/Game/Starting")
onready var Particle_tile = load("res://Scenes/HitTile.tscn")
onready var Particle_paddle = load("res://Scenes/HitPaddle.tscn")
onready var Particle_death = load("res://Scenes/LoseLife.tscn")
onready var Particle_wall = load("res://Scenes/HitWall.tscn")
onready var Particle_points = load("res://Scenes/Points.tscn")
onready var Particle_trail = load("res://Scenes/Trail.tscn")
onready var Sound_death = load("res://Scenes/Fire.tscn")
onready var Sound_wall1 = load("res://Scenes/GlassBreaking1.tscn")
onready var Sound_wall2 = load("res://Scenes/GlassBreaking2.tscn")
onready var Sound_wall3 = load("res://Scenes/GlassBreaking3.tscn")
onready var Sound_paddle = load("res://Scenes/MagicRingNoise.tscn")
onready var Sound_tile1 = load("res://Scenes/TileEffect1.tscn")
onready var Sound_tile2 = load("res://Scenes/TileEffect2.tscn")
onready var Sound_tile3 = load("res://Scenes/TileEffect3.tscn")
onready var Sound_tile4 = load("res://Scenes/TileEffect4.tscn")
onready var Paddle_collision = get_node("/root/Game/Paddle/CollisionShape2D")
onready var Paddle_color = get_node("/root/Game/Paddle/ColorRect")

#colors
var colors = [Color(255,0,0),
Color(0,255,0),
Color(0,0,255),
Color(255,255,0),
Color(255,0,255),
Color(0,255,255),
Color(127,0,0),
Color(0,127,0),
Color(0,0,127),
Color(127,127,0),
Color(127,0,127),
Color(0,127,127),
Color(255,127,0),
Color(255,127,127),
Color(255,0,127),
Color(255,255,127),
Color(255,127,255),
Color(127,255,0),
Color(127,255,127),
Color(0,255,127),
Color(127,255,255),
Color(127,0,255),
Color(127,127,255),
Color(0,127,255),
Color(255,255,255),
Color(0,0,0)]

var c = colors[randi() % colors.size()]

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)

func _physics_process(delta):
	var q = Particle_points.instance()
	q.position = position
	q.emitting = true
	var t = Particle_trail.instance()
	t.position = position
	t.emitting = true
	t.modulate = c
	get_node("/root/Game").add_child(t)
	# Check for collisions
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("Tiles"):
			var p = Particle_tile.instance()
			p.position = position
			p.emitting = true
			randomize()
			var i = randi()%5+1
			if i == 1:
				var s = Sound_tile1.instance()
				s.playing = true
				get_node("/root/Game").add_child(s)
			if i == 2:
				var s = Sound_tile2.instance()
				s.playing = true
				get_node("/root/Game").add_child(s)
			if i == 3:
				var s = Sound_tile3.instance()
				s.playing = true
				get_node("/root/Game").add_child(s)
			if i == 4:
				var s = Sound_tile4.instance()
				s.playing = true
				get_node("/root/Game").add_child(s)
			get_node("/root/Game").add_child(p)
			randomize()
			c = colors[randi() % colors.size()]
			$ColorRect.modulate = c
			randomize()
			Paddle_color.modulate = colors[randi() % colors.size()]
			randomize()
			q.modulate = colors[randi() % colors.size()]
			t.modulate = c
			get_node("/root/Game").add_child(q)
			Game.change_score(body.points)
			body.queue_free()
		if body.is_in_group("Paddle"):
			var p = Particle_paddle.instance()
			p.position = position
			p.emitting = true
			var s = Sound_paddle.instance()
			s.playing = true
			var x = Paddle_collision.scale.x
			if x > .4:
				x -= .05
				Paddle_collision.scale.x = x
				Paddle_color.rect_scale.x = x
			randomize()
			c = colors[randi() % colors.size()]
			$ColorRect.modulate = c
			randomize()
			Paddle_color.modulate = colors[randi() % colors.size()]
			randomize()
			q.modulate = colors[randi() % colors.size()]
			t.modulate = c
			get_node("/root/Game").add_child(q)
			get_node("/root/Game").add_child(s)
			get_node("/root/Game").add_child(p)
		if body.is_in_group("Walls"):
			var p = Particle_wall.instance()
			p.position = position
			p.emitting = true
			randomize()
			var i = randi()%4+1
			if i == 1:
				var s = Sound_wall1.instance()
				s.playing = true
				get_node("/root/Game").add_child(s)
			if i == 2:
				var s = Sound_wall2.instance()
				s.playing = true
				get_node("/root/Game").add_child(s)
			if i == 3:
				var s = Sound_wall3.instance()
				s.playing = true
				get_node("/root/Game").add_child(s)
			var x = Paddle_collision.scale.x
			if x > .4:
				x -= .05
				Paddle_collision.scale.x = x
				Paddle_color.rect_scale.x = x
			randomize()
			c = colors[randi() % colors.size()]
			$ColorRect.modulate = c
			randomize()
			Paddle_color.modulate = colors[randi() % colors.size()]
			randomize()
			q.modulate = colors[randi() % colors.size()]
			t.modulate = c
			get_node("/root/Game").add_child(q)
			get_node("/root/Game").add_child(p)
	if position.y > get_viewport().size.y:
		var p = Particle_death.instance()
		p.position = position
		p.emitting = true
		var s = Sound_death.instance()
		s.playing = true
		get_node("/root/Game").add_child(p)
		get_node("/root/Game").add_child(s)
		Game.change_lives(-1)
		Starting.startCountdown(3)
		queue_free()
