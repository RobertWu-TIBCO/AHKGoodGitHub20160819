;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;Script Name    : FavorItems
;Version        : 1.1
;Author         : abracadabra  @1738920644
;Lib-included   : RMApp_NavControlHandler by 『Learning one』  @autohotkey.com
;Function       : 增强Easy Access to Favorite Folders (by Savage)的功能：
;                 增加二级菜单/增加图标/增加文件夹打开历史记录等/RMApp_NavControlHandler的应用（更稳定）
;应用场景       : 1.打开常用文件夹 2.打开常用应用程序 3.资源管理器/“打开”/“保存”等窗口的路径跳转
;快捷键         : 鼠标中键/Ctrl+Shift+鼠标左键
;添加不生效窗口 : 在设置的[Hide]段增加相应的窗口类名，以","分隔
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;====================FavorItems auto section {{{
#notrayicon
#SingleInstance force
IfNotExist, % A_MyDocuments . "\FavorItems.ini"
{
    f_items=
    (Ltrim
    [Items]
    桌面=%A_Desktop%
    用户=C:\Users\%A_UserName%
    我的文档=%A_MyDocuments%
    文件夹历史记录=foobar

    Windows小工具=画图=mspaint.exe
    Windows小工具=计算器=calc.exe
    Windows小工具=注册表编辑器=regedit.exe
    Windows小工具=命令行提示符=cmd.exe
    Windows小工具=组策略=gpedit.msc
    Windows小工具=计算机管理=compmgmt.msc
    Windows小工具=控制面板=control.exe

    资源监视器=resmon.exe
    记事本=C:\windows\notepad.exe

    [Hide]
    hide=MozillaWindowClass,IEFrame,
    )
    FileAppend, %f_items%, % A_MyDocuments . "\FavorItems.ini"
    sleep, 500
    msgbox, 按下『鼠标中键』或『Ctrl+Shift+鼠标左键』打开菜单
}
Sleep, 100
Gosub, createFavorMenu
Gosub, CreateHistoryMenu
Sleep, 300
return
;====================FavorItems auto section }}}

