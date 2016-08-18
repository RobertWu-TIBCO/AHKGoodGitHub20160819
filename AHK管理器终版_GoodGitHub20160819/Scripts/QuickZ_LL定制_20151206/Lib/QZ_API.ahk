/*
    Title: QZ_API 函数库
        此函数库用于QuickZ操作数据。

        * 文件路径:  *.\Lib\QZ_API.ahk*
        * 版本:  2015/10/16
*/

QZ_GetConfig()
{
    Global gQZConfig
    Return gQZConfig
}


QZData(Param:="")
{
    Global objData
    If RegExMatch(Param, "^%[^{}]*%$")
        Return QZ_ReplaceEnv(Param)
    Else If RegExMatch(Param, "^{[^{}]*}$")
        Return QZ_LabelTrans(Param)
    Else If Strlen(Param) 
        Return objData[Param]
    Else
        Return objData
}


/*
    Function: QZ_GetData()
        返回QuickZ数据对象

    Parameters:
        x - 鼠标x坐标
        y - 鼠标y坐标
        hWnd - 程序的 ahk_id
        WinControl - 程序焦点所在控件的 classNN
        WinClass - 程序的 ahk_class
        WinExe - 程序的 exe名，如notepad.exe
        Files - 获取到的文件列表
        Text - 获取到的文本内容
        FileExt - 文件后缀名。文件夹为: *Folder* 、驱动器路径为: *Drvie* 、无后缀为: *NoExt* 、多文件时为: *MultiFiles*
        FileName - 获取的文件名/文件夹名，多文件无效
        FileDir - 获取的文件/文件夹对应的上级文件夹
        FileMulti - 对象，包含各个文件的后缀名
        SepMode - 关键字过滤使用独立模式
        Keyword - 当前热键对应的关键字
*/

QZ_GetData()
{
    ObjData := {"x":0
        ,"y":0
        ,"hWnd":0
        ,"WinClass":""
        ,"WinExe":""
        ,"WinTitle":""
        ,"WinControl":""
        ,"Files":""
        ,"FileExt":""
        ,"FileName":""
        ,"FileDir":""
        ,"FileMulti":[]
        ,"Text":""
        ,"SepMode":0
        ,"keyword":""}
    Return ObjData
}


/*
    Function: QZ_GetClip()
        获取剪切板数据，并对文件类型进行预处理

    Parameters:
        aData - (ByRef)保存数据的对象
*/

QZ_GetClip(ByRef aData)
{
    Global gQZConfig ;, QuickZ_ClipSave, QuickZ_Clip
    method  := gQZConfig.Setting.MenuZ.Method
    timeout := gQZConfig.Setting.MenuZ.Timeout
    If Not TimeOut
        TimeOut := 0.6
    ; 监听剪切板
    CB := ClipboardAll
    Clipboard := ""
    if( method = 1 )
      SendInput, ^{Ins}
    else
      SendInput, ^c ;^{vk43sc02E} ;ctrl+c
    ClipWait,% timeout, 1
    ErrorCode := !Errorlevel ; 超时
    if DllCall( "IsClipboardFormatAvailable", "UInt", iFmt:=15)
    {
        aData.Files := Clipboard
        strFile := aData.Files
        aData.FileExt := QZ_GetFileExt(aData.Files)
        If InStr(aData.Files, "`n")
        {
            Loop, Parse, strFile, `n, `r
            {
                strFile := A_LoopField
                SplitPath, strFile, strFileName, strFileDir
                aData.FileDir := strFileDir
                Break
            }
            aData.FileMulti := QZ_GetFileMulti(aData.Files)
        }
        Else
        {
            SplitPath, strFile, strFileName, strFileDir
            aData.FileName := strFileName
            aData.FileDir := strFileDir
        }
    }
    else
    {
        aData.Text := Clipboard
    }
    ;QuickZ_Clip := Clipboard
    ;QuickZ_ClipSave := ClipboardAll
    Clipboard := CB
    return ErrorCode ; 获取到数据返回True、超时返回False
}
/*
    Function: QZ_GetWinInfo()
        获取当前窗口信息

    Parameters:
        aData - (ByRef)保存数据的对象
*/
QZ_GetWinInfo(ByRef aData)
{
    MouseGetPos, _PosX, _PosY, _ID, _CTRL ;获取相关的数据 
    WinGetTitle, _Title, ahk_id %_ID%
    WinGetClass, _Class, ahk_id %_ID%
    WinGet, _Exe,  ProcessName, ahk_id %_ID%
    aData.x := _PosX
    aData.y := _PosY
    aData.HWND := _ID
    aData.WinClass := _Class
    aData.WinExe:= _Exe
    aData.WinControl := _Ctrl
    aData.WinTitle := _Title
}

