/*
Plugin=文件加标签
Name1=文件加标签
Command1=DM_FileTag
Author=Array
Version=0.1
*/

DM_FileTag(aParam)
{
    FT := MenuZ_GetSub()
    FT.SetParams({iconsSize:16})
    If IsObject(FileTag_Sub(FT, "Main"))
        ;FT.Add()
    ;FT.Add({Name:"管理标签(&M)"})
    Return FT
}

FileTag_Sub(aMenu, aSec)
{
    Loop
    {
        strName := FileTag_Read(aSec, A_Index)
        If ErrorLevel
            Break
        If !Strlen(strName) || RegExMatch(strName, "^#")
            Continue
        If RegExMatch(strName, "^\-$")
            aMenu.Add()
        Else If RegExMatch(strName, "^[^\|]*\|\|")
        {
            FileTag_Sub(SubMenu := MenuZ_GetSub({"IconsSize":16}), RegExReplace(strName, "^.*\|\|"))
            aMenu.Add({"Name":RegExReplace(strName,"\|\|.*$"),"SubMenu":SubMenu})
        }
        Else
        {
            aMenu.Add({"Name":RegExReplace(strName,"\|.*$"),"UID":{handle:"DM_FileTag_handle",Data:RegExReplace(strName,"^.*\|")}})
        }
    }
    Return aMenu
}

DM_FileTag_handle(aMsg, aObj)
{
    If (aMsg = "OnRun")
    {
        If (aObj.Name = "管理标签(&M)")
            FileTag_Manager()
        Else
            FileTag_Engine(aobj.uid.data)
    }
}

FileTag_Engine(aString)
{
    Global gMenuZ
    FileSrc := gMenuZ.Data.Files
    SplitPath, FileSrc, strName, strDir, strExt, strName2, strDrive
    FileGetTime, TimeModify, %FileSrc%, M
    FileGetTime, TimeCreate, %FileSrc%, C
    FileGetTime, TimeAccess, %FileSrc%, A
    String := aString
    If RegExMatch(strName, "i)(\-*(?:Version|Ver|V))([\-\d\.]*)", Match)
    {
        StrMatch := Match1 RegExReplace(Match2, "[\-\.]$")
        strPrev := RegExReplace(StrMatch, "(\d+)$")
        strNum := RegExReplace(StrMatch, "^.*[\-\.]")
        OldVer := strPrev strNum
        strNum := strNum + 1
        strVer := strPrev strNum
    }
    String := RegExReplace(String, "i)<n>", strName2)
    String := RegExReplace(String, "i)<e>", strExt)
    String := RegExReplace(String, "i)<m>", A_MM)
    String := RegExReplace(String, "i)<d>", A_DD)
    String := RegExReplace(String, "i)<y>", A_YYYY)
    String := RegExReplace(String, "i)<tm>", TimeModify)
    String := RegExReplace(String, "i)<tc>", TimeCreate)
    String := RegExReplace(String, "i)<ta>", TimeAccess)

    If RegExMatch(String, "i)<v>") 
    {
        If Strlen(OldVer)
        {
            String := RegExReplace(String, ToMatch(OldVer))
            String := RegExReplace(String, "i)<v>", OldVer)
            String := RegExReplace(String, ToMatch(OldVer), strVer)
        }
        Else
        {
            String := RegExReplace(String, "i)<v>", "Ver-1")
        }
    }
    FileDes := strDir "\" string
    If InStr(FileExist(FileSrc), "D")
        FileMoveDir, %FileSrc%, %FileDes%, R
    Else
        FileMove, %FileSrc%, %FileDes%
    If ErrorLevel
        Msgbox Rename Error !
}

FileTag_Manager()
{
    Global gFileTag
    gFileTag := {}
    Gui, FileTag: Destroy
    Gui, FileTag: Default
    Gui, FileTag: Font, s10, Microsoft YaHei
    Gui, FileTag: Add, TreeView, x10 y10 w180 h400 AltSubmit gFileTag_Manager_Event
    Gui, FileTag: Add, Edit, x260 y10 w150 h26
    Gui, FileTag: Add, Edit, x260 y40 w250 h26
    Gui, fileTag: Show, w620 , 文件加标签
    FileTag_Manager_Sub(0, "Main")
}

FileTag_Manager_Sub(aPID, aSec)
{
    Global gFileTag
    Loop
    {
        ErrorLevel := False
        strName := FileTag_Read(aSec, A_Index)
        If ErrorLevel
            Break
        If RegExMatch(strName, "^\-$")
        {
            newID := TV_Add("-", aPID)
        }
        Else If RegExMatch(strName, "^[^\|]*\|\|")
        {
            newID := TV_Add(RegExReplace(strName,"\|\|.*$"), aPID)
            FileTag_Manager_Sub(newID, RegExReplace(strName, "^.*\|\|"))
        }
        Else
        {
            newID := TV_Add(RegExReplace(strName,"\|.*$"), aPID)
        }
        gFileTag[newID] := strName
    }
}

FileTag_Manager_Event()
{
    Global gFileTag
    If (A_GuiEvent = "Normal") && A_EventInfo
    {
        strName := gFileTag[A_EventInfo]
        GuiControl, , Edit1, % RegExReplace(strName,"\|.*$")
        GuiControl, , Edit2, % RegExReplace(strName,"^.*\|")
    }
}

FileTag_Manager_Save()
{
}

FileTag_Read(aSec, aKey:="")
{
    Config := A_ScriptDir "\User\FileTags\FileTags.ini"
    If FileExist(Config)
    {
        IniRead, RTN, %Config%, %aSec%, %aKey%
    }
    Else
    {
        FileAppend, , %Config%
        ErrorLevel := True
    }
    If (RTN = "ERROR")
    {
        RTN := ""
        ErrorLevel := True
    }
    Return RTN
}

FileTag_Write(aValue, aSec, aKey)
{
    Config := A_ScriptDir "\User\FileTags\FileTags.ini"
    If FileExist(Config)
        IniWrite, aValue, %Config%, %aSec%, %aKey%
    Else
        Msgbox % Config " Not Exist !"
}
