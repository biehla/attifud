
![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/readme_logo.png)


# Takin - Godot Template

**Godot 4.3+** template for game projects (GDScript).


## ✨ Features

- **TODO:** This template is a work in progress.


## 📂 File Structure

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


## 📜 Conventions

- Readable Code
	- Use **snake_case** for files, folders, variables, functions.
	- Use **PascalCase** for nodes, classes, enums, types.
	- Use **typed** variables and functions.
	- Use **style** inspired by [GDScript Style](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html) (see *gdlintrc*).
	- Function definition order: [override](https://docs.godotengine.org/en/stable/tutorials/scripting/overridable_functions.html), public, private, static.


## 🧩 Plugins

### 🔧 Editor

- **Script IDE**
	- The [Script-IDE](https://github.com/Maran23/script-ide) improves scripting, e.g. Ctrl+U, Ctrl+O.

- **Resource Tables**
	- The [Edit Resources as Table](https://github.com/don-tnowe/godot-resources-as-sheets-plugin/tree/Godot-4) adds view for managing Resources.

- **GDScript Toolkit**
	- This project uses addons [Format on Save](https://github.com/ryan-haskell/gdformat-on-save) and [gdLinter](https://github.com/el-falso/gdlinter) (enforces *gdlintrc*).
	- They require [GDScript Toolkit](https://github.com/Scony/godot-gdscript-toolkit) python package being installed.

### ⚙️ Engine

- **Logger**
	- The [Log](https://github.com/albinaask/Log) inspired by Log4J allows logging.

- **Scene Manager**
	- The [SceneManager](https://github.com/maktoobgar/scene_manager) handles Scenes transitions and loadings.

- **Audio Manager**
	- TODO

- **Persistence Manager**
	- TODO

- **Post-Processing**
	- TODO

## 🤖 Code

The Globals (autoload Scenes) and Scripts (static/const Objects) can be called from anywhere in the project. The latter is independent of (not managed by) the Scene Tree.

Otherwise, Scenes must be loaded or added to the Scene Tree.

### 💎 Globals

- **Configuration**
	- First autoload (after Plugin autoloads).
	- Configure Plugins, Assets & Project here, depending on needs.

- **Reference**
	- Preloads & holds references to Resources in dictionary by name.
	- When creating a new Resource type, consider creating a getter here.

- **SignalBus**
	- TODO

- **Wrapper** : *Extend functionality of a Plugin without modifying the original.*
	- **SceneManagerWrapper** - call SceneManager with options presets Resource.

### 🎬 Scenes

- **BootSplash** *(Main Scene)*
	- Smoothly transitions from Project Boot Splash to MainMenu scene.

- **MainMenu**
	- TODO

- **OptionsMenu**
	- TODO

### 📄 Scripts

- **Objects**
	- **ConfigManager** - Persists (save & load) app settings (global app data).
		- **ConfigManagerAppLog**
		- **ConfigManagerSettingsAudio**
		- **ConfigManagerSettingsControl**
		- **ConfigManagerSettingsVideo**

- **Utils**
	- **FileSystemUtils**
	- **MathUtils**
	- **NodeUtils**
	- **RandomUtils**

## 🎉 CI/CD

### 🚀 Deployment

- **Github Pages**
	- TODO

- **Itch.io**
	- TODO

### ✅ Workflows

- **quality_check.yml**
	- Automatically check *gdlintrc* coding style standards.

### ⚡ Hacks

- **Web Export (Presets)**
	- There is [Godot 4.3 Issue](https://github.com/godotengine/godot/issues/96874) with Boot Splash, workaround is CSS in **Head Include**.


## 📖 Instructions

### 📘 Get Started

- Click "Use this template" in Github, then open the project in Godot Engine.

### ❓ FAQ

-  Opening the project for the first time, I have errors/warnings?
	- Try (re)enable all Plugins and then select "Reload Current Project".


## 🫂 Contribute

- Open a new Issue for discussion first, later Fork and open a pull request.


## 💕 Acknowledgements

- Godot Engine
	- [Godot Engine](https://github.com/godotengine/godot)
	- [Redot Engine](https://github.com/Redot-Engine/redot-engine)

- Godot Templates
	- [Bitbrain Godot Game Jam Template](https://github.com/bitbrain/godot-gamejam)
	- [CrystalBit Godot Game Template](https://github.com/crystal-bit/godot-game-template)
	- [Maaack Godot Game Template](https://github.com/Maaack/Godot-Game-Template)
