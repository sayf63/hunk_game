extends Area3D

@onready var player = $"../Hunk_Prototype"

@onready var camera_2 = $"../camera2"


@export var target_camera_path: NodePath # Path to the Camera3D node you want to switch to

func _ready():
	# Connect the signals
	body_entered.connect(_on_Area3D_body_entered)

func _on_Area3D_body_entered(body: Node3D):
	if body.is_in_group("player"): # Assuming your player is in a "player" group
		var target_camera = get_node(camera_2)
		if target_camera:
			target_camera.make_current()
