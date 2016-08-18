QZ_Main()
{
    Global gQZConfig, gQZShell
    gQZConfig := QZ_ReadConfig(QZGlobal.Config)
    INIWrite, %A_Scripthwnd%, %A_TEMP%\QZRunTime, Auto, HWND
    INIWrite, %A_ScriptFullPath%, %A_TEMP%\QZRunTime, Auto, FullPath
    OnMessage(WM_COPYDATA:=0x4A, "QZ_ReciveWMData")
}

; 允许其它脚本通过WM_COPYDATA调用
QZ_ReciveWMData(wParam, lParam)
{
    global gQZWMCMD
    StringAddress := NumGet(lParam + 2*A_PtrSize)  
    ; 获取 CopyDataStruct 的 lpData 成员.
    gQZWMCMD := StrGet(StringAddress)  ; 从结构中复制字符串.
    Settimer, QZ_WMCMD, -50 ; 使用settimer运行，方便直接return一个true过去
    return True
}

QZ_WMCMD()
{
    global gQZWMCmd
    If (gQZWMCmd = "Reload")
        Reload
    If (gQZWMCmd = "ExitApp")
        ExitApp
    If RegExMatch(gQZWMCmd,"i)/i\s+simpleMenuAll")
        MenuZAll()
    If RegExMatch(gQZWMCmd,"i)/i\s+simpleMenuWin")
        MenuZWin()
}

