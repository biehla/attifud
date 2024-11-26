extends Control

var boot_splash_color: Color = ProjectSettings.get("application/boot_splash/bg_color")
var boot_splash_image: String = ProjectSettings.get("application/boot_splash/image")
var boot_splash_texture: Texture = load(boot_splash_image)

@onready var boot_splash_color_rect: ColorRect = %BootSplashColorRect
@onready var boot_splash_texture_rect: TextureRect = %BootSplashTextureRect


func _ready() -> void:
	boot_splash_color_rect.color = boot_splash_color
	boot_splash_texture_rect.texture = boot_splash_texture
