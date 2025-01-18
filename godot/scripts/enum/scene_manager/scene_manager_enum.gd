## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Tracks values related to [SceneManager] and [SceneManagerWrapper].
class_name SceneManagerEnum

## Tracks "Scenes" of [SceneManager].
enum SceneID { MENU_SCENE, GAME_SCENE }

## Tracks ["res://addons/scene_manager/shader_patterns/"] values used in [SceneManagerOptions].
enum ShaderPattern {
	FADE,
	CIRCLE,
	CROOKED_TILES,
	CURTAINS,
	DIAGONAL,
	DIRT,
	HORIZONTAL,
	PIXEL,
	RADIAL,
	SCRIBBLES,
	SPLASHED_DIRT,
	SQUARES,
	VERTICAL
}


static func shader_pattern_name(shader_pattern: SceneManagerEnum.ShaderPattern) -> String:
	return (SceneManagerEnum.ShaderPattern.keys()[shader_pattern] as String).to_lower()
