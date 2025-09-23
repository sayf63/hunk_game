extends Node

enum State {idle, agro}

var current_state = State.idle


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _process_idle(delta):
	pass

func _process_agro(delta):
	pass
