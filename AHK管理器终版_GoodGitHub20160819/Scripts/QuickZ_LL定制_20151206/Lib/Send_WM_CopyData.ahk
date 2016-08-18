Send_WM_COPYDATA(aString, IsGUI:=False)
{
    Prev_DetectHiddenWindows := A_DetectHiddenWindows
    Prev_TitleMatchMode := A_TitleMatchMode
    DetectHiddenWindows On
    SetTitleMatchMode 2
    If IsGUI
    {
        IniRead, nHwnd, %A_TEMP%\QZRunTime, GUI, HWND
        IniRead, FullPath, %A_TEMP%\QZRunTime, GUI, FullPath
        Param := A_Space  aString
    }
    Else
    {
        IniRead, nHwnd, %A_TEMP%\QZRunTime, Auto, HWND
        IniRead, FullPath, %A_TEMP%\QZRunTime, Auto, FullPath
        ;FullPath := A_ScriptDir "\QuickZ.ahk"
    }
    If !WinExist("ahk_id " nHwnd)
    {
        Run,%A_AhkPath% "%FullPath%" %Param%
    }
    Else
    {
        VarSetCapacity(CopyDataStruct, 3*A_PtrSize, 0)  
        SizeInBytes := (StrLen(aString) + 1) * (A_IsUnicode ? 2 : 1)
        NumPut(SizeInBytes, CopyDataStruct, A_PtrSize) 
        NumPut(&aString, CopyDataStruct, 2*A_PtrSize)
        Prev_DetectHiddenWindows := A_DetectHiddenWindows
        Prev_TitleMatchMode := A_TitleMatchMode
        SendMessage, 0x4a, 0, &CopyDataStruct,, ahk_id %nHwnd%
    }
    DetectHiddenWindows %Prev_DetectHiddenWindows%  
    SetTitleMatchMode %Prev_TitleMatchMode% 
    return ErrorLevel  
}
