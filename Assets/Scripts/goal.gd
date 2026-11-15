extends Area2D
var collected = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite2D.play("default")





func _on_body_entered(body: Node2D) -> void:
	if collected == 0:
		collected = 0
		Global.checkpointx = Global.playerx
		Global.checkpointy = Global.playery
		print(Global.checkpointy)
		$FlagSFX.play()
