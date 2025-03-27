class_name Level extends Node3D

@onready var player : Player  = $Player
@onready var level : Node3D = $Level

var enemies : Array[Enemy] = []

func _ready() -> void:
	for spawn_path:EnemySpawnPath in level.find_children("*", "EnemySpawnPath", false):
		if not spawn_path.enemy_scene:
			print("Enemy scene not set")
			continue
		# load and create a new enemy
		var enemy = spawn_path.enemy_scene.instantiate()
		# add it as a child to the PathFollow3D
		var path_follow:PathFollow3D = spawn_path.get_node("PathFollow3D");
		path_follow.add_child(enemy)
		# get a random position in the spawn path curve for the new enemy
		path_follow.progress_ratio  = randf()
		# add the enemy
		enemies.push_back(enemy)
	
