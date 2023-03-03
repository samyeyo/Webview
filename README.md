<div align="center">

![Webview for LuaRT][title] 

[![LuaRT Widget](https://badgen.net/badge/LuaRT/Widget/yellow)](https://www.luart.org/)
![Windows](https://badgen.net/badge/Windows/10%20and%20later/blue?icon=windows)
[![LuaRT license](https://badgen.net/badge/License/MIT/green)](#license)
[![Twitter Follow](https://img.shields.io/twitter/follow/__LuaRT__?style=social)](https://www.twitter.com/__LuaRT__)

[Features](#small_blue_diamondfeatures) |
[Requirements](#small_blue_diamondrequirements) |
[Installation](#small_blue_diamondinstallation) |
[Usage](#small_blue_diamondusage) |
[Documentation](https://www.luart.org/doc/webview/index.html) |
[License](#small_blue_diamondlicense)

</div>
   
## :small_blue_diamond:Features

- LuaRT binary module wrapping the Microsoft Edge Webview2 component
- HTML/Javascript/CSS render widget for Windows 7 and later
- Embed web content (HTML, CSS, and JavaScript) in your LuaRT applications
- Build fast and lightweight Web Applications (in less than 300kb !)
- Messages based communication between LuaRT (backend) and Javascript (frontend)
- Evaluate Javascript expressions dynamically in your Lua application
- Render files from a virtual host (ie a local folder)
- No other dependencies (no need for `Webview2Loader.dll`)
  
## :small_blue_diamond:Requirements

#### LuaRT programming framework
Webview for LuaRT is not a standalone module, it depends on the LuaRT toolchain which must have already been installed before proceeding.
Go to (LuaRT Homepage)[https://www.luart.org] if you have not already installed it.

#### Microsoft Edge Webview2 runtime
Webview for LuaRT depends on the Microsoft Edge Webview2 runtime.
The runtime is already installed on Windows 10 and Windows 11. If not, follow this link to download and install the [Microsoft Edge Webview2 runtime](https://developer.microsoft.com/fr-fr/microsoft-edge/webview2/)

## :small_blue_diamond:Installation

### Installation

#### Method 1 : Webview for LuaRT release package :package:

The preferred way to get the Webview widget is to download the latest binary release available on GitHub.
Download the latest release package on GitHub. Just unpack the downloaded archive to get the `Webview.dll` LuaRT binary module, and put it in the `modules\` folder or your LuaRT distribution.
  
#### Method 2 : Webview for LuaRT from sources :gear:

All you need to build the Webview widget from sources is a valid installation of the Mingw-w64 distribution (actually tested using GCC 8.1+), feedback is welcome for other C/C++ compilers.

First clone the Webview repository (or manualy download the repository) :
```
git clone https://github.com/samyeyo/Webview.git
```

Then go to the root directory of the repository and type ```make```:

```
cd Webview\
make
```
LuaRT path and platform will then be autodetected. If it failed, you can still set the `LUART_PATH` variable in the Makefile.  
If everything went right, it will produce the `Webview.dll` LuaRT binary module.

To install the module in the `modules\` folder of your LuaRT distribution type the following command :

```
make install
```

## :small_blue_diamond:Usage
The LuaRT module must be used by the desktop LuaRT interpreter, `wluart.exe`.
To use the LuaRT module in your applications, just require for the `webview` module to load it.

Once loaded, the Webview widget is added to the `ui` module and can be used as in this script :

```lua
local ui = require "ui"
require "webview"

-- Creates a Window
local win = ui.Window("Webview for LuaRT", 640, 540)

-- Creates a Webview widget
local wv = ui.Webview(win, "https://www.luart.org")

-- Make it aligned to the entire window
wv.align = "all"

-- Center and show the main Window
win:center()
win:show()

-- Update ui until the main window is closed
while win.visible do
    ui.update()
end
```
> **Note**

> The `Webview.dll` library must be in the current directory, or in your `LUA_CPATH` 

> The `Webview.dll` can be loaded in memory if you compile your application with the `rtc` compiler

Webview for LuaRT aims to be lightweight, with a small footprint. The previous example, once compiled to executable, represent only 250kb in size, consumes 256Mb of RAM and 3.7% of CPU

## :small_blue_diamond:Documentation
  
- :house_with_garden: [Homepage](https://www.luart.org)
- :book: [Webview for LuaRT Documentation](https://www.luart.org/doc/webview.html)
  
## :small_blue_diamond:License
  
Webview for LuaRT is copyright (c) 2023 Samir Tine.
Webview for LuaRT is open source, released under the MIT License.

See full copyright notice in the LICENSE file.

[title]: contrib/Webview.png
