extends CPUParticles2D
var tick = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tick += 1
	if tick == 20:
		self.emitting = false
	if tick >= 120:
		queue_free()