/*
    Function: QZ_GetKeyword(aKey, ByRef aData)
        获取热键对应的关键字

    Parameters:
        aKey - 热键名
        aData - (ByRef)保存数据的对象
*/

QZ_GetKeyword(aKey, ByRef aData)
{
    Global gQZConfig
    ;aData.Keyword := "s"
    ;aData.SepMode := True
}

/*
    Function: QZ_GetFileMulti(aFileList)
        将文件列表转换为后缀列表

    Parameters:
        aFileList - 文件列表
        aPrefix - 返回的后缀名可添加前缀，如 .doc

    Return:
        返回对象，如 {txt:Ture, doc:Ture}
*/

QZ_GetFileMulti(aFileList, aPrefix="")
{
    obj := {}
    Loop, Parse, aFileList, `n, `r
        obj[QZ_GetFileExt(A_LoopField, aPrefix)] := True
    Return obj
}

/*
    Function: QZ_GetFileExt(aFile, aPrefix="")
        返回aFile对应的文件格式

    Parameters:
        aFile - 需要判断的文件
        aPrefix - 返回的后缀名可添加前缀，如 .doc

    Return:
        返回后缀名，如 "exe"

    Remark:
        文件夹为: *Folder* 
        驱动器路径为: *Drvie* 
        无后缀名文件为: *NoExt* 
        多文件时为: *MultiFiles*
        其它文件为相应的后缀名
*/

QZ_GetFileExt(aFile, aPrefix="")
{
    cons_MultiFiles := "MultiFiles"
    cons_Folder     := "Folder"
    cons_NoExt      := "NoExt"
    cons_Drive      := "Drive"
    If InStr(aFile, "`n")
        Return cons_MultiFiles
    If InStr(FileExist(aFile), "D")
    {
        If RegExMatch(aFiles,"[a-zA-Z]:\\$")
            Return cons_Drive
        Else
            Return cons_Folder
    }
    SplitPath,aFile,,,Ext
    If Strlen(Ext)
        Return aPrefix Ext
    Else
        Return cons_NoExt
}

QZ_MatchStr(aMatch, aKeyword) ; 精确
{
    If (aMatch = "*") && Strlen(aKeyword)
        Return True
    arr := StrSplit(aMatch, "`;")
    Loop % arr.MaxIndex()
    {
        If (arr[A_Index] = aKeyword)
            Return True
    }
}

QZ_MatchTextRegex(aKeyword, aMatch) ; 范围判断
{
    If (aKeyword = "*") && Strlen(aMatch)
        Return True
    arr := StrSplit(aKeyword, "`;")
    Loop % arr.MaxIndex()
    {
        If InStr(aMatch, arr[A_Index])
            Return True
    }
}

QZ_MatchFileMulti(aKeyword, aMatch)
{
    
    If (aKeyword = "*") 
    {
        IsMultiFile := False
        for i , k in aMatch
        {
            IsMultiFile := True
            Break
        }
        Return IsMultiFile
    }
    arr := StrSplit(aKeyword, "`;")
    obj := {}
    Loop % arr.MaxIndex()
        obj[arr[A_Index]] := True
    idx := 0
    For key , value IN aMatch
    {
        idx++
        If !obj[key]
            Return False
    }
    If !idx
        Return False
    Return True
}

QZ_RegexFileMulti(aObj, aMatch)
{
    For Key , Value In aObj
    {
        If !RegExMatch(Key, aMatch)
            Return False
    }
    Return True
}

QZ_GetIcon(FilePath, Ext:="")
{
    If Strlen(Ext)
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
    }
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

QZ_Rgb(c){
	setformat,IntegerFast,H
	c:=(c&255)<<16|(c&65280)|(c>>16),c:=SubStr(c,1)
	SetFormat,IntegerFast,D
	return c
}

QZ_AlignLen(aName, Len=50)
{
    newName := aName
    If InStr(aName, ">>")
    {
        Prefix := RegExReplace(aName, ">>.*")
        PrefixLen := Strlen(Prefix)
        Suffix := RegExReplace(aName, "^.*?>>")
        SuffixLen := StrLen(RegExReplace(Suffix, "&"))
        SpaceCount := Len - PrefixLen - SuffixLen
        If SpaceCount > 0
        {
            Loop % SpaceCount
                Spaces .= A_Space
            newName := Prefix Spaces Suffix
        }
        ;msgbox % ">" Prefix "<`n>" Suffix "<"
    }
    Return newName
}

#Include <_Struct>
#Include <Sizeof>
