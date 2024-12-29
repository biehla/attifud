## Original File MIT License Copyright (c) 2024 TinyTakinTeller
## [br][br]
## Manages global video options. Updates on external video option changes (reloaded signal).
extends MarginContainer

var _action_handler: ActionHandler = ActionHandler.new()

@onready var display_mode_menu_dropdown: MenuDropdown = %DisplayModeMenuDropdown
@onready var resolution_menu_dropdown: MenuDropdown = %ResolutionMenuDropdown
@onready var vsync_mode_menu_dropdown: MenuDropdown = %VsyncModeMenuDropdown
@onready var fps_limit_menu_dropdown: MenuDropdown = %FPSLimitMenuDropdown
@onready var fps_count_menu_toggle: MenuToggle = %FPSCountMenuToggle
@onready var anti_alias_menu_dropdown: MenuDropdown = %AntiAliasMenuDropdown


func _ready() -> void:
	_connect_signals()
	_init_menu_nodes()
	_init_action_handler()
	_load_video_options()
	_display_resolution_lock_toggle_check.call_deferred()


func _load_video_options() -> void:
	var anti_alias_option_index: int = Configuration.video.anti_alias.get_option_index()
	var display_mode_option_index: int = Configuration.video.display_mode.get_option_index()
	var fps_count_enabled: bool = Configuration.video.fps_count.is_fps_count_enabled()
	var fps_limit_option_index: int = Configuration.video.fps_limit.get_option_index()
	var resolution_option_index: int = Configuration.video.resolution.get_option_index()
	var vsync_mode_option_index: int = Configuration.video.vsync_mode.get_option_index()

	anti_alias_menu_dropdown.set_option(anti_alias_option_index)
	display_mode_menu_dropdown.set_option(display_mode_option_index)
	fps_count_menu_toggle.set_value(fps_count_enabled)
	fps_limit_menu_dropdown.set_option(fps_limit_option_index)
	resolution_menu_dropdown.set_option(resolution_option_index)
	vsync_mode_menu_dropdown.set_option(vsync_mode_option_index)


func _init_action_handler() -> void:
	_action_handler.set_register_type("MenuDropdown")
	_action_handler.register_actions(
		{
			MenuDropdownEnum.ID.ANTI_ALIAS: _action_anti_alias_menu_dropdown,
			MenuDropdownEnum.ID.DISPLAY_MODE: _action_display_mode_menu_dropdown,
			MenuDropdownEnum.ID.FPS_LIMIT: _action_fps_limit_menu_dropdown,
			MenuDropdownEnum.ID.RESOLUTION: _action_resolution_menu_dropdown,
			MenuDropdownEnum.ID.VSYNC_MODE: _action_vsync_mode_menu_dropdown
		}
	)

	_action_handler.set_register_type("MenuToggle")
	_action_handler.register_action(MenuToggleEnum.ID.FPS_COUNT, _action_fps_count_menu_toggle)

	_action_handler.set_register_type("MenuButton")
	_action_handler.register_action(MenuButtonEnum.ID.OPTIONS_MENU_RESET, _action_reset_menu_button)


func _action_anti_alias_menu_dropdown(index: int) -> void:
	Configuration.video.anti_alias.set_option_index(index)


func _action_display_mode_menu_dropdown(index: int) -> void:
	Configuration.video.display_mode.set_option_index(index)


func _action_fps_limit_menu_dropdown(index: int) -> void:
	Configuration.video.fps_limit.set_option_index(index)


func _action_resolution_menu_dropdown(index: int) -> void:
	Configuration.video.resolution.set_option_index(index)


func _action_fps_count_menu_toggle(enabled: bool) -> void:
	Configuration.video.fps_count.set_fps_count_enabled(enabled)


func _action_vsync_mode_menu_dropdown(index: int) -> void:
	Configuration.video.vsync_mode.set_option_index(index)


func _action_reset_menu_button() -> void:
	if not is_visible_in_tree():
		return

	Configuration.video.reset()
	_load_video_options()


