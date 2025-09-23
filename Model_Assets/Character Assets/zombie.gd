extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var anim_tree: AnimationTree = $AnimationTree


var player: Node3D
const SPEED: float = 4.0
@export var player_path = "../player"
const RANGE = 20

func _ready() -> void:
	player = get_node(player_path)

func _physics_process(delta: float) -> void:
	nav_agent.set_target_position(player.global_transform.origin)
	var next_nav_point = nav_agent.get_next_path_position()
	var direction = (next_nav_point - global_transform.origin).normalized()
	velocity = direction * SPEED
	
	
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z),Vector3.UP)
	
	anim_tree.set("parameters/conditions/zombie_run",_player_in_range())
	move_and_slide()
	
func _player_in_range():
	return global_position.distance_to(player.global_position) < RANGE
