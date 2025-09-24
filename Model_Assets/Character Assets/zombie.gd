extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var anim_tree: AnimationTree = $AnimationTree

var player: Node3D
const SPEED: float = 4.0
@export var player_path = "../player"
const RANGE: float = 20.0

func _ready() -> void:
	player = get_node(player_path)
	anim_tree.active = true  # Make sure AnimationTree is running

func _physics_process(delta: float) -> void:
	if not player:
		return
	
	var player_pos = player.global_position
	nav_agent.set_target_position(player_pos)
	
	var next_nav_point = nav_agent.get_next_path_position()
	var direction = (next_nav_point - global_position).normalized()
	
	# Only move if player is in range
	if _player_in_range():
		velocity = direction * SPEED
	else:
		velocity = Vector3.ZERO
	
	# Smooth look at player (optional: add lerp for smoother rotation)
	look_at(Vector3(player_pos.x, global_position.y, player_pos.z), Vector3.UP)
	
	# Tell animation tree whether to play Idle or Run
	anim_tree.set("parameters/conditions/zombie_run", _player_in_range())
	
	move_and_slide()

func _player_in_range() -> bool:
	return global_position.distance_to(player.global_position) < RANGE
