local ui = require "ui"

-- get the the path to the messages.wlua folder
local homedir = sys.File(arg[1]).directory

-- set current dir to the root folder of the Webview folder to load the Webview.dll module
sys.currentdir = homedir.parent.parent.path
require "webview"

local win = ui.Window("Calculator - web application with LuaRT", "fixed", 290, 310)
win:loadicon(sys.env.WINDIR.."/System32/calc.exe")

local wv = ui.Webview(win, homedir.path.."/calc.html")
wv.align = "all"

win:center()
win:show()

function wv:onReady()
    wv.statusbar = false
    wv.devtools = false
    wv.contextmenu = false
end

while win.visible do
    ui.update()
end