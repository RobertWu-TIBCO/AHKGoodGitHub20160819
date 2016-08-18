/*!
  - Function: QZ_Tray
  - Parameters: 无
  - Returns: 无
  - Remarks: 用于生成图标
 */

QZ_Tray()
{
    Menu, TrayDebug, Add, % QZLang.ListLines, QZ_ListLines
    Menu, TrayDebug, Add, % QZLang.ShowKey , QZ_ShowKey
    Menu, Tray, Icon, % QZGlobal.DefaultIcl, 1
    Menu, Tray, NoStandard
    Menu, Tray, Add, % QZLang.OpenEditor, QZ_OpenEditor
    Menu, Tray, Add, 帮助文档, QZ_OpenDocs
    Menu, Tray, Add
    Menu, Tray, Add, % QZLang.Debug, :TrayDebug
    Menu, Tray, Add, % QZLang.Suspend, QZ_Suspend
    Menu, Tray, Add, % QZLang.Reload, QZ_Reload
    Menu, Tray, Add
    Menu, Tray, Add, % QZLang.ExitQZ, QZ_Exit
    Menu, Tray, Default, % QZLang.OpenEditor
    Menu, Tray, Click, 1
    Menu, Tray, Tip, % "QuickZ`n版本: " QZGlobal.Version
}

QZ_ListLines()
{
    ListLines
}

QZ_ShowKey()
{
    Global VIMD
    VIMD.DebugShow()
}

QZ_OpenEditor()
{
    Run "%A_ahkpath%" "%A_ScriptDir%\Editor.ahk"
}

QZ_Exit()
{
    ExitApp
}

QZ_Suspend()
{
    Menu, Tray, ToggleCheck, % QZLang.Suspend
    Suspend, Toggle
}

QZ_Pause()
{
    Pause, Toggle
}

QZ_Reload()
{
    Reload
}

QZ_OpenDocs()
{
    Run http://quickz.mydoc.io
}
