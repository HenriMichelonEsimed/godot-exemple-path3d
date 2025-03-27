class_name Enemy extends CharacterBody3D

var path_follow:PathFollow3D;
var movement_speed:float = 0.001;

func _ready() -> void:
	path_follow = get_parent()

func _physics_process(delta: float) -> void:
	path_follow.progress_ratio = wrapf(path_follow.progress_ratio + movement_speed, 0.0, 1.0)
