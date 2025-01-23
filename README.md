
![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/readme_logo.png)


# Takin - Godot Template

**Godot 4.3** template for game projects (GDScript).

Fusion of curated plugins, essential features and best practices to kick-start new projects.




## ♦️ Examples

Web version: https://tinytakinteller.itch.io/takin-godot-template

<details>
<summary> [CLICK HERE] Preview Screenshots </summary>

![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/readme_preview_1.png)

![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/readme_preview_6.png)

![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/readme_preview_2.png)

![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/readme_preview_3.png)

![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/readme_preview_4.png)

![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/readme_preview_5.png)

![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/readme_preview_7.png)

![](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/.github/docs/readme_preview_8.png)

</details>



## ⭐ Features

Swap modules with either simpler or advanced alternatives, depending on your project size.

### ✨ Game Modules

- **Foundation**
	- 🖼️ [**Scene Manager**](https://github.com/maktoobgar/scene_manager) - Custom transitions and loading screens.
	- 🎵 [**Audio Manager**](https://github.com/hugemenace/resonate) - Reliable music tracks and sound effects.
	- ⚙️ **Configuration** - Persistent game options and statistics in INI file.
	- 💾 **Save Files** - Modular save system for game data, optional encryption.
- **Localization**
	- 🌍 [**Polygot Template**](https://github.com/agens-no/PolyglotUnity) with 28 languages and over 600 [game words](https://docs.google.com/spreadsheets/d/17f0dQawb-s_Fd7DHgmVvJoEGDMH_yoSd8EYigrb0zmM/edit?gid=296134756#gid=296134756).
	- ✏️ [**Google Noto Sans**](https://fonts.google.com/) fonts glyphs (Arabic, Hebrew, HK, JP, KR, SC, TC, Thai).
- **Accessibility**
	- 🎮 **Controller Support** - Grab UI focus for joypad and keyboard users.
	- 🔍 **Multiple Resolutions** - Video options: display mode, window zoom.
	- ⚡ **Optimizations** - E.g. Native web dialog to capture clipboard.
- **UI/UX**
	- 🎬 **Boot Splash** - The main scene, allowing custom transition to main menu.
	- 🏠 **Main Menu** - Display buttons to enter other menus, version and author.
	- 🔧 **Options Menu** - Audio, Video (display, vsync), Controls (keybinds), Game.
	- 📜 **Credits Menu** - Renders [CREDITS.md](https://github.com/TinyTakinTeller/TakinGodotTemplate/blob/master/godot/CREDITS.md) file in-game with formatting.
	- 📓 **Save Files Menu** - List of files: Play, Import, Export, Delete, Rename.
	- 🎲 **Game Scene** - Example incremental game mechanics and effects.
	- ⏸️ **Pause Menu** - Pause gameplay, change options. Esc key shortcut.
- **Placeholder**
	- 🎨 **Theme** - Godot default theme. Alternatives at [Kenney](https://kenney.nl/assets/tag:interface?sort=update), [Itch](https://itch.io/c/1473270/themes-for-godot-games), [OGA](https://opengameart.org/art-search-advanced?keys=&title=&field_art_tags_tid_op=or&field_art_tags_tid=ui&name=&field_art_type_tid%5B%5D=9&sort_by=count&sort_order=DESC&items_per_page=24&Collection=), ...
	- 🖌️ **Images** - [CC0](https://creativecommons.org/publicdomain/zero/1.0/) Public Domain: [Dannya](https://openclipart.org/artist/dannya) save file icon, [Maaack](https://github.com/Maaack/Godot-Menus-Template/tree/main/addons/maaacks_menus_template/base/assets/images) icons.
	- 🎶 **Music & SFX** - [CC0](https://creativecommons.org/publicdomain/zero/1.0/) Public Domain: [Kenney](https://kenney.nl/assets/category:Audio) SFX and [OGA](https://opengameart.org/content/menu-doodle-2) Music (loop).

### 💫 Development Modules

- **Singletons**
	- 📢 **Signal Bus** - Observer pattern for cleaner global signals.
	- 📖 **References** - Map of preloaded resources for convenience.
- **Scripts**
	- 🧰 **Utility** - Datetime, File, Marshalls, Math, Node, Number, Random, String, Theme.
	- 🛠️ **Objects** - ActionHandler, ConfigStorage (INI File), LinkedMap.
- **Tools**
	- 🐛 [**Logger**](https://github.com/albinaask/Log) - Easier debugging, custom log groups configuration.
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
	- **snippets** *(.cpp, .js, ...)*
	- CREDITS.md
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
	- Consider using a professional IDE like "JetBrains Rider (GDScript)" instead of Godot Editor.
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



## 🤖 Code

The Globals (autoload Scenes) and Scripts (statics, consts, objects) are available from anywhere in the project. The latter is independent of (not managed by) the Scene Tree.

Otherwise, Scenes must be loaded or added to the Scene Tree.

### 💎 Globals

- **Configuration**
	- Configure Project, use ConfigStorage object for user config presistence.
	- Logger configuration exports log groups (override log levels).
	- Game options/settings configurations are tied to the menu UI.
- **Data**
	- Configure structure of save files, use as setter and getter of save file data.
- **Overlay**
	- Container for debug elements, e.g. FPS counter.
- **Reference**
	- Preloads & holds references to Resources in dictionary by name.
	- When creating a new Resource type, consider creating a getter here.
- **SignalBus**
	- Exchange global signals for cleaner observer pattern.
- **Wrapper** : *Extend functionality without modifying the original.*
	- **AudioWrapper** - Calls Resonance plugin with enums instead of string names.
	- **LogWrapper** - Extends Logger plugin with log groups configuration.
	- **SceneManagerWrapper** - Calls SceneManager plugin with custom resource.
	- **TranslationServerWrapper** - Extends localization to work in tool scripts.

### 🎬 Scenes

Scenes are split into following categories:
1. "Component" scenes extend functionality of the parent.
2. "Node" scenes are reusable as standalone functional units.
3. "Scene" scenes are larger specialized collections.


- **Component**
	- **Audio**
		- **ButtonAudio** - Audio events on signals (focus, click, release).
		- **SliderAudio** - Audio events on signals (drag start, drag end).
		- **TreeAudio** - Audio events on signals (cell selected, button clicked).
	- **Control**
		- **ControlExpandStylebox** - Resize target node to fill parent container.
		- **ControlGrabFocus** - Grabs focus of node for controller support.
	- **Motion**
		- **ScaleMotion** - Animate (tween) scale of Control node(s) when interacted with.
	- **Supplemental**
		- **ResizeOnDisabledStretchMode** - Custom UI scaling if "stretch mode: disabled".
- **Node**
	- **Game**
		- **ParticleQueue** - Emit any scene via GPU particles as SubViewport.
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
			- **VideoOptions** - Display, Resolution, VSync, FPS Limit, Anti-Alias.
			- **ControlsOptions** - Change (add or remove) keybinds.
			- **GameOptions** - Custom options, e.g. toggle autosave.
		- **CreditsMenu** - Renders CREDITS.md file in-game with formatting.
		- **SaveFilesMenu** - List of files: play, import, export, delete, rename.
	- **GameScene** - Example incremental game mechanics and effects.
		- **PauseMenu** - Pause gameplay, change options. Esc key shortcut.

### 📄 Scripts

- **Const** - Collections of commonly used constants.
- **Enum** - Collections of organised values.
- **Object**
	- **ActionHandler** - Implements the (light) [command pattern](https://refactoring.guru/design-patterns/command) design.
	- **ConfigStorage** - Persists (save & load) app settings in INI file.
	- **LinkedMap** - Dictionary data structure that tracks order of keys.
- **Util**
	- **DatetimeUtils** - Useful for save file metadata (e.g. last played at).
	- **FileSystemUtils** - Robust functions to extract file paths and names.
	- **MarshallsUtils** - Convert data formats with optional encryption.
	- **MathUtils** - Integer power function, base conversion and similar.
	- **NodeUtils** - Collection of node manipulation functions.
	- **NumberUtils** - Numbers format (digits, metric, scientific), validate.
	- **RandomUtils** - Weighted Loot Table and random string functions.
	- **StringUtils** - String functions for validation and transformations.
	- **ThemeUtils** - Shortcut Theme getters and setters.

### 🌸 Snippets

- **ConfirmationDialogJsLoader** 
	- Native HTML/CSS/JS dialog to access clipboard in web build.
	- Supports transfer of Theme resource properties to CSS style.
	- Useful because Godot Nodes cannot read or write to web clipboard.



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

List of relevant issues (and current hacks/workarounds/solutions) as of Godot 4.3 stable:

- **General**
	- [x] Issue [#66014](https://github.com/godotengine/godot/issues/66014) **suffixed tres files**. Solved with sanitization.
	- [x] Issue [#65390](https://github.com/godotengine/godot/issues/65390) **defect GPU particles**. Solved with interpolate toggle.
	- [x] Issue [#35836](https://github.com/godotengine/godot/issues/35836#issuecomment-581083643) **font size tween lag**. Solved by scale tween instead.
	- [ ] Issue [#89712](https://github.com/godotengine/godot/issues/89712) **"hicon" is null** sometimes. TODO?
	- [ ] Issues [#75369](https://github.com/godotengine/godot/issues/75369), [#71182](https://github.com/godotengine/godot/issues/71182), [#61929](https://github.com/godotengine/godot/issues/61929) **large scene lag** sometimes. TODO?

- **Desktop**
	- [ ] Issues [#3145](https://github.com/godotengine/godot-proposals/issues/3145), [#6247](https://github.com/godotengine/godot-proposals/issues/6247) **boot window mode**. TODO: cfg override.
- **Web**
	- [x] Issue [#81252](https://github.com/godotengine/godot/issues/81252) **web clipboard**. Solved by native JavaScript dialog.
	- [x] Issue [#96874](https://github.com/godotengine/godot/issues/96874) **web boot splash**. Solved by CSS in Head Include.
	- [x] Issue [#100696](https://github.com/godotengine/godot/issues/100696) **play_stream bus**. Solved by explicit func args.
	- [ ] Issue [#43138](https://github.com/godotengine/godot/issues/43138) **web user focus**. TODO: "click to continue" boot screen.

**TODO**: Test the template on following platforms.
- **Linux**
- **MacOS**
- **iOS**
- **Android**


## 📖 Instructions


### 📘 Get Started

After setup, you should have no errors and no warnings.

- Click [Use this template](https://github.com/new?template_name=TakinGodotTemplate&template_owner=TinyTakinTeller) in Github, then open the project in Godot Engine.
- Setup [GDScript Toolkit](https://github.com/Scony/godot-gdscript-toolkit) python package to use formatter and linter plugins.
- Open (Import) the project for the first time in the Godot Editor.
- Enable all plugins, then restart the project "Project > Reload Current Project".


On Godot 4.3 you must also:

- Do [font uuid workaround](https://github.com/godotengine/godot/issues/80237) by opening `res://resources/global/theme.tres` and clear then set again the font `noto_sans.woff`.
- Do [font fallbacks workaround](https://github.com/godotengine/godot/issues/92297) by editing `noto_sans.woff.import` and pasting lines:
```
Fallbacks=null
fallbacks=[Resource("res://assets/font/noto_sans/woff/noto_sans_arabic.woff"), Resource("res://assets/font/noto_sans/woff/noto_sans_hebrew.woff"), Resource("res://assets/font/noto_sans/woff/noto_sans_hk.woff"), Resource("res://assets/font/noto_sans/woff/noto_sans_jp.woff"), Resource("res://assets/font/noto_sans/woff/noto_sans_kr.woff"), Resource("res://assets/font/noto_sans/woff/noto_sans_sc.woff"), Resource("res://assets/font/noto_sans/woff/noto_sans_tc.woff"), Resource("res://assets/font/noto_sans/woff/noto_sans_thai.woff")]
```


### ❓ FAQ

For questions and help, open a Github Issue or contact my Discord `tiny_takin_teller`.

- Opening the project for the first time, I have errors/warnings?
	- Try (re)enable all Plugins and then select "Reload Current Project".
- Warning "ext_resource, invalid UID" when opening the project?
	- Resolve by re-saving the mentioned scene (.tscn), e.g. rename root node.


### 💼 Editor Layout

Editor layout can be changed via "Editor > Editor Layout > ..." in Godot Editor.

To use my layout, locate `editor_layouts.cfg` in [Editor Data Paths](https://docs.godotengine.org/en/latest/tutorials/io/data_paths.html#editor-data-paths) and add:

```
[takin_godot_template]

dock_1_selected_tab_idx=0
dock_5_selected_tab_idx=0
dock_floating={}
dock_bottom=[]
dock_closed=[]
dock_split_1=0
dock_split_3=0
dock_hsplit_1=365
dock_hsplit_2=170
dock_hsplit_3=-430
dock_hsplit_4=0
dock_filesystem_h_split_offset=240
dock_filesystem_v_split_offset=0
dock_filesystem_display_mode=0
dock_filesystem_file_sort=0
dock_filesystem_file_list_display_mode=1
dock_filesystem_selected_paths=PackedStringArray("res://")
dock_filesystem_uncollapsed_paths=PackedStringArray("res://")
dock_1="FileSystem,Scene,Scene Manager"
dock_5="Inspector,Node,Import,History"
```



## 🫂 Contribute

- Open a new Issue for discussion first, later Fork and open a pull request.



## 💕 Acknowledgements

- Godot Examples
	- [Godot Demo Projects](https://github.com/godotengine/godot-demo-projects)
		- [Multiple Resolutions Options](https://github.com/godotengine/godot-demo-projects/tree/master/gui/multiple_resolutions)
		- [Graphics 3D Options](https://github.com/godotengine/godot-demo-projects/tree/master/3d/graphics_settings)

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
	- [Ninetailsrabbit Indie Blueprint](https://github.com/ninetailsrabbit/indie-blueprint)




