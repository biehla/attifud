
![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/readme_logo.png)


# Takin - Godot Template

**Godot 4.3** template for game projects (GDScript).

Collection of curated plugins and custom features to kick-start new projects.

🚨 **TODO:** This template is a work in progress. (Full version in 2025.)



## ♦️ Examples

<details>
<summary>Preview Screenshots</summary>

![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/readme_preview.png)

</details>

## ⭐ Features

### ✨ Game

- **Foundation**
	- 🖼️ [**Scene Manager**](https://github.com/maktoobgar/scene_manager) - Custom transitions and loading screens.
	- 🎵 [**Audio Manager**](https://github.com/hugemenace/resonate) - Reliable music tracks and sound effects.
	- ⚙️ **Configuration** - Persistent game options and statistics in INI file.
	- 💾 **Save Files** - TODO: ...
- **Localization**
	- 🌍 [**Polygot Template**](https://github.com/agens-no/PolyglotUnity) with 28 languages and over 600 common [game words](https://docs.google.com/spreadsheets/d/17f0dQawb-s_Fd7DHgmVvJoEGDMH_yoSd8EYigrb0zmM/edit?gid=296134756#gid=296134756).
	- ✏️ [**Google Noto Sans**](https://fonts.google.com/) fonts for all glyphs (Arabic, Hebrew, HK, JP, KR, SC, TC, Thai).
- **Accessibility**
	- 🎮 **Controller Support** - Grab UI focus for joypad and keyboard users.
	- 🔍 **Smooth Font** - Dynamic font size (keep aspect ratio) on window resize.
- **Placeholder**
	- 🎨 **Theme** - TODO: ...
	- 🎶 **Music & SFX** - [CC0](https://creativecommons.org/publicdomain/zero/1.0/) Public Domain: [Kenny](https://kenney.nl/assets/category:Audio) SFX and [OGA](https://opengameart.org/content/menu-doodle-2) Music (looped edit).
	- 📽️ **Post-Processing** - TODO: ...
- **UI/UX**
	- 🎬 **Boot Splash** - The main scene, allowing custom transition to main menu.
	- 🏠 **Main Menu** - Display buttons to enter other menus, version and author.
	- 🔧 **Options Menu** - Audio, Video (display, vsync), Controls (keybinds), Game.
	- 📜 **Credits Menu** - TODO: ...
	- 📓 **Save Files Menu** - TODO: ...
	- ⏸️ **Pause Menu** - TODO: ...

### 💫 Development

- **Singletons**
	- 📢 **Signal Bus** - Observer pattern for cleaner global signals.
	- 📖 **References** - Map of preloaded resources for convenience.
- **Scripts**
	- 🧰 **Utility** - RNG (Weighted Loot Table), Maths, Files, Nodes, Strings.
	- 🛠️ **Objects** - ActionHandler, ConfigStorage (INI File), LinkedMap.
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
	- **scripts** *(static/const/object .gd)*
	- **shaders** *(.gdshader)*
	- export_presets.cfg
	- gdlintrc
	- project.godot (ProjectSettings)
- .gitattributes
- .gitignore
- LICENSE
- README.md



## 📜 Conventions

- Clean Code
	- Use **snake_case** for files, folders, variables, functions.
	- Use **PascalCase** for nodes, classes, enums, types.
	- Use **typed** variables and functions.
	- Use **style** inspired by [GDScript Style](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html) (see *gdlintrc*).
	- Function definition order: [override](https://docs.godotengine.org/en/stable/tutorials/scripting/overridable_functions.html), public, private, static.
	- Consider using [**good design patterns**](https://refactoring.guru/design-patterns) when programming.
	- Consider maintaining **enum** values when appropriate.



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
	- The [Resonate](https://github.com/hugemenace/resonate) addon handles music tracks and sound effects.
	- For a complex audio project, consider using FMOD or WWise.
- **Save Files**
	- TODO: ...
- **Post-Processing**
	- TODO: ...



## 🤖 Code

The Globals (autoload Scenes) and Scripts (statics, consts, objects) are available from anywhere in the project. The latter is independent of (not managed by) the Scene Tree.

Otherwise, Scenes must be loaded or added to the Scene Tree.

### 💎 Globals

- **Configuration**
	- First autoload (after Plugin autoloads).
	- Configure Project, use ConfigStorage object for user config presistence.
- **Reference**
	- Preloads & holds references to Resources in dictionary by name.
	- When creating a new Resource type, consider creating a getter here.
- **SignalBus**
	- Exchange global signals for cleaner observer pattern.
- **Wrapper** : *Extend functionality without modifying the original.*
	- **AudioWrapper** - Calls Resonance plugin with enums instead of string names.
	- **SceneManagerWrapper** - Calls SceneManager with options presets Resource.
	- **TranslationServerWrapper** - Extends localization to work in tool scripts.

### 🎬 Scenes

Scenes are split into component, node and scene folders.
1. Component  : _Add as a child to extend parent functionality by composition._
2. Node   : _Add as a standalone building block of a larger construction._
3. Scene  : _Presentable collection of other scenes, nodes and components._


- **Component**
	- **Audio**
		- **ButtonAudio** - Emits audio events on signals (focus, click, release).
		- **SliderAudio** - Emits audio events on signals (drag start, drag end).
	- **Control**
		- **ControlGrabFocus** - Grabs focus of node for controller support.
		- **ControlResizeTextFont** - Smooth text scaling with window resolution.
- **Node**
	- **Expand**
		- **HSliderExpand** - Expands to fill the parent node (custom UI scaling).
	- **Menu**
		- **MenuButton** - Localized menu button.
		- **MenuDropdown** - Localized dropdown option button.
		- **MenuSlider** - Localized menu slider with accessibility buttons.
		- **MenuToggle** - Localized menu toggle button (ON or OFF).
- **Scene**
	- **BootSplashScene** *(Main Scene)*  - Smooth transition to menu scene.
	- **MenuScene** - Manages menu scenes as children.
		- **MainMenu** - Display buttons to enter other menus or next scene.
		- **OptionsMenu** - Manages options (persistent app settings) scenes.
			- **AudioOptions** - Configure Music and SFX volume or mute.
			- **VideoOptions** - TODO: ...
			- **ControlsOptions** - TODO: ...
			- **GameOptions** - TODO: ...
		- **CreditsMenu** - TODO: ...
		- **SaveFilesMenu** - TODO: ...
	- **PlayScene** - TODO: ...
		- **PauseMenu** - TODO: ...

### 📄 Scripts

- **Const** - Collections of commonly used constants.
- **Enum** - Collections of organised values.
- **Object**
	- **ActionHandler** - Implements the (light) [command pattern](https://refactoring.guru/design-patterns/command) design.
	- **ConfigStorage** - Persists (save & load) app settings in INI file.
	- **LinkedMap** - Dictionary data structure that tracks order of keys.
- **Util**
	- **FileSystemUtils** - Robust functions to extract file paths and names.
	- **MathUtils** - Integer power function.
	- **NodeUtils** - Collection of node manipulation functions.
	- **RandomUtils** - Weighted Loot Table and random string functions.
	- **StringUtils** - String functions for validation and padding.



## 🎉 CI/CD

### 🚀 Deployment

- **Github Pages**
	- TODO: ...
- **Itch.io**
	- TODO: ...

### ✅ Workflows

- **quality_check.yml**
	- Automatically check *gdlintrc* coding style standards.



## ⚡ Hacks

Godot Engine [has known issues](https://github.com/godotengine/godot/issues) requiring hacks (workarounds) until officially resolved.

Below is a list of issues that have workarounds implemented in this template.

- **Desktop**
	- TODO: See Godot Issues [#6247](https://github.com/godotengine/godot-proposals/issues/6247), [#3145](https://github.com/godotengine/godot-proposals/issues/3145) i.e.  `window_mode` before boot.
- **Web**
	- There is [Godot 4.3 Issue](https://github.com/godotengine/godot/issues/96874) with Boot Splash, workaround is CSS in **Head Include**.
	- There is [Godot 4.3 Issue](https://github.com/godotengine/godot/issues/100696) with `play_stream`, workaround was added for now.
	- TODO: See Godot Isssue [#43138](https://github.com/godotengine/godot/issues/43138) i.e. `window_mode` restricted to user focus.
- **Linux**
- **MacOS**
- **iOS**
- **Android**


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

- Godot Extensions
	- [Awesome Godot](https://github.com/godotengine/awesome-godot?tab=readme-ov-file)
	- [Powerful Godot](https://github.com/nonunknown/godot-powerful?tab=readme-ov-file)

- Godot Templates
	- [Bitbrain Godot Game Jam Template](https://github.com/bitbrain/godot-gamejam)
	- [CrystalBit Godot Game Template](https://github.com/crystal-bit/godot-game-template)
	- [Maaack Godot Game Template](https://github.com/Maaack/Godot-Game-Template)
	- [MechanicalFlower Template](https://github.com/MechanicalFlower/godot-template?tab=readme-ov-file)