;====================FavorItems快捷键/标签/函数 {{{
^+RButton::
WinGet, f_window_id, ID, A
WinGetClass, f_class, ahk_id %f_window_id%
if f_class in %HideInWindows%
    return
else
    Menu, Favorites, show
return

createFavorMenu:
Menu, Favorites, Add 
Menu, Favorites, Delete

IniRead, HideInWindows, %A_MyDocuments%\FavorItems.ini, Hide, hide
f_AtStartingPos := "n"
FavsObj:={}
Loop, Read, %A_MyDocuments%\FavorItems.ini
{
    try {
        if (f_AtStartingPos = "n")
        {
            IfInString, A_LoopReadLine, [Items]
                f_AtStartingPos := "y"
            continue
        }
        IfInString, A_LoopReadLine, [Hide]
            break
        else {
            if (A_LoopReadLine = "") {
                Menu, Favorites, Add
            } else {
                StringSplit, f_part, A_LoopReadLine, =
                loop, %f_part0%
                    f_part%A_Index% := Trim(f_part%A_Index%)
                if (f_part0=3) {                                                ; 二级菜单
                    Menu, subfavs%f_part1%, Add, %f_part2%, f_OpenItem
                    if InStr(FileExist(f_part3), "D") {
                        RegExMatch(f_part3, "\\+([^\\]+?)\\*$", lastfldname)
                        if (lastfldname1="Desktop")
                            Menu, subfavs%f_part1%, Icon, %f_part2%, Shell32.dll, 35
                        else if (lastfldname1="user")
                            ;Menu, subfavs%f_part1%, Icon, %f_part2%, Shell32.dll, 267
                            Menu, subfavs%f_part1%, Icon, %f_part2%, imageres.dll, 123
                        else if (lastfldname1="Documents")
                            ;Menu, subfavs%f_part1%, Icon, %f_part2%, Shell32.dll, 235
                            Menu, subfavs%f_part1%, Icon, %f_part2%, imageres.dll, 112
                        else if (lastfldname1="Pictures")
                            Menu, subfavs%f_part1%, Icon, %f_part2%, Shell32.dll, 236
                        else if (lastfldname1="Music")
                            Menu, subfavs%f_part1%, Icon, %f_part2%, Shell32.dll, 237
                        else if (lastfldname1="Videos")
                            Menu, subfavs%f_part1%, Icon, %f_part2%, Shell32.dll, 238
                        else
                            Menu, subfavs%f_part1%, Icon, %f_part2%, Shell32.dll, 5
                    } else {
                        RegExMatch(f_part3, "\.([^\\\.]+?)\\*$", lastfldname)
                        if (lastfldname1="exe")
                            Menu, subfavs%f_part1%, Icon, %f_part2%, %f_part3%, 1
                        else {
                            icon:=getExtIcon(lastfldname1)
                            Menu, subfavs%f_part1%, Icon, %f_part2%, % icon[1], % icon[2]
                        }
                    }
                    Menu, Favorites, Add, %f_part1%, :subfavs%f_part1%
                    Menu, Favorites, Icon, %f_part1%, imageres.dll, 115
                    StringReplace, f_part2, f_part2, ., _, All 
                    FavsObj[f_part2] := f_part3
                } else {                                                       ; 一级菜单
                    Menu, Favorites, Add, %f_part1%, f_OpenItem
                    if InStr(FileExist(f_part2), "D") {
                        RegExMatch(f_part2, "\\+([^\\]+?)\\*$", lastfldname)
                        if (lastfldname1="Desktop")
                            Menu, Favorites, Icon, %f_part1%, Shell32.dll, 35
                        else if (lastfldname1="user")
                            ;Menu, Favorites, Icon, %f_part1%, Shell32.dll, 267
                            Menu, Favorites, Icon, %f_part1%, imageres.dll, 123
                        else if (lastfldname1="Documents")
                            ;Menu, Favorites, Icon, %f_part1%, Shell32.dll, 235
                            Menu, Favorites, Icon, %f_part1%, imageres.dll, 112
                        else if (lastfldname1="Pictures")
                            Menu, Favorites, Icon, %f_part1%, Shell32.dll, 236
                        else if (lastfldname1="Music")
                            Menu, Favorites, Icon, %f_part1%, Shell32.dll, 237
                        else if (lastfldname1="Videos")
                            Menu, Favorites, Icon, %f_part1%, Shell32.dll, 238
                        else
                            Menu, Favorites, Icon, %f_part1%, Shell32.dll, 5
                    } else {
                        RegExMatch(f_part2, "\.([^\\\.]+?)\\*$", lastfldname)
                        if (lastfldname1="exe")
                            Menu, Favorites, Icon, %f_part1%, %f_part2%, 1
                        else {
                            icon:=getExtIcon(lastfldname1)
                            Menu, Favorites, Icon, %f_part1%, % icon[1], % icon[2]
                        }
                    }
                    StringReplace, f_part1, f_part1, ., _, All
                    FavsObj[f_part1] := f_part2
                }
            }
        }
    }   ;try 结束
}   ;loop 结束
sleep, 0
;Menu, Favorites, Add
Menu, Favorites, Add, FavorItems 设置, f_OpenItem
Menu, Favorites, Icon, FavorItems 设置, Shell32.dll, 22
Menu, Favorites, Add, FavorItems 刷新, f_OpenItem
Menu, Favorites, Icon, FavorItems 刷新, Shell32.dll, 290
return
;--------------------Function  {{{
getExtIcon(Ext) {
    I1 := I2:= ""
    RegRead, from, HKEY_CLASSES_ROOT, .%Ext%
    RegRead, DefaultIcon, HKEY_CLASSES_ROOT, %from%\DefaultIcon
    StringReplace, DefaultIcon, DefaultIcon, `",,all
    StringReplace, DefaultIcon, DefaultIcon, `%SystemRoot`%, %A_WinDir%,all
    StringReplace, DefaultIcon, DefaultIcon, `%ProgramFiles`%, %A_ProgramFiles%,all
    StringReplace, DefaultIcon, DefaultIcon, `%windir`%, %A_WinDir%,all
    StringSplit, I, DefaultIcon, `,
    return [I1,IndexOfIconResource(I1, RegExReplace(I2, "[^\d]+"))]
}

IndexOfIconResource(Filename, ID)
{
    hmod := DllCall("GetModuleHandle", "str", Filename)
    loaded := !hmod
        && hmod := DllCall("LoadLibraryEx", "str", Filename, "uint", 0, "uint", 0x2)
    
    enumproc := RegisterCallback("IndexOfIconResource_EnumIconResources","F")
    VarSetCapacity(param,12,0), NumPut(ID,param,0)
    DllCall("EnumResourceNames", "uint", hmod, "uint", 14, "uint", enumproc, "uint", ¶m)
    DllCall("GlobalFree", "uint", enumproc)
    
    if loaded
        DllCall("FreeLibrary", "uint", hmod)
    
    return NumGet(param,8) ? NumGet(param,4) : 0
}

IndexOfIconResource_EnumIconResources(hModule, lpszType, lpszName, lParam)
{
    NumPut(NumGet(lParam+4)+1, lParam+4)

    if (lpszName = NumGet(lParam+0))
    {
        NumPut(1, lParam+8)
        return false    ; break
    }
    return true
}
;--------------------Function }}}

CreateHistoryMenu:
Menu, subfavsHistory, Add
Menu, subfavsHistory, Delete
RecentFolderStr:=""
try {
    loop, %A_AppData%\Microsoft\Windows\Recent\*.lnk, 0, 0
    {
        FileGetShortcut, %A_LoopFileLongPath%, realpath
        if InStr(fileexist(realpath), "D") {
            stringtrimright, ALoopFileName, A_LoopFileName, 4
            RecentFolderStr .= A_LoopFileTimeAccessed . "|" . ALoopFileName . "|" . realpath . "`n"
        }
    }
}
sort, RecentFolderStr, R
loop, parse, RecentFolderStr, `n
{
    StringSplit, FolderRel, A_LoopField, |
    Menu, subfavsHistory, Add, %FolderRel2%, f_OpenItem
    Menu, subfavsHistory, Icon, %FolderRel2%, Shell32.dll, 5
    FavsObj[FolderRel2] := FolderRel3
}
try {
    Menu, Favorites, Add, 文件夹历史记录, :subfavsHistory
    ;Menu, Favorites, Icon, History, Shell32.dll, 5
    Menu, Favorites, Icon, 文件夹历史记录, Shell32.dll, 5
}
return

f_OpenItem:
try
{
    AThisMenuItem:=Trim(A_ThisMenuItem)
    if (AThisMenuItem = "FavorItems 设置")
        run, notepad.exe "%A_MyDocuments%\FavorItems.ini"
    else if (AThisMenuItem = "FavorItems 刷新") {
        Gosub, createFavorMenu
        Gosub, CreateHistoryMenu
    } else {
        StringReplace, AThisMenuItem, AThisMenuItem, ., _, All
        f_path := FavsObj[AThisMenuItem]
        if instr(FileExist(f_path),"D")
        {
            if f_class = #32770
            {
                ControlGetPos, f_Edit1Pos,,,, Edit1, ahk_id %f_window_id%
                if f_Edit1Pos <>
                {
                    WinActivate ahk_id %f_window_id%
                    RMApp_NavControlHandler(f_path)
                    return
                }
            }
            else if f_class in ExploreWClass,CabinetWClass,%OtherApps% 
            {
                WinActivate ahk_id %f_window_id%
                RMApp_NavControlHandler(f_path)
                return
            }
            else if f_class = ConsoleWindowClass
            {
                WinActivate, ahk_id %f_window_id%
                SetKeyDelay, 0
                Send, cd /D %f_path%{Enter}
                return
            }
            else
                Run, Explorer %f_path%
        }
        else
            run, %f_path%
    }
}
return

;===Lib: RMApp_NavControlHandler {{{
; ShellSpecialFolderConstants:  http://msdn.microsoft.com/en-us/library/windows/desktop/bb774096%28v=vs.85%29.aspx
/*
F2::RMApp_NavControlHandler(A_MyDocuments)
F3::RMApp_NavControlHandler(3)      ; Control Panel
*/
/*
Part of Radial menu codes posted by Learning one.
http://www.autohotkey.com/board/topic/46856-radial-menu-scripts/
http://ahkscript.org/boards/viewtopic.php?p=4673#p4673

RM's Navigator is a drop down menu which helps you to easily navigate to folders that you often use. It navigates to your favorite folders in Windows explorer, My Computer, and in other standard Open, Save, Export, Import, Upload, Select dialog windows.
*/

RMApp_NavControlHandler(FolderPath, hwnd="", FocusedControl="") {
    /*
    RM executes this function after user selects item in Navigator menu, if it is a folder path, drive path or ShellSpecialFolderConstant.
    All parameters are provided by RM.
    Note that you can't always navigate to all ShellSpecialFolders. For example, you can't navigate to Control panel while you're in standard "Open File" dialog box window, but you can always navigate there while you're in Windows explorer.
   
    "FolderPath" can be folder path, drive path or ShellSpecialFolderConstant, for example: "C:\Program Files", "C:\", "10"
    "hwnd" is handle to window, for example: "0xa03f0".
    "FocusedControl" is control of the target window which has input focus, if any. Example: "Button2"

    Some functions in use:
    RMApp_IsControlVisible()        returns 1 if control is visible
    RMApp_ControlSetTextR()         same as ControlSetText command, but a little bit more reliable
    RMApp_ControlSetFocusR()        same as ControlSetFocus command, but a little bit more reliable
    RMApp_Explorer_Navigate()       navigates to specified folder in Windows Explorer or MyComputer
    */
   
    RestoreInitText := 1                        ; turn on "restore control's initial text after navigating to specified folder" switch
    hwnd := (hwnd="") ? WinExist("A") : hwnd    ; if omitted, use active window
    WinGetTitle, WinTitle, ahk_id %hwnd%        ; get window's title
    WinGetClass,WinClass, ahk_id %hwnd%         ; get window's class
    if (FocusedControl="")
        ControlGetFocus, FocusedControl, ahk_id %hwnd%  ; if not specified, get FocusedControl
   
    if FolderPath is integer
        FolderPath := Round(FolderPath)     ; for some strange reason, this has to be done although it looks like nonsense, otherwise try RMApp_Explorer_Navigate(FolderPath, hwnd) won't work properly if FolderPath if ShellSpecialFolderConstant

    ;=== If window is Windows Explorer or MyComputer ===
    if WinClass in ExploreWClass,CabinetWClass
    {
        try RMApp_Explorer_Navigate(FolderPath, hwnd)
        if (FocusedControl != "" and RMApp_IsControlVisible("ahk_id " hwnd, FocusedControl) = 1)
            RMApp_ControlSetFocusR(FocusedControl, "ahk_id " hwnd)              ; focus initialy focused control
        return
    }

    ;=== Other cases (not Windows Explorer or MyComputer) - first we'll decide to which control we will send FolderPath ===
    if (WinClass = "#32770") {      ;  dialog box class
        if RMApp_IsControlVisible("ahk_id " hwnd, "Edit1")
            Control := "Edit1"      ; in standard dialog windows, "Edit1" control is the right choice
        Else if RMApp_IsControlVisible("ahk_id " hwnd, "Edit2")
            Control := "Edit2"      ; but sometimes in MS office, if condition above fails, "Edit2" control is the right choice
        Else                        ; if above fails - just return and do nothing.
            Return
    }
    Else if WinTitle contains Open,Save,Export,Import,Upload,Select ; this is the case in some MS office dialog windows, which are not #32770 class.
    {
        if RMApp_IsControlVisible("ahk_id " hwnd, "Edit1")
            Control := "Edit1"          ; if "Edit1" control exists, it is the right choice.
        Else if RMApp_IsControlVisible("ahk_id " hwnd, "RichEdit20W2")
            Control := "RichEdit20W2"   ; some MS office dialogs don't have "Edit1" control, but they have "RichEdit20W2" control, which is then the right choice.
        Else                            ; if above fails - just return and do nothing.
            Return
    }
    Else {  ; in all other cases, we'll explore FolderPath, and return from this function
        ComObjCreate("Shell.Application").Explore(FolderPath)   ; http://msdn.microsoft.com/en-us/library/windows/desktop/bb774073%28v=vs.85%29.aspx
        Return
    }

    ;=== Refine ShellSpecialFolderConstant ===
    if FolderPath is integer
    {
        if (FolderPath = 17)            ; My Computer --> 17 or 0x11
            FolderPath := "::{20d04fe0-3aea-1069-a2d8-08002b30309d}"    ; because you can't navigate to "17" but you can navigate to "::{20d04fe0-3aea-1069-a2d8-08002b30309d}"
        else                            ; don't allow other ShellSpecialFolderConstants. For example - you can't navigate to Control panel while you're in standard "Open File" dialog box window.
            return
    }

    /*
    ShellSpecialFolderConstants:    http://msdn.microsoft.com/en-us/library/windows/desktop/bb774096%28v=vs.85%29.aspx
    CSIDL:                          http://msdn.microsoft.com/en-us/library/windows/desktop/bb762494%28v=vs.85%29.aspx
    KNOWNFOLDERID:                  http://msdn.microsoft.com/en-us/library/windows/desktop/dd378457%28v=vs.85%29.aspx
    */

   
    ;===In this part (if we reached it), we'll send FolderPath to control and optionaly restore control's initial text after navigating to specified folder=== 
    if (RestoreInitText = 1)    ; if we want to restore control's initial text after navigating to specified folder
        ControlGetText, InitControlText, %Control%, ahk_id %hwnd%   ; we'll get and store control's initial text first
   
    RMApp_ControlSetTextR(Control, FolderPath, "ahk_id " hwnd)  ; set control's text to FolderPath
    RMApp_ControlSetFocusR(Control, "ahk_id " hwnd)             ; focus control
    if (WinExist("A") != hwnd)          ; in case that some window just popped out, and initialy active window lost focus
        WinActivate, ahk_id %hwnd%      ; we'll activate initialy active window
   
    ;=== Avoid accidental hotkey & hotstring triggereing while doing SendInput - can be done simply by #UseHook, but do it if user doesn't have #UseHook in the script ===
    If (A_IsSuspended = 1)
        WasSuspended := 1
    if (WasSuspended != 1)
        Suspend, On
    SendInput, {End}{Space}{Backspace}{enter}   ; silly but necessary part - go to end of control, send dummy space, delete it, and then send enter
    if (WasSuspended != 1)
        Suspend, Off

    /*
    Question: Why not use ControlSetText, and then send enter to control via ControlSend, %Control%, {enter}, ahk_id %hwnd% ?
    Because in some "Save as"  dialogs in some programs, this causes auto saving file instead of navigating to specified folder! After a lot of testing, I concluded that most reliable method, which works and prevents this, is the one that looks weird & silly; after setting text via ControlSetText, control must be focused, then some dummy text must be sent to it via SendInput (in this case space, and then backspace which deletes it), and then enter, which causes navigation to specified folder.
    Question: Ok, but is "SendInput, {End}{Space}{Backspace}{enter}" really necessary? Isn't "SendInput, {enter}" sufficient?
    No. Sending "{End}{Space}{Backspace}{enter}" is definitely more reliable then just "{enter}". Sounds silly but tests showed that it's true.
    */
   
    if (RestoreInitText = 1) {  ; if we want to restore control's initial text after we navigated to specified folder
        Sleep, 70               ; give some time to control after sending {enter} to it
        ControlGetText, ControlTextAfterNavigation, %Control%, ahk_id %hwnd%    ; sometimes controls automatically restore their initial text
        if (ControlTextAfterNavigation != InitControlText)                      ; if not
            RMApp_ControlSetTextR(Control, InitControlText, "ahk_id " hwnd)     ; we'll set control's text to its initial text
    }
    if (WinExist("A") != hwnd)  ; sometimes initialy active window loses focus, so we'll activate it again
        WinActivate, ahk_id %hwnd%
   
    if (FocusedControl != "" and RMApp_IsControlVisible("ahk_id " hwnd, FocusedControl) = 1)
        RMApp_ControlSetFocusR(FocusedControl, "ahk_id " hwnd)              ; focus initialy focused control
   
   
    /*
    ;==Old method which looks more proper, but is definitely less reliable==
    if RestoreInitText
        ControlGetText, InitControlText, %Control%, ahk_id %hwnd%
    RMApp_ControlSetTextR(Control, FolderPath, "ahk_id " hwnd)
    Sleep, 60
    ControlSend, %Control%, {enter}, ahk_id %hwnd%
    Sleep, 60
    if RestoreInitText
        RMApp_ControlSetTextR(Control, InitControlText, "ahk_id " hwnd)
    if (WinExist("A") != hwnd)
        WinActivate, ahk_id %hwnd%
    */
}

RMApp_Explorer_Navigate(FullPath, hwnd="") {  ; by Learning one
    ; http://ahkscript.org/boards/viewtopic.php?p=4568#p4568
    ; http://msdn.microsoft.com/en-us/library/windows/desktop/bb774096%28v=vs.85%29.aspx
    ; http://msdn.microsoft.com/en-us/library/aa752094
    hwnd := (hwnd="") ? WinExist("A") : hwnd ; if omitted, use active window
    WinGet, ProcessName, ProcessName, % "ahk_id " hwnd
    if (ProcessName != "explorer.exe")  ; not Windows explorer
        return
    For pExp in ComObjCreate("Shell.Application").Windows
    {
        if (pExp.hwnd = hwnd) { ; matching window found
            if FullPath is integer  ; ShellSpecialFolderConstant
                pExp.Navigate2(FullPath)
            else
                pExp.Navigate("file:///" FullPath)
            return
        }
    }
}

RMApp_IsControlVisible(WinTitle,ControlClass) { ; used in Navigator
    ControlGet, IsControlVisible, Visible,, %ControlClass%, %WinTitle%
    return IsControlVisible
}

RMApp_ControlSetFocusR(Control, WinTitle="", Tries=3) { ; used in Navigator. More reliable ControlSetFocus
    Loop, %Tries%
    {
        ControlFocus, %Control%, %WinTitle%             ; focus control
        Sleep, 50
        ControlGetFocus, FocusedControl, %WinTitle%     ; check
        if (FocusedControl = Control)                   ; if OK
            return 1
    }
}

RMApp_ControlSetTextR(Control, NewText="", WinTitle="", Tries=3) {  ; used in Navigator. More reliable ControlSetText
    Loop, %Tries%
    {
        ControlSetText, %Control%, %NewText%, %WinTitle%            ; set
        Sleep, 50
        ControlGetText, CurControlText, %Control%, %WinTitle%       ; check
        if (CurControlText = NewText)                               ; if OK
            return 1
    }
}

;===Lib: RMApp_NavControlHandler }}}

;====================FavorItems}}}

::rfa::
reload
return
::afa::
edit
return