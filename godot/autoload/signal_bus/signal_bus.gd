## Original File MIT License Copyright (c) 2024 TinyTakinTeller
extends Node

## UI
signal language_changed(locale: String)
signal menu_button_pressed(id: MenuButtonEnum.ID, source: MenuButtonClass)
signal menu_slider_value_changed(id: MenuSliderEnum.ID, value: float, source: MenuSlider)
signal menu_toggle_value_changed(id: MenuToggleEnum.ID, value: bool, source: MenuToggle)
