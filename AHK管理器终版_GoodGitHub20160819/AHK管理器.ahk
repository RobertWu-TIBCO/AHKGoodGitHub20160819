;by  早亦闪人 At 2016.4.10
;更新说明
/*
2016.05.19:
1.增加winclose窗口名的方式结束脚本，主要用于script内脚本重启后PID变化后不能结束的问题。

2016.05.09：
1.重新定义gui界面；
2.Tray菜单增加禁用选项：实际禁用启动时关闭了所有脚本，再次启用时则Roload;
3.删减部分无效脚本源码。

2016.4.24:
 1.运行#脚本后，gui自动隐藏；
 2.启动脚本目录后，gui自动隐藏。

2016.4.17:
 1. 增加过滤中使用%A_ScriptDir%变量。
 
2016.4.14:
 1.修复2016.4.13版本中的1个bug;
 2.添加文件(夹)过滤功能：添加到过滤中的文件(夹),将不会被读取到AHK管理器中；
 3.修复之前版本某些脚本不能关闭问题；
 4.修复脚本不能正确读取ini配置问题。

2016.4.13:
 1.更新添加“Scripts文件夹内的第一层子文件夹脚本”，但所有脚本不能同名。

2016.4.11:
 1.脚本库中启动条目后,焦点自带设置为上一条,正在运行库同;
 2.更新脚本库双击运行脚本,正在运行库双击关闭脚本;
 3.脚本库增加右键菜单:"编辑","运行"--正在运行库增加右键菜单:"编辑","重载","关闭"。
*/

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
Process, Priority,, High
DetectHiddenWindows,On

Menu, Tray, NoStandard                  ;删除自带托盘菜单
Menu, tray, add, 管理,ShowGui   ;  显示gui
Menu, tray, add  ; 创建分隔线.
Menu, tray, add ,禁用,Menu_Tray_禁用         ;  禁用
Menu, tray, add ,过滤,Menu_Tray_过滤         ;  过滤
Menu, tray, add ,脚本目录,Menu_Tray_OpenDir          ;  脚本目录
Menu, tray, add ,重启管理器,Menu_Tray_Reload           ; 重启
Menu, tray, Add
Menu, tray, Add,帮助,Help								;Help
Menu, tray, Add,关于,About								;关于
Menu, tray, Add
Menu, tray, Add, 退出, ExitSub                  ; 创建     退出
Menu, Tray, Default, 管理  ;;默认   菜单：配置
Menu, Tray, Icon, Shell32.dll, 258

Gui,Destroy
Gui,Add,GroupBox,x10 y10 w166 h430, 脚本库 L
Gui,Add,GroupBox,x190 y10 w166 h430, 正在运行 R
Gui Add, ListView, x18 y28 w150 h400 AltSubmit  NoSortHdr vScriptLibrary g运行 , <脚本名称>
Gui Add, ListView, x198 y28 w150 h400  AltSubmit  NoSortHdr vScriptRun g运行2, <脚本名称>
Gui Add, Button, x370 y30 w60 h42 gtsk_open, 启动脚本
Gui Add, Button, x370 y100 w60 h42 gtsk_restart, 重载脚本
Gui Add, Button, x370 y170 w60 h42 gtsk_close, 关闭脚本
Gui Add, Button, x370 y240 w60 h42 gMenu_Tray_OpenDir, 脚本目录
Gui Add, Button, x370 y310 w60 h42 gMenu_Tray_Reload, 重启管理器
Gui Add, Button, x370 y380 w60 h42 gExitSub, 退出
Gui,ListView,ScriptLibrary
scriptCount = 0
禁用=0
IniRead,Golv,过滤.ini,过滤
OpenList := Array()
UnOpenList := Array()
Loop, %A_ScriptDir%\scripts\*.ahk,,1
{
 _Golv=0
 loop,Parse,Golv,`n,`r                  ;增加过滤判断
{
 StringReplace,_GolvPath,A_LoopField,`%A_ScriptDir`%,%A_ScriptDir%
ifInString,A_LoopFileLongPath ,%_GolvPath%
{
 _Golv=1
break
}
}
if  _Golv=1
 continue
  if !(A_LoopFileLongPath~="i).+?\\scripts\\[^\\]*\\?[^\\]+\.ahk")                          ;增加一层子文件读取
  continue
StringReplace, MenuName, A_LoopFileName, .ahk
scriptCount += 1
%MenuName%_Path :=A_LoopFileLongPath
%MenuName%_Dir :=A_LoopFileDir
scriptsName%scriptCount% := A_LoopFileName
;scriptsOpened%scriptCount% = 0
UnOpenList.Insert(MenuName)
}
InsertionSort(UnOpenList)
for Index, MenuName in UnOpenList
{
LV_Add("",MenuName)
}
gosub tsk_openAll
return

