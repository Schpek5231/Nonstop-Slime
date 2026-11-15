extends Node2D
const trail_scene = preload("res://Assets/Scenes/character_trail.tscn")
const part_scene = preload("res://Assets/Scenes/character_particles.tscn")
const explode_scene = preload("res://Assets/Scenes/explode_particles.tscn")
var delay = 4
var tick = 0
var tick2 = 0
var startx = position.x
var starty = position.y

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.ded = 0
	$CharacterBody2D/Music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var trail = trail_scene.instantiate()
	var part = part_scene.instantiate()
	var partded = explode_scene.instantiate()
	if Global.pounding == 1 or Global.wall_jumping == 1:
		trail.global_position = Vector2($CharacterBody2D.position.x, $CharacterBody2D.position.y)
		if Global.pounding == 1 and Global.ded == 0:
			add_child(trail)
	
	if $CharacterBody2D.hit_floor == 1:
		part.global_position = Vector2($CharacterBody2D.position.x, $CharacterBody2D.position.y)
		add_child(part)
		$CharacterBody2D.hit_floor = 0
	
	if Global.ded == 1:
		$CharacterBody2D.time_on_wall = 0
		if tick2 == 0:
			partded.global_position = Vector2($CharacterBody2D.position.x, $CharacterBody2D.position.y)
			add_child(partded)
			$CharacterBody2D/DeathSFX.play()
		tick2 += 1
		if tick2 == 120:
			$CharacterBody2D.position.x = Global.checkpointx
			$CharacterBody2D.position.y = Global.checkpointy
			Global.direction = 1
			Global.ded = 0
			tick2 = 0
