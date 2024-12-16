
![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/readme_logo.png)


# Takin - Godot Template

**Godot 4.3+** template for game projects (GDScript).

**TODO:** This template is a work in progress. (Full version in 2025.)

![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/readme_preview.png)



## ⭐ Features


- **Core**
	- 🌄 [**Scene Manager**](https://github.com/maktoobgar/scene_manager) - Custom transitions and loading screens.
	- 🎵 **Audio Manager** - TODO: ...
	- 💾 **Save Files** - TODO: ...
	- 📢 **Signal Bus** - Observer pattern for cleaner global signals.
	- 📖 **References** - Map of preloaded resources for convenience.
- **Localization**
	- 🌍 [**Polygot Template**](https://github.com/agens-no/PolyglotUnity) with 28 languages and over 600 common [game words](https://docs.google.com/spreadsheets/d/17f0dQawb-s_Fd7DHgmVvJoEGDMH_yoSd8EYigrb0zmM/edit?gid=296134756#gid=296134756).
	- ✏️ [**Google Noto Sans**](https://fonts.google.com/) fonts for all glyphs (Arabic, Hebrew, HK, JP, KR, SC, TC, Thai).
- **Accessibility**
	- 🎮 **Controller Support** -  Grab focus for a control node on entering scene.
	- 🔍 **Smooth Font** - Dynamic font size (keep aspect ratio) on window resize.
- **UI/UX**
	- 🎬 **Boot Splash** - The main scene, allowing custom transition to main menu.
	- ⚙️ **Options Menu** - TODO: ...
	- 📜 **Credits Menu** - TODO: ...
	- ⏸️ **Pause Menu** - TODO: ...
- **Utility**
	- 🧰 **Scripts** - RNG (Weighted Loot Table), Maths, Files, Nodes, Strings.
	- 🛠️ **Objects** - ConfigManager (INI File), LinkedMap.
- **Graphics**
	- 🎨 **Theme** - TODO: ...
	- 📽️ **Post-Processing** - TODO: ...
- **Tools**
	- 🐛 [**Logger**](https://github.com/albinaask/Log) - Easier debugging and troubleshooting.
	- 🧩 [**IDE Plugin**](https://github.com/Maran23/script-ide) - Improves scripting in GDScript in editor.
	- 📋 [**Resource View**](https://github.com/don-tnowe/godot-resources-as-sheets-plugin/tree/Godot-4) - Better resource management in editor.
	- ✨ [**GDScript Toolkit**](https://github.com/Scony/godot-gdscript-toolkit) - Code style [formatting](https://github.com/ryan-haskell/gdformat-on-save) on save and [linter](https://github.com/el-falso/gdlinter).
- **Workflow**
	- 🚀 **Deployment** - TODO: ...
	- ✅ **Actions** - Verify style and formatting in GDScript code on push to Github.



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
	- TODO: ...
- **Save Files**
	- TODO: ...
- **Post-Processing**
	- TODO: ...

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
	- Exchange global signals for cleaner observer pattern.
- **Wrapper** : *Extend functionality without modifying the original.*
	- **SceneManagerWrapper** - Calls SceneManager with options presets Resource.
	- **TranslationServerWrapper** - Extends `tr()` to work in tool scripts.

### 🎬 Scenes

- **Component**
	- **Control**
		- **ControlGrabFocus** - Grabs focus of UI node for controller support.
		- **ControlResizeTextFont** - Smooth text scaling with window resolution.
	- **Menu**
		- **MenuButton** - Localized menu button.
- **View**
	- **BootSplash** *(Main Scene)*  - Smooth transition to MainMenu scene.
	- **MainMenu**
		- **OptionsMenu** - TODO: ...
		- **CreditsMenu** - TODO: ...
	- **PlayScene** - TODO: ...
		- **PauseMenu** - TODO: ...


### 📄 Scripts

- **Objects**
	- **LinkedMap** - Dictionary data structure that tracks order of keys.
	- **ConfigManager** - Persists (save & load) app settings (global app data).

- **Utils**
	- **FileSystemUtils**
	- **MathUtils**
	- **NodeUtils**
	- **RandomUtils**
	- **StringUtils**

## 🎉 CI/CD

### 🚀 Deployment

- **Github Pages**
	- TODO: ...
- **Itch.io**
	- TODO: ...

### ✅ Workflows

- **quality_check.yml**
	- Automatically check *gdlintrc* coding style standards.

### ⚡ Hacks

- **Web Export (Presets)**
	- There is [Godot 4.3 Issue](https://github.com/godotengine/godot/issues/96874) with Boot Splash, workaround is CSS in **Head Include**.


## 📖 Instructions

### 📘 Get Started

- Click [Use this template](https://github.com/new?template_name=TakinGodotTemplate&template_owner=TinyTakinTeller) in Github, then open the project in Godot Engine.
- Setup [GDScript Toolkit](https://github.com/Scony/godot-gdscript-toolkit) python package to use formatter and linter plugins.

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