运行:
if A_GuiEvent = DoubleClick
{
  goto,tsk_open
}
return

运行2:
if A_GuiEvent = DoubleClick
goto,tsk_close
return

GuiContextMenu:  ; 运行此标签来响应右键点击或按下 Appskey.
if A_GuiControl = ScriptLibrary  ; 这个检查是可选的. 让它只为 ListView 中的点击显示菜单.
{
Gui,ListView,ScriptLibrary
RowNumber = 0
Loop,%scriptCount%
{
RowNumber := LV_GetNext(RowNumber)
if not RowNumber
Return
break
}
Menu,PopC,Add,编辑,P_edit
Menu,PopC,Add,运行,tsk_open
menu,PopC,Show
return
}
if  A_GuiControl = ScriptRun
{
Gui,ListView,ScriptRun
RowNumber = 0
Loop,%scriptCount%
{
RowNumber := LV_GetNext(RowNumber)
if not RowNumber
Return
break
}
Menu,PopC2,Add,编辑,P_edit
Menu,PopC2,Add,定位,P_Explorer
Menu,PopC2,Add,重载,tsk_restart
Menu,PopC2,Add,关闭,tsk_close
menu,PopC2,Show
return
}
return

P_Explorer:
LV_GetText(thisScript, RowNumber)
P_editpath :=%thisScript%_path
clipboard:=P_editpath
;StringReplace, clipboard, clipboard, /, \, All
RunAndGetOutput("explorer /e,/select," clipboard) ;why only this works ?
return

RunAndGetOutput(command)
{
    tempFileName := "RunZ.stdout.log"
   fullCommand = %ComSpec% /C "%command% > %A_Temp%\%tempFileName%"
    RunWait, %fullCommand%, %A_Temp%, Hide
    FileRead, result, %A_Temp%\%tempFileName%
    return result
}

P_edit:
LV_GetText(thisScript, RowNumber)
P_editpath :=%thisScript%_path
;Run, F:\Program Files\AutoHotkey\SciTE\SciTE.exe  "%P_editpath%"
Run, "F:\Program Files\Notepad++\notepad++.exe"  "%P_editpath%"
return

tsk_open:
Gui,ListView,ScriptLibrary
RowNumber = 0
Loop,%scriptCount%
{
RowNumber := LV_GetNext(RowNumber)
if not RowNumber
Return
LV_GetText(thisScript, RowNumber)
Run,% %thisScript%_Path,% %thisScript%_Dir,,%thisScript%
IfInString, thisScript, #
{
 Gui, Hide
Return
}
break
}
Gui,ListView,ScriptRun
LV_Add("",ThisScript)
Gui,ListView,ScriptLibrary
Loop, %scriptCount%
{
LV_GetText(outputname,A_Index,1)
if (outputname=ThisScript)
{
LV_Delete(A_Index)
if A_Index<>1
   {
  LV_Modify(A_Index-1, "Select")
   }
   else
   {
    LV_Modify(1, "Select")
   }
break
}
}
return

tsk_close:
Gui,ListView,ScriptRun
RowNumber = 0
Loop,%scriptCount%
{
RowNumber := LV_GetNext(RowNumber)
if not RowNumber
Return
LV_GetText(thisScript, RowNumber)
ID:=%thisScript%
WinClose,% %thisScript%_path . " - AutoHotkey"
if ahk_pid %ID%
{
WinClose, ahk_pid %ID%
IfWinExist,ahk_pid %ID%
 Process,Close,%ID%
}
break
}
Gui,ListView,ScriptLibrary
LV_Add("",ThisScript)
Gui,ListView,ScriptRun
Loop, %scriptCount%
{
LV_GetText(outputname,A_Index,1)
if (outputname=thisScript)
{
LV_Delete(A_Index)
if A_Index<>1
   {
  LV_Modify(A_Index-1, "Select")
   }
   else
   {
    LV_Modify(1, "Select")
   }
break
}
}
return

tsk_restart:
Gui,ListView,ScriptRun
RowNumber = 0
Loop,%scriptCount%
{
RowNumber := LV_GetNext(RowNumber)
if not RowNumber
Return
LV_GetText(thisScript, RowNumber)
ID:=%thisScript%
WinClose,% %thisScript%_path . " - AutoHotkey"
if ahk_pid %ID%
{
WinClose, ahk_pid %ID%
IfWinExist,ahk_pid %ID%
 Process,Close,%ID%
}
Run,% %thisScript%_Path,% %thisScript%_Dir,,%thisScript%
break
}
return

