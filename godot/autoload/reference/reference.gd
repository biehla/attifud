extends Node

const RESOURCE_EXTENSION = ".tres"

var _resource_references: Dictionary = {}


func get_scene_manager_options(resource_name: String) -> SceneManagerOptions:
	var key: String = _get_key(resource_name, SceneManagerOptions)
	return _resource_references[key]


func _ready() -> void:
	Log.debug("AUTOLOAD READY: ", name)

	_init()


func _init() -> void:
	var root_path: String = PathConsts.RESOURCES
	var paths: Array[String] = FileSystemUtils.get_paths(root_path, RESOURCE_EXTENSION)
	_resource_references = _load_resources(paths)


static func _load_resources(paths: Array[String]) -> Dictionary:
	var resource_references: Dictionary = {}
	for path: String in paths:
		var resource: Resource = load(path) as Resource
		if resource != null:
			var resource_name: String = FileSystemUtils.get_file_name(path)
			var key: String = _get_key(resource_name, _get_type(resource))
			if resource_references.has(key):
				Log.warn("Duplicate resource reference key: ", key)
				continue
			resource_references[key] = resource
			Log.debug("Success to load resource reference key: ", key)
		else:
			Log.warn("Failed to load resource reference at: ", path)
	return resource_references


static func _get_type(resource: Resource) -> Variant:
	return resource.get_script()


static func _get_key(resource_name: String, type: Variant) -> String:
	return type.get_global_name() + "-" + resource_name
