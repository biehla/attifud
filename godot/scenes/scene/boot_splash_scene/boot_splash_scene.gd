## Original File MIT License Copyright (c) 2024 TinyTakinTeller
extends Control

@export_group("Next Scene")
@export var scene_id: String = "menu_scene"
@export var scene_manager_options_id: String = "fade_basic"

var _boot_splash_color: Color = ProjectSettings.get("application/boot_splash/bg_color")
var _boot_splash_image_path: String = ProjectSettings.get("application/boot_splash/image")
var _boot_splash_texture: Texture = load(_boot_splash_image_path)

@onready var boot_splash_color_rect: ColorRect = %BootSplashColorRect
@onready var boot_splash_texture_rect: TextureRect = %BootSplashTextureRect


func _ready() -> void:
	Log.debug("MAIN SCENE READY: ", name)

	boot_splash_color_rect.color = _boot_splash_color
	boot_splash_texture_rect.texture = _boot_splash_texture

	SceneManagerWrapper.change_scene(scene_id, scene_manager_options_id)
