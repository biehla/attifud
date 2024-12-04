
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

- Code
	- Use **snake_case** for files, folders, variables, functions.
	- Use **PascalCase** for nodes, classes, enums, types.
	- Use **typed** variables and functions.
	- Use **style** inspired by [GDScript Style](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html) (see *gdlintrc*).


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

### 💎 Globals

- **Configuration**
	- Configure Plugins & Project depending on environment.

- **Reference**
	- Preloads & holds references to Resources.
	- When creating a new Resource type, create a getter method here.

- **SignalBus**
	- TODO

- **Wrapper**
	- **SceneManagerWrapper** - call SceneManager with options presets Resource.

### 🎬 Scenes

- **BootSplash**
	- Main Scene, smoothly transitions from Boot Splash to true main scene.

- **MainMenu**
	- TODO

- **OptionsMenu**
	- TODO

### 📄 Scripts

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

- **gdlint**
	- On git push, automatically check *gdlintrc* coding style standards.

### ⚡ Hacks

- **Web Export (Presets)**
	- There is [Godot 4.3 Issue](https://github.com/godotengine/godot/issues/96874) with Boot Splash properties (background and loading bar color) not being passed to Web Export. A workaround includes css in **Head Include**:
		```
		<style id=boot_splash>
		#status { background-color: black; }
		progress { accent-color: white; }
		</style>
		```

## 📖 Get Started

- Click "Use this template" in Github, then open the project in Godot Engine.


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
