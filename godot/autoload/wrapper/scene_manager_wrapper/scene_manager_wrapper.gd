extends Node


func _ready() -> void:
	Log.debug("AUTOLOAD READY: ", name)


## Change scene using preset options.
func change_scene(scene_name: String, scene_manager_options_name: String) -> void:
	var scene_manager_options: SceneManagerOptions = Reference.get_scene_manager_options(
		scene_manager_options_name
	)
	SceneManager.change_scene(
		scene_name,
		scene_manager_options.create_fade_out_options(),
		scene_manager_options.create_fade_in_options(),
		scene_manager_options.create_general_options()
	)
