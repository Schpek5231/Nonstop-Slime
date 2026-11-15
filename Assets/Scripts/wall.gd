extends Node2D
var tick = 0
var closing = 0
var starty = position.y


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.playerx >= (position.x + 50) and Global.playerx <= (position.x + 50) and Global.playery <= (position.y):
		closing = 1
	if closing == 1:
		tick += 1
		if tick <= 10:
			position.y += 21
	if Global.ded == 1:
		position.y = starty
