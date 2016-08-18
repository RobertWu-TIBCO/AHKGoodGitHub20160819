#NoEnv
#SingleInstance, Force
SendMode Input
SetWorkingDir %A_ScriptDir% 
Menu, Tray, Icon, % QZGlobal.DefaultIcl, 1
Menu, Tray, NoIcon
INIWrite, %A_Scripthwnd%, %A_TEMP%\QZRunTime, GUI, HWND
INIWrite, %A_ScriptFullPath%, %A_TEMP%\QZRunTime, GUI, FullPath
CmdParam := {}
Loop, %0%
{
    CmdParam[A_Index] := %A_Index%
}
If FileExist(strPath:=QZGlobal.Config)
    FileCopy, %strPath%, %strPath%_Bak, 1
gCommandJson := QZ_ReadConfig(QZGlobal.Commands) 
TCMatchOn(QZGlobal.TcMatchDll)
GUI_Main_Load()
GUI_Main_LoadMenuZ()
QZ_UpdatePlugin()
QZ_UpdateCode()
If RegExMatch(gQZWMCmd := CmdParam[1] A_Space CmdParam[2]
    , "i)^\-[fm]\s[a-f\d]{8}(-[a-f\d]{4}){3}-[a-f\d]{12}$") 
    GUI_WMCMD()
Return

#Include <Class_GUI2>
#Include <Class_ScrollGUI>
#Include <Class_QZLang>
#Include <Class_QZGlobal>
#Include <Class_Json>
#Include <Class_TreeView>
#Include <Class_VimDesktop>
#Include <Toolbar>
#Include <QZ_CreateConfig>
#Include <QZ_API>
#Include <QZ_Engine>

; GUI界面
#Include <Class_CtlColors>
#Include <Dlg>
#Include <GUI_Main>
#Include <GUI_ItemEditor>
#Include <GUI_GroupEditor>
#Include <GUI_FilterEditor>
#Include <GUI_EnvEditor>
#Include <GUI_FilterMgr>
#Include <GUI_ItemEditorCode>
#Include <GUI_ItemEditorCmd>
#Include <GUI_ItemProperty>
#Include <GUI_ItemCategory>
#Include <GUI_IconSelector>
#Include <GUI_WinEditor>
#Include <GUI_ModeEditor>
#Include <GUI_KeyMap>
#Include <GUI_ItemSelector>
#Include <TCMatch>

; 其它库
#Include <Path_API>