tsk_openAll:
Loop, %scriptCount%
{
thisScript := scriptsName%A_Index%
StringReplace, thisScript, thisScript, .ahk
IfInString, thisScript, _           ;IfInString,%thisScript%_Path,%A_ScriptDir%\Scripts\_    不自动启动_文件夹内的脚本
{
continue
}
IfInString, thisScript, #
{
continue
}
Run, % %thisScript%_Path,% %thisScript%_Dir,,%thisScript%
Gui,ListView,ScriptRun
LV_Add("",thisScript)
Gui,ListView,ScriptLibrary
Loop, %scriptCount%
{
LV_GetText(outputname,A_Index,1)
if (outputname=thisScript)
{
LV_Delete(A_Index)
break
}
}
}
;last time it crashes, there is a file in its folder once I sort the db file the other file is gone and issue fixed
Run,F:\Program Files\AutoHotkey\AutoHotkeyU32.exe Scripts\AHKManager\UserDefine\moreFunc\Habit1625\Habit-1621-LiuMeng.ahk
;run,F:\Program Files\AutoHotkey\AutoHotkeyA32.exe ..\QQDown\1625\Habit.ahk  ;crash
;run,F:\Program Files\AutoHotkey\Scripts\AHK管理器【终版】\Scripts\AHKManager\RunZ.ahk ; add this so CapsLock & j could be used in RunZ since gmail would override RunZ otherwise
run,Scripts\Libs\ForAHK\LabelControl_vZz_键盘党利器\LabelControl_vZz.ahk
return

Menu_Tray_禁用:
if 禁用
Reload
禁用=1
Menu, tray,ToggleCheck,禁用
Gui,ListView,ScriptRun
Loop % LV_GetCount()
{
LV_GetText(thisScript, A_Index)
ID:=%thisScript%
WinClose,% %thisScript%_path . " - AutoHotkey"
if ahk_pid %ID%
{
WinClose, ahk_pid %ID%
IfWinExist,ahk_pid %ID%
 Process,Close,%ID%
}
}
Suspend
return

Menu_Tray_过滤:
Run, Notepad.exe  过滤.ini
return

::apath::
Menu_Tray_OpenDir:
Run, %A_ScriptDir%\scripts
gui,Hide
return

Menu_Tray_Reload:
gui,Hide
Gui,ListView,ScriptRun
Loop % LV_GetCount()
{
LV_GetText(thisScript, A_Index)
ID:=%thisScript%
WinClose,% %thisScript%_path . " - AutoHotkey"
if ahk_pid %ID%
{
WinClose, ahk_pid %ID%
IfWinExist,ahk_pid %ID%
 Process,Close,%ID%
}
}
Reload
return

GuiEscape:
GuiClose:
Gui, Hide
return

ExitSub:
;msgbox,260,是否退出？,退出脚本,将退出所有经过AHK管理器启动的脚本，你是否确认退出？
;IfMsgBox No
;    return
gui,Hide
Gui,ListView,ScriptRun
Loop % LV_GetCount()
{
LV_GetText(thisScript, A_Index)
ID:=%thisScript%
WinClose,% %thisScript%_path . " - AutoHotkey"
if ahk_pid %ID%
{
WinClose, ahk_pid %ID%
IfWinExist,ahk_pid %ID%
 Process,Close,%ID%
}
}
Gui,Destroy
ExitApp
return

InsertionSort(ByRef array)
{
target := Array()
count := 0
for Index, Files in array
{
files%Index% := Files
count += 1
}
j := 2
while (j <= count)
{
key := files%j%
i := j-1
while (i >= 0 && key < files%i%)
{
k := i+1
files%k% := files%i%
i -= 1
}
k := i+1
files%k% := key
j += 1
}
Loop, %count%
{
target.Insert(files%A_Index%)
}
array := target
}

About:
msgbox,AHK管理器`n版本号：2016.5.9`nCopyright©2016 早亦闪人.  All Rights Reserved.`n`n关于作者:`n`tName:早亦闪人`n`tQQ:3300372390
return

Help:
msgbox,将AHK脚本放在脚本目录下进行管理:`n1.以_开头的脚本不会自动加载`n2.以#开头的脚本为临时脚本即运行完就退出`n3.脚本名字不能有空格及除_、#以为的符号`n4.脚本不能为快捷方式
return
^!+e::
::shs::
::sh1::
ShowGui:
gui,Show,,AHK管理器
return

::hid::
::hid1::
Gui,hide
return

::rr::
reload
return