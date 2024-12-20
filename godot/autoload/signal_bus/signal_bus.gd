## Original File MIT License Copyright (c) 2024 TinyTakinTeller
extends Node

## UI
signal menu_button_pressed(id: MenuButtonEnum.ID, source: MenuButtonClass)
signal menu_slider_value_changed(id: MenuSliderEnum.ID, value: float, source: MenuSlider)
signal menu_toggle_value_changed(id: MenuToggleEnum.ID, enabled: bool, source: MenuToggle)

## Configuration
signal language_changed(locale: String)
