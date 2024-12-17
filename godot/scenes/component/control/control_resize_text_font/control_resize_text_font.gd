## Original File MIT License Copyright (c) 2024 TinyTakinTeller
##
## Purpose of this node it to scale fonts in projects where Window Stretch Mode is disabled.
##
## Attach to parent node.
## Adjusts font size in all children, relative to original window size.
## The scaling mode keeps aspect ratio (picks the smaller of the x and y resize ratios).
##
## Configure minimum_width and minimum_height exports to down scale only after a certain threshold.
## Configure auto exports to automatically adjust minimum exports to given node dimensions.
##
## Exports should not be set from code.
class_name ControlResizeTextFont
extends Node

const DEFAULT_FONT_SIZE: int = 16
const DEFAULT_SEPARATION: int = 0

@export var minimum_font_size: int = 16
@export var minimum_width: int = 0
@export var minimum_height: int = 0
@export var auto_minimum_width: Control
@export var auto_minimum_height: Control
@export var resize_separation: bool = true

var _new_auto_minimum: bool = false
var _resize_factor: float = 1.0
var _original_font_size_map: Dictionary = {}
var _original_separation_map: Dictionary = {}
var _original_width: int = ProjectSettings.get_setting("display/window/size/viewport_width")
var _original_height: int = ProjectSettings.get_setting("display/window/size/viewport_height")


func _ready() -> void:
	_connect_signals()
	_init_original_font_size_map(get_parent().get_children())
	resize_font_with_new_auto_minimum(get_viewport().size.x, get_viewport().size.y)


func resize_font(new_width: int, new_height: int) -> void:
	var original_width: int = _original_width
	var original_heigh: int = _original_height

	var resize_factor_x: float = float(new_width) / float(original_width)
	if minimum_width != 0 and new_width >= minimum_width and resize_factor_x < 1.0:
		resize_factor_x = 1.0
	if minimum_width != 0 and new_width < minimum_width:
		resize_factor_x = float(new_width) / float(minimum_width)

	var resize_factor_y: float = float(new_height) / float(original_heigh)
	if minimum_height != 0 and new_height >= minimum_height and resize_factor_y < 1.0:
		resize_factor_y = 1.0
	if minimum_height != 0 and new_height < minimum_height:
		resize_factor_y = float(new_height) / float(minimum_height)

	var resize_factor: float = min(resize_factor_x, resize_factor_y)

	if resize_factor == _resize_factor:
		return
	_resize_factor = resize_factor

	Log.debug("Resize %s font for %d x %d" % [get_parent().name, new_width, new_height])
	for node_instance_id: int in _original_font_size_map.keys():
		var node: Node = instance_from_id(node_instance_id)
		var original_font_size: int = _original_font_size_map.get(node_instance_id)
		var original_separation_size: int = _original_separation_map.get(node_instance_id)

		var new_font_size: int = max(
			round(float(original_font_size) * resize_factor),
			min(original_font_size, minimum_font_size)
		)
		node.set("theme_override_font_sizes/font_size", new_font_size)

		if resize_separation:
			var new_separation_size: int = round(float(original_separation_size) * resize_factor)
			node.set("theme_override_constants/separation", new_separation_size)


func resize_font_with_new_auto_minimum(new_width: int, new_height: int) -> void:
	if auto_minimum_width == null and auto_minimum_height == null:
		resize_font(get_viewport().size.x, get_viewport().size.y)

	_new_auto_minimum = true
	resize_font(_original_width, _original_height)
	if auto_minimum_width != null:
		minimum_width = round(auto_minimum_width.size.x)
	if auto_minimum_height != null:
		minimum_height = round(auto_minimum_height.size.y)
	resize_font(new_width, new_height)
	_new_auto_minimum = false


func _init_original_font_size_map(children: Array) -> void:
	for node: Node in children:
		_init_original_font_size_map(node.get_children(true))

		_add_to_font_size_map(node)
		_add_to_separation_map(node)


func _add_to_font_size_map(node: Node) -> void:
	var original_font_size: int = _get_font_size(node)
	_original_font_size_map[node.get_instance_id()] = original_font_size


func _add_to_separation_map(node: Node) -> void:
	var original_separation: int = _get_separation(node)
	_original_separation_map[node.get_instance_id()] = original_separation


func _connect_signals() -> void:
	get_parent().resized.connect(_on_viewport_size_changed)

	if auto_minimum_width != null:
		auto_minimum_width.resized.connect(_on_auto_resized)
	if auto_minimum_height != null and auto_minimum_height != auto_minimum_width:
		auto_minimum_height.resized.connect(_on_auto_resized)


func _on_viewport_size_changed() -> void:
	resize_font(get_viewport().size.x, get_viewport().size.y)


func _on_auto_resized() -> void:
	if not _new_auto_minimum:
		resize_font_with_new_auto_minimum(get_viewport().size.x, get_viewport().size.y)


static func _get_font_size(node: Node) -> int:
	return (
		node.get("theme_override_font_sizes/font_size")
		if node.get("theme_override_font_sizes/font_size") != null
		else DEFAULT_FONT_SIZE
	)


static func _get_separation(node: Node) -> int:
	return (
		node.get("theme_override_constants/separation")
		if node.get("theme_override_constants/separation") != null
		else DEFAULT_SEPARATION
	)
