
![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/takin_godot_template_logo.png)


# Takin Godot Template

**Godot 4.3+** template for game projects (GDScript).


### Features

- **TODO:** This template is a work in progress.


### File Structure

- **.github**
	- **docs**
	- **workflows**
- **godot**
	- **addons** (Plugins)
	- **assets** *(.png, .mp3, .csv, .ttf, ...)*
	- **autoload** (Globals)
	- **resources** *(.tres, .gd)*
	- **scenes** *(.tscn, .gd)*
	- **scripts** *(static/const .gd)*
	- **shaders** *(.gdshader)*
	- export_presets.cfg
	- gdlintrc
	- project.godot (ProjectSettings)
- .gitattributes
- .gitignore
- LICENSE
- README.md


### Conventions

Naming
- **snake_case** for files system (file, folder) & code instances (variable, function).
- **PascalCase** for nodes & code definitions (class, type).

Code
- **typed** types such as variable types, return types.
- **style** inspired by [GDScript Style](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html) (open *gdlintrc* file as txt to see ruleset).


### Plugins

- **GDScript Toolkit**
	- This project uses addons [Format on Save](https://github.com/ryan-haskell/gdformat-on-save) and [gdLinter](https://github.com/el-falso/gdlinter) (enforces *gdlintrc*).
	- They require [GDScript Toolkit](https://github.com/Scony/godot-gdscript-toolkit) python package being installed.

- **Scene Manager**
	- TODO

- **Audio Manager**
	- TODO

- **Persistence Manager**
	- TODO


### Deployment

- **TODO**


### Get Started

- Click "Use this template" in Github, then open the project in Godot Engine.


### Contribute

- Open a new Issue for discussion first, later Fork and open a pull request.


### Acknowledgements

Godot Engine
- [Godot Engine](https://github.com/godotengine/godot)
- [Redot Engine](https://github.com/Redot-Engine/redot-engine)

Godot Templates
- [Bitbrain Godot Game Jam Template](https://github.com/bitbrain/godot-gamejam)
- [CrystalBit Godot Game Template](https://github.com/crystal-bit/godot-game-template)
- [Maaack Godot Game Template](https://github.com/Maaack/Godot-Game-Template)
