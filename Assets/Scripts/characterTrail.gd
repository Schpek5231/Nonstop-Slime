extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.direction == 1:
		flip_h = false
	else:
		flip_h = true
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.wall_jumping == 1 and Global.pounding == 1:
		self.texture = load("res://Assets/Sprites/SlimeGroundPound.png")
	modulate.a -= 0.02
	
	if modulate.a <= 0.01:
		queue_free()
	
	
