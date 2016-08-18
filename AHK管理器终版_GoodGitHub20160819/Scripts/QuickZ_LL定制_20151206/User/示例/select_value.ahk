/*
Plugin=Select_Value
Name1=显示选择的内容
Command1=DM_Select_Value
Author=Array
Version=0.1
*/

DM_Select_Value(aParam) ; 此Plugin执行的command为Test，代表执行Test函数,函数请预留一个aParam，用于QuickZ传递参数过来。
{
    Icons := Select_Value_GetIcon(QZData("Files"), QZData("FileExt"))
    If !Strlen(Value:=QZData("Files"))
    {
        Icons := Select_Value_GetIcon("", "text")
        If !Strlen(Value:=QZData("Text"))
        {
            Value:=QZData("WinTitle")
            WinGet, Icons, ProcessPath, % "ahk_id" QZData("Hwnd")
            icons := Icons ":0"
        }
    }
    TestMenu := MenuZ_GetSibling() ; 获取一个子菜单对象
    TestMenu.Add({name:Select_Value_CutLeng(Value),icon:Icons,uid:{Handle:"DM_Select_Value_Handle",Data:Value}}) ; 可以添加菜单
    ;TestMenu.Add() ; 可以添加菜单
    return TestMenu  ; 必须返回子菜单对象
}

;Test + _Handle 会被QuickZ获取到，并把点击的内容转换到此函数中
DM_Select_Value_Handle(aMsg, aObj) 
{
    If (aMsg = "OnRun")
        Clipboard := aObj.Uid.Data
}

Select_Value_CutLeng(String, Length:=24)
{
    If !(StrLen(String) > Length)
        Return String
    Str1 := SubStr(String, 1, Length/2)
    Str2 := SubStr(String, 0-Length/2)
    Return Str1 . " ... " Str2
}

Select_Value_GetIcon(FilePath, Ext)
{
    If RegExMatch(ext,"i)^MultiFiles$")
        Return A_WinDir "\system32\shell32.dll:54"
    else If RegExMatch(ext,"i)^Folder$")
        Return A_WinDir "\system32\shell32.dll:4"
    else If RegExMatch(ext,"i)^Drive$")
        Return A_WinDir "\system32\shell32.dll:9"
    else If RegExMatch(ext,"i)^\lnk$")
        Return A_WinDir "\system32\shell32.dll:264"
    else If RegExMatch(ext,"i)^\qza$")
        Return A_ScriptDir "\ICONS\MenuZ.icl:0"
    else If RegExMatch(ext,"i)^text$")
        Return A_WinDir "\system32\shell32.dll:267"
    /*
    Author - axlar
    url - https://autohotkey.com/board/topic/89679-why-i-use-shgetfileinfo-get-file-type-name-failed-in-ahk-h/ 
    Thansk !
    */ 
    SHGFI_TYPENAME = 0x000000400
    SHGFI_DISPLAYNAME = 0x000000200
    SHGFI_ICON = 0x000000100
    SHGFI_ATTRIBUTES = 0x000000800
    MAX_PATH := 260
    SHFILEINFO := "
    (
      INT_PTR hIcon;
      DWORD   iIcon;
      DWORD   dwAttributes;
      WCHAR   szDisplayName[" MAX_PATH "];
      WCHAR   szTypeName[80];
    )"
    SHFO := Struct(SHFILEINFO)
    DllCall("Shell32\SHGetFileInfo" . (A_IsUnicode ? "W":"A"), "str", FilePath, "uint", 0, "ptr", SHFO[""], "uint", sizeof(SHFILEINFO), "uint", SHGFI_TYPENAME|SHGFI_DISPLAYNAME|SHGFI_ICON|SHGFI_ATTRIBUTES)
    hIcon := SHFO.hIcon
    ;iIcon := SHFO.iIcon
    ;dwAttributes := SHFO.dwAttributes
    ;szDisplayName := StrGet(SHFO.szDisplayName[""])
    ;szTypeName := StrGet(SHFO.szTypeName[""])
     
    ;MsgBox, % "hIcon: " . hIcon . "`n"
    ;. "iIcon: " . iIcon . "`n"
    ;. "dwAttributes: " . dwAttributes . "`n"
    ;. "szDisplayName: " . szDisplayName . "`n"
    ;. "szTypeName: " . szTypeName . "`n"
    Return hIcon
}
