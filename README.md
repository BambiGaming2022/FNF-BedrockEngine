# Friday Night Funkin' - Bedrock Engine!
a fork of Psych Engine which adds a bunch of features from Pull Requests around the Main Branch, and even other forks!
Credits:
* [BURGER76920](https://github.com/ShadowMario/FNF-PsychEngine/pull/3891) - Json-editable Menus
* [CerBor](https://github.com/ShadowMario/FNF-PsychEngine/pull/2896) - Difficulty Drop Down on Chart Menu
* [HiroMizuki](https://github.com/ShadowMario/FNF-PsychEngine/pull/1792) - Pixel Note Splashes
* [i-winxd](https://github.com/ShadowMario/FNF-PsychEngine/discussions/2917) - Kade Engine (Complex) Accuracy
* [lemz1](https://github.com/ShadowMario/FNF-PsychEngine/pull/2770) - Play as Opponent
* [l1ttleO](https://github.com/l1ttleO/ProjectFNF) - Made ProjectFNF 2.X, Original Hit Sound Code, Miss Sounds Toggle
* [magnumsrtisswag](https://github.com/ShadowMario/FNF-PsychEngine/pull/3502) - Credits Warning
* [Starmapo](https://github.com/ShadowMario/FNF-PsychEngine/pull/3428) - Time Signatures
* [Stilic](https://github.com/ShadowMario/FNF-PsychEngine/pull/1809) - Freeplay Bump, Max Optimization, Menu Animations, Automatic Controller Detection
* [Verwex](https://github.com/Verwex/Funkin-Mic-d-Up-SC) - made Mic'd Up Engine, Winning Icons
* [XtraXD1](https://github.com/ShadowMario/FNF-PsychEngine/pull/3192) - Show/Hide Weeks temporally + Getting/Setting on Source Code
* [Yoshubs](https://github.com/Yoshubs/Forever-Engine-Legacy) - made Forever Engine, Main Inspiration

> **Remember: this engine should be treated as nothing but a Mod/Fork of Psych Engine**

# Sections:

* [How to](https://github.com/Gui-iago/FNF-BedrockEngine/blob/main/README.md#how-to-compile-the-game-and-what-is-needed-to-do-so)
* [Compiling Dependencies](https://github.com/Gui-iago/FNF-BedrockEngine/blob/main/README.md#how-to-compile-the-game-and-what-is-needed-to-do-so)
* [Terminal Setup & Commands](https://github.com/Gui-iago/FNF-BedrockEngine#terminal-setup--compiling-game)
* [Features](https://github.com/Gui-iago/FNF-BedrockEngine#current-features)

# How to Compile the Game, and what is needed to do so

> ### Dependencies

- Git
- Haxe (LATEST VERSION ONLY, PLEASE, STOP USING 4.1.5!!!!)
- Visual Studio Community (Windows Only)

> ### OPTIONAL Dependencies

- Visual Studio Code (for modifying the code itself)

> ### Recommended VS Code Extensions

- Lime
- Bracket Pair Colorizer 2
- HXCPP Debugger
- Tabnine

> ### Optional Visual Studio Code Extensions

- Haxe blocks
- Haxe Checkstyle
- Haxe JSX
- Haxe Extension Pack
- HaxeUI
- indent-rainbow
- Lua Extension by keyring

# Compiling Dependencies

### Git & Haxe

Windows and macOS: 

- https://git-scm.com/downloads
- https://haxe.org/download

macOS with homebrew:
```
brew install git
brew install haxe
```

Ubuntu based Linux distros:
```
sudo add-apt-repository ppa:haxe/releases -y
sudo apt update
sudo apt install git haxe -y
mkdir ~/haxelib && haxelib setup ~/haxelib
```

Debian based Linux distros:
```
sudo apt-get install git haxe -y
mkdir ~/haxelib && haxelib setup ~/haxelib
```

Arch based Linux distros:
```
sudo pacman -S git haxe
mkdir ~/haxelib && haxelib setup ~/haxelib
```

Redhat based Linux distros:
```
sudo dnf install git haxe -y
mkdir ~/haxelib && haxelib setup ~/haxelib
```

openSuse based Linux distros: 
```
sudo zypper install git haxe
mkdir ~/haxelib && haxelib setup ~/haxelib
```

### Post installation on all platforms, run
```
haxelib setup
```

### Visual Studio Community

https://my.visualstudio.com/Downloads?q=visual%20studio%202017&wt.mc_id=o~msft~vscom~older-downloads

> ### Visual Studo Community Setup

Once you download and install VS Community, on the "Individual Components" tab, select:

```
MSVC v142 - VS 2019 C++ x64/x86 build tools
Windows SDK (10.0.17763.0)
```


Desktop Development with C++
Near the "Install" button, there's a Drop-Down menu, click on it, Select "Download first, then Install"
Now wait until it finishes, it is recommended to reboot your PC once it finishes, but it's not needed at all

# Terminal Setup & Compiling Game

Windows: Press "Windows + R" and type in "cmd", if you don't like cmd, or you just use something different, open that program instead
cmd is usually faster, that's why I'm recommending it!

Linux: press "CTRL + ALT + T" and a Terminal window should open -- although, if you are on linux, you probably know that already

### Type in these commands:

```bash
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit.git
haxelib git hxvm-luajit https://github.com/nebulazorua/hxvm-luajit
haxelib git faxe https://github.com/uhrobots/faxe
haxelib git polymod https://github.com/MasterEric/polymod.git
haxelib git extension-webm https://github.com/KadeDev/extension-webm
haxelib install lime 7.9.0
haxelib install openfl
haxelib install flixel
haxelib install flixel-tools
haxelib install flixel-ui
haxelib install hscript
haxelib install flixel-addons
haxelib install actuate
haxelib run lime setup
haxelib run lime setup flixel
haxelib run flixel-tools setup
```

**_Read Carefully:_** When it prompts for you to do anything (like: setup the lime command, setup flixel tools, etc)

Compiling test version:

```
lime test PLATFORM # linux, windows, mac
```

### for Debug Builds

Append `-debug` at the end of `lime test PLATFORM`

### Visual Studio Code Installation

Windows and Mac: https://code.visualstudio.com/Download

Linux: https://code.visualstudio.com/docs/setup/linux
* Alternatively, you can use your distro's package manager to install Visual Studio Code

In case you don't want your mod to be able to run .lua scripts, delete the `LUA_ALLOWED` line on `Project.xml`

# Current Features

## All Psych Engine Features!
Being a [Psych Engine](https://github.com/ShadowMario/FNF-PsychEngine) fork has it's Perks

## Menu Animations and Freeplay Bump

https://user-images.githubusercontent.com/45212377/151045598-7311d0de-2dff-4217-96fa-11cc49cf6c1b.mp4

## Hit Sounds

https://user-images.githubusercontent.com/45212377/151046285-f91d5be4-4041-43ed-be69-9df23acaf2ce.mp4

## More Perfomance Options
some more Performance Options for the game to run smoothly on older hardware

* Hide Girlfriend

it's in the name!
![image](https://user-images.githubusercontent.com/45212377/150618541-b4fc137a-723a-400c-b0a3-0763a547c21a.png)

![image](https://user-images.githubusercontent.com/45212377/150618560-6bba9889-afc0-4606-bd44-252c7467a2b2.png)

this also comes with special dialogue for Week 6!

![image](https://user-images.githubusercontent.com/45212377/150618678-b245789d-3700-41ec-a258-3d6e63965953.png)

* Max Optimization

![image](https://user-images.githubusercontent.com/45212377/150618767-e2e4524c-669b-480c-85ff-b095ef106623.png)

this disables everything related to backgrounds and characters, leaving only the HUD and Note Splashes!

![image](https://user-images.githubusercontent.com/45212377/150618792-8be1b189-5603-4743-b23a-0b07df877576.png)

## Letter Grading System!

![image](https://user-images.githubusercontent.com/45212377/151047810-9bb0c459-8714-41bd-b861-3d90e001ef9e.png)

* SS   100% Accuracy.
* S+   99% Accuracy.
* A+   95% Accuracy
* A    89% Accuracy.
* B    79% Accuracy.
* C    69% Accuracy.
* D    40% Accuracy or below.

If you do not want the engine to use letter grades, toggle then using the gameplaySettings.json file on the settings folder.

> ### FC Ratings
* MFC - Full Combo with Only Marvelouses *(can be disabled)*
* SFC - Full Combo with at least 1 Sick/Only Sicks
* GFC - Full Combo with at least 1 Good/Only Goods
* FC - Full Combo with at least 1 Bad/Only Bads *(only works on Simple Accuracy)*
* SDB - Single Digit Bad *(at least 1 Bad/Only Bads, only works on Complex Accuracy)*
* SDS - Single Digit Shit *(at least 1 Shit/Only Shits)*
* SDCB - Single Digit Combo Break *(you missed at least once)*
* Clear - You missed at least 10 times

## Opponent Mode

https://user-images.githubusercontent.com/45212377/151046606-4d1465b8-93da-4b49-95be-c2ea1767513a.mp4

can be enabled on the Gameplay Changers menu

## Pixel Note Splashes

https://user-images.githubusercontent.com/45212377/151046841-dbbdb3e9-9491-4a51-81b6-f97976dabce7.mp4

## Customization Features
You can now customize your notes, judgements, note splashes and even something insignificant
like your dividers, all in one place, the Settings Menu!

![image](https://user-images.githubusercontent.com/45212377/153362801-fa09bf76-863a-4fff-b1b6-2f7cba8a1d61.png)

Current Changeables:
* Notes
* Note Splashes
* Judgements
* Dividers (for the Info Bar)

Current Toggles:
* Disable Winning Icons (old icon support)
* Enable Letter Grades
* Disable Antimash

more features will be added to it in the future.

## Winning Icons

![image](https://user-images.githubusercontent.com/45212377/151046960-011d0af2-d638-4f30-9169-3e8dee41ba91.png)

Template: ![icon-template](https://user-images.githubusercontent.com/45212377/151059381-3d366efc-65f8-42de-8cb1-dc90f65b1e9f.png)

read the readme.txt file on the settings folder for information on how to disable winning icons

## and more!
I will keep updating this fork as much as possible for it to be in sync with the main repository, and adding more features to it in the future!

# Future Plans
https://github.com/Gui-iago/FNF-BedrockEngine/projects/1
