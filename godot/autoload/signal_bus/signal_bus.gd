## Original File MIT License Copyright (c) 2024 TinyTakinTeller
extends Node

## UI
signal menu_button_pressed(id: MenuButtonEnum.ID, source: MenuButtonClass)
signal menu_slider_value_changed(id: MenuSliderEnum.ID, value: float, source: MenuSlider)
signal menu_toggle_value_changed(id: MenuToggleEnum.ID, enabled: bool, source: MenuToggle)
signal menu_dropdown_option_selected(id: MenuDropdownEnum.ID, index: int, source: MenuDropdown)

## Configuration
signal language_changed(locale: String)
signal display_mode_reloaded(index: int)
