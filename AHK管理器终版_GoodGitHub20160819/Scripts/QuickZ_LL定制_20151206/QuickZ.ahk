#NoEnv 
#SingleInstance, Force
SetBatchLines, -1
SendMode Input
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen
SetKeyDelay, -1
SetControlDelay,-1
;RunAsAdmin()
QZ_Tray()
QZ_Main()
QZ_MenuZ()
xhotkey("#f", "MenuZALL")
xhotkey("^+LButton", "MenuZALL")
xhotkey("#z", "MenuZWin")
QZ_VimD()
return

#Include <QZ_MenuZ>
#Include <QZ_API>
#Include <Class_Json>
#Include <PUM>
#Include <PUM_API>
#Include <Path_API>
#Include <Class_QZGlobal>
#Include <Class_QZLang>
#Include <Class_VimDesktop>
#Include <QZ_Plugins>
#Include <QZ_Codes>
#Include <TT>

::aqz::
edit
return

::rqz::
reload
return