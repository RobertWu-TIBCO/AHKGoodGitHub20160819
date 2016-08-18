#SingleInstance force  ; force reloading
Menu, Tray, Icon, shortcut.ico
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


CapsLock & LButton::
RemoveToolTip:
    ToolTip
    SetTimer, RemoveToolTip, Off
return

AlignText(result)
{
return result
}


KeyHelpText()
{
    return AlignText(""
    . "* | 按键 |  Caps RButton | Show KeyHelp`n"
    . "* | 按键 |  Caps LButton | DisShow KeyHelp`n"
    . "* | 按键 | ^+LButton   | FavoriteItems ahk`n"
    . "* | 按键 | ^+RButton  | Global Menu`n"
    . "* | 按键 | #RButton   | QZ2 `n"
    . "* | 按键 | #LButton   | candy_RobertWork\[candy].ini`n"
    . "* | 按键 | ^LButton   | candy_菜单式\[candy].ini`n"
    . "* | 按键 | ^RButton    | candy_次常用\[candy].ini `n"
    . "* | 按键 | !RButton   | candy_最常用\[candy].ini`n"
    . "* | 按键 | Ctrl+Alt+S  |  ini\candy_纯搜索\[candy].ini`n"
    . "* | 按键 |Ctrl+Shift+H | AutoCorrectSpell Add New Word `n"
    . "* | 按键 | Ctrl + H    | RunZ HotString Add New Word `n"
    . "* | 按键 | Win + Y    | 语音翻译选中内容`n"  
    . "* | 按键 | Win + Tab | Switch Within Apps`n"  
    . "* | 按键 | Ctrl + i      | Vim Edit in Vim`n"
    . "* | 按键 | Ctrl+Alt+i  | Vim Edit in Notepad`n"
    . "* | 按键 | Caps + j     | 移动到下一个条目`n"
    . "* | 按键 | Caps + k    | 移动到上一个条目`n"
    . "* | 按键 | Caps + h    | 移动到左一个条目`n"
    . "* | 按键 | Caps + l     | 移动到右一个条目`n"
    . "* | 按键 | Win + n   | Click No In Notepad++`n"
    . "* | 按键 | Win + i   | Read Selected`n"
    . "* | 按键 | Win + e   | Clover`n"
    . "* | 按键 | Win + o   | In Firefox , Show Dialog`n"
    . "* | 按键 | Win + z   | Taskmgr`n"
    . "* | 按键 | Alt+Shift+V | Search Vimperator`n"
    . "* | 按键 | Alt+Shift+H | SearchHHBetter`n"
    . "* | 按键 | Alt+Shift+G | Search in gmailSimple ahk `n"
    . "* | 按键 | Alt+Shift+l | Search in 1122GoodDayLearn`n"
    . "* | 按键 | Alt+Shift+b | Search in mail0630Bigmail`n"
    . "* | 按键 | Alt+Shift+P | Search in PadAllBeforeNS`n"
    . "* | 按键 | Alt+Shift+S | Select Search in FileLocator`n"
    . "* | 按键 | Alt+Shift+D | Select Add To _FirstCollect.ahk`n"
    . "* | 按键 | Alt+Shift+F | Run in firefox`n"
    . "* | 按键 | Alt+Shift+O | OpenSelect as File in Pad`n"
    . "* | 按键 | Alt+Shift+J | OpenSelect as File in JD`n"
    . "* | 按键 | Alt+Shift+R | includeAhktest`n"
    . "* | 按键 | Alt+Shift+C | RunAndGetOutput`n"
    . "* | 按键 | Alt+Shift+A | ShiftHome`n"
    . "* | 按键 | Alt+Shift+E | ShiftEnd`n"
    . "* | 按键 | Alt+Shift+Z | No Save in BB `n"
    . "* | 按键 | Alt+Shift+- | Last Edit in Notepad `n"
    . "* | 按键 |Ctrl+Win+C| Run Select in CMD`n"
    . "* | 按键 | Ctrl+Alt+Shift+r| AhkTest`n"
    . "* | 按键 | Ctrl+Alt+Q | Query`n"
    . "* | 按键 | Ctrl+Alt+R | Sr`n"
    . "* | 按键 | Ctrl+Alt+M|Mail Search`n"
    . "* | 按键 | Ctrl+Alt+K|KB`n"
    . "* | 按键 | Caps & i   | Clover Parent Folder`n"
    . "* | 按键 | Caps & u  | Clover Go Into Folder`n"
    . "* | 按键 | Ctrl+Alt+G| Google`n"
    . "* | 按键 | Ctrl+Alt+B | Baidu`n"
    . "* | 按键 | Ctrl+Alt+` | Print ``n"
    . "* | 按键 | Shift+`      | Print ``n"
    . "* | 按键 | Ctrl+Alt+`; | Print `;`n"
    . "* | 按键 | Ctrl+`;      | Print `;`n"
    . "* | 按键 | Ctrl+Alt+'  | Print '`n"
    . "* | 按键 | Ctrl+'        | Print '`n"
    . "* | 按键 | Ctrl+D          |delwordafter `n"
    . "* | 按键 | Ctrl+L          |LineCut`n"
    . "* | 按键 | Ctrl+Shift+D  |LineCut `n"
    . "* | 按键 | Ctrl+Alt+Down  |LineCutPaste `n"
    . "* | 按键 | Ctrl+Shift+L  |LineCopy`n"
    . "* | 按键 | Ctrl+Alt+Shift+U  |Upper `n"
    . "* | 按键 | Ctrl+Alt+U  |Lower `n"
    . "* | 按键 | Ctrl+Alt+Z  |NoZip `n"
    . "* | 按键 | Ctrl+Alt+\  |Comment `n"
    . "* | 按键 | Ctrl+Alt+/  |UnComment `n"
    . "* | 按键 | Ctrl+Alt+Shift+\  |Comment XML `n"
    . "* | 按键 | Ctrl+Alt+O  |Run clipboard `n"
    . "* | 按键 | Alt+A         |Home `n"
    . "* | 按键 | Alt+E         |End `n"
    . "* | 按键 | Alt+H         |Left `n"
    . "* | 按键 | Alt+J          |Down `n"
    . "* | 按键 | Alt+K         |Up `n"
    . "* | 按键 | Alt+L         |Right `n"
    . "* | 按键 | Alt+B         |CtrlLeft `n"
    . "* | 按键 | Alt+F         |CtrlRight `n"
    . "* | 按键 | Alt+P         |shiftenddel `n"
    . "* | 按键 | Alt+U         |shifthomedel `n"
    . "* | 按键 | Ctrl+Enter   |NewLine `n"
    . "* | 按键 | Alt+-           |EditPlace `n"
    . "* | 按键 | Caps+[        |en `n"
    . "* | 按键 | Caps+]        |cn `n"
    . "* | 按键 | Ctrl+Down  |shiftEnd`n"
    . "* | 按键 | Ctrl+Up      |shiftHome`n"
    . "* | 按键 | Caps+'         |homequote `n"
    . "* | 按键 |Win+O        |Open Select As Path in Clover `n"
    . "* | 按键 |Win+Shift+O|Open Select Parent Path in Clover `n"
    . "* | 按键 | Alt+C          |Dictionary2 `n"
    . "* | 按键 |Ctrl+Shift+1  |Dictionary2`n"
    . "* | 按键 |Ctrl+Shift+`  |Dictionary2`n"
    . "* | 功能 | 输入网址   | 可直接输入 www 或 http 开头的网址`n"
    . "* | 功能 | `;         | 以分号开头命令，用 ahk 运行`n"
    . "* | 功能 | :          | 以冒号开头的命令，用 cmd 运行`n"
    . "* | 功能 | 无结果     | 搜索无结果，回车用 ahk 运行`n"
    . "* | 功能 | 空格       | 输入空格后，搜索内容锁定")
}

::rshort::
reload
return

::short::
::ashort::
edit
return

CapsLock & RButton::
^!t::
::tips::
tip:
    ToolTip, % KeyHelpText()
    SetTimer, RemoveToolTip, 5000
return
