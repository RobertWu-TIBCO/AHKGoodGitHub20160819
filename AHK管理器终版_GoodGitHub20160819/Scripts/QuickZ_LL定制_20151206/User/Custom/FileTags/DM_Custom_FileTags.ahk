/*
Plugin=文件名加标签
Name1=文件名加标签
Command1=DM_Custom_FileTag
Author=Array
Version=0.1
*/

DM_Custom_FileTag(aParam)
{
    Global LineFileDir
    SplitPath, A_LineFile, LineFileName, LineFileDir, LineFileExtension, LineFileNameNoExt, LineFileDrive ;获取插件脚本文件的路径等相关变量
    FT := MenuZ_GetSub()
    FT.SetParams({iconsSize:16})
    If IsObject(CustomFunction_FileTag_Sub(FT, "Main"))
        ;FT.Add()
    ;FT.Add({Name:"管理标签(&M)"})
    Return FT
}

CustomFunction_FileTag_Sub(aMenu, aSec)
{
    Loop
    {
        strName := CustomFunction_FileTag_Read(aSec, A_Index)
        If ErrorLevel
            Break
        If !Strlen(strName) || RegExMatch(strName, "^#")
            Continue
        If RegExMatch(strName, "^\-$")
            aMenu.Add()
        Else If RegExMatch(strName, "^[^\|]*\|\|")
        {
            CustomFunction_FileTag_Sub(SubMenu := MenuZ_GetSub({"IconsSize":16}), RegExReplace(strName, "^.*\|\|"))
            aMenu.Add({"Name":RegExReplace(strName,"\|\|.*$"),"SubMenu":SubMenu})
        }
        Else
        {
            aMenu.Add({"Name":RegExReplace(strName,"\|.*$"),"UID":{handle:"DM_FileTag_handle",Data:RegExReplace(strName,"^.*\|")}})
        }
    }
    Return aMenu
}

CustomFunction_DM_FileTag_handle(aMsg, aObj)
{
    If (aMsg = "OnRun")
    {
        If (aObj.Name = "管理标签(&M)")
            CustomFunction_FileTag_Manager()
        Else
            CustomFunction_FileTag_Engine(aobj.uid.data)
    }
}

CustomFunction_FileTag_Engine(aString)
{
    Global gMenuZ
    FileSrc := gMenuZ.Data.Files
    SplitPath, FileSrc, strName, strDir, strExt, strName2, strDrive
    ;==============
    ;在这里添加自定义变量
    strNameNoTemplatePrefix:=RegExRePlace(strName2,"((\(模板\))|(\[模板\]))\.")
    ;==============
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
    ;======================
    ;在这里为自定义变量和标签建立关联
    String := RegExReplace(String, "i)<strNameNoTemplatePrefix>", strNameNoTemplatePrefix)
    ;======================

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

CustomFunction_FileTag_Manager()
{
    Global gFileTag
    gFileTag := {}
    Gui, FileTag: Destroy
    Gui, FileTag: Default
    Gui, FileTag: Font, s10, Microsoft YaHei
    Gui, FileTag: Add, TreeView, x10 y10 w180 h400 AltSubmit gCustomFunction_FileTag_Manager_Event
    Gui, FileTag: Add, Edit, x260 y10 w150 h26
    Gui, FileTag: Add, Edit, x260 y40 w250 h26
    Gui, fileTag: Show, w620 , 文件名加标签
    CustomFunction_FileTag_Manager_Sub(0, "Main")
}

CustomFunction_FileTag_Manager_Sub(aPID, aSec)
{
    Global gFileTag
    Loop
    {
        ErrorLevel := False
        strName := CustomFunction_FileTag_Read(aSec, A_Index)
        If ErrorLevel
            Break
        If RegExMatch(strName, "^\-$")
        {
            newID := TV_Add("-", aPID)
        }
        Else If RegExMatch(strName, "^[^\|]*\|\|")
        {
            newID := TV_Add(RegExReplace(strName,"\|\|.*$"), aPID)
            CustomFunction_FileTag_Manager_Sub(newID, RegExReplace(strName, "^.*\|\|"))
        }
        Else
        {
            newID := TV_Add(RegExReplace(strName,"\|.*$"), aPID)
        }
        gFileTag[newID] := strName
    }
}

CustomFunction_FileTag_Manager_Event()
{
    Global gFileTag
    If (A_GuiEvent = "Normal") && A_EventInfo
    {
        strName := gFileTag[A_EventInfo]
        GuiControl, , Edit1, % RegExReplace(strName,"\|.*$")
        GuiControl, , Edit2, % RegExReplace(strName,"^.*\|")
    }
}

CustomFunction_FileTag_Manager_Save()
{
}

CustomFunction_FileTag_Read(aSec, aKey:="")
{
    Global LineFileDir
    Config := LineFileDir "\FileTags.ini"
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

CustomFunction_FileTag_Write(aValue, aSec, aKey)
{
    Global LineFileDir
    Config := LineFileDir "\FileTags.ini"
    If FileExist(Config)
        IniWrite, aValue, %Config%, %aSec%, %aKey%
    Else
        Msgbox % Config " Not Exist !"
}