func _init_menu_nodes() -> void:
	_init_anti_alias_menu_dropdown()
	_init_display_mode_menu_dropdown()
	_init_fps_limit_menu_dropdown()
	_init_resolution_menu_dropdown()
	_init_vsync_mode_menu_dropdown()


func _init_anti_alias_menu_dropdown() -> void:
	var anti_aliases: Array[String] = Configuration.video.anti_alias.options.get_keys()
	anti_alias_menu_dropdown.init_options(anti_aliases)
	if Configuration.video.anti_alias.disabled:
		anti_alias_menu_dropdown.disable()


func _init_display_mode_menu_dropdown() -> void:
	var display_modes: Array[String] = Configuration.video.display_mode.options.get_keys()
	var display_disabled_options: Dictionary = {}
	display_disabled_options = Configuration.video.display_mode.disabled_options
	display_mode_menu_dropdown.init_options(display_modes, display_disabled_options)


func _init_fps_limit_menu_dropdown() -> void:
	var fps_limits: Array[String] = Configuration.video.fps_limit.options.get_keys()
	fps_limit_menu_dropdown.init_options(fps_limits)


func _init_resolution_menu_dropdown() -> void:
	var resolutions: Array[String] = Configuration.video.resolution.options.get_keys()
	resolution_menu_dropdown.init_options(resolutions)
	if Configuration.video.resolution.disabled:
		resolution_menu_dropdown.disable()


func _init_vsync_mode_menu_dropdown() -> void:
	var vsync_modes: Array[String] = Configuration.video.vsync_mode.options.get_keys()
	var display_vsync_options: Dictionary = {}
	display_vsync_options = Configuration.video.vsync_mode.disabled_options
	vsync_mode_menu_dropdown.init_options(vsync_modes, display_vsync_options)


func _display_resolution_lock_toggle(
	window_mode: DisplayServer.WindowMode, window_size: Vector2i
) -> void:
	if Configuration.video.resolution.disabled:
		return

	if window_mode == DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
		resolution_menu_dropdown.enable()
	else:
		resolution_menu_dropdown.disable("%s x %s" % [window_size.x, window_size.y])


func _display_resolution_lock_toggle_check() -> void:
	_display_resolution_lock_toggle(DisplayServer.window_get_mode(), get_tree().get_root().size)


func _connect_signals() -> void:
	SignalBus.configuration_display_mode_reloaded.connect(_on_display_mode_reloaded)
	SignalBus.configuration_display_size_changed.connect(_on_display_size_changed)

	SignalBus.menu_dropdown_option_selected.connect(_on_menu_dropdown_option_selected)
	SignalBus.menu_toggle_value_changed.connect(_on_menu_toggle_value_changed)
	SignalBus.menu_button_pressed.connect(_on_menu_button_pressed)


func _on_display_mode_reloaded(index: int) -> void:
	display_mode_menu_dropdown.set_option(index)
	Configuration.video.display_mode.set_option_index(index)

	var resolution_option_index: int = Configuration.video.resolution.refresh_resolution()
	resolution_menu_dropdown.set_option(resolution_option_index)

	_display_resolution_lock_toggle_check.call_deferred()


func _on_display_size_changed(window_mode: DisplayServer.WindowMode, window_size: Vector2i) -> void:
	_display_resolution_lock_toggle.call_deferred(window_mode, window_size)


func _on_menu_dropdown_option_selected(
	id: MenuDropdownEnum.ID, index: int, _source: MenuDropdown
) -> void:
	_action_handler.handle_action_args("MenuDropdown", id, self, [index])


func _on_menu_toggle_value_changed(
	id: MenuToggleEnum.ID, enabled: bool, _source: MenuToggle
) -> void:
	_action_handler.handle_action_args("MenuToggle", id, self, [enabled])


func _on_menu_button_pressed(id: MenuButtonEnum.ID, _source: MenuButtonClass) -> void:
	_action_handler.handle_action("MenuButton", id, self)
