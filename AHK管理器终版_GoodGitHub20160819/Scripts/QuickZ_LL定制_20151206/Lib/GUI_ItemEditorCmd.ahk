

GUI_ItemEditorCmd_load(aHandle)
{
    Global gItemEditorCmd
    gItemEditorCmd := New GUI2("IEditorCmd", "+LastFound +Theme -Resize -DPIScale", QZLang.TextChangeCmd)
    gItemEditorCmd.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    gItemEditorCmd.AddCtrl("Text_Category", "Text", "x10 y7", QZLang.TextCategory)
    gItemEditorCmd.AddCtrl("Text_Command", "Text", "x120 y7", QZLang.TextCommandList)
    gItemEditorCmd.AddCtrl("TextDoubleClick", "Text", "x550 y7 h26", QZLang.TextDoubleClick)
    gItemEditorCmd.AddCtrl("LS_Category", "ListBox", "w100 h390 x10 y34 altsubmit +Multi")
    gItemEditorCmd.AddCtrl("LV_Command",  "ListView", "x120 y34 w560 h384 grid", QZLang.TextCmdTitle)
    gItemEditorCmd.AddCtrl("Text_Search", "Text", "x70 y428", QZLang.ButtonSearch)
    gItemEditorCmd.AddCtrl("Edit_Search", "Edit", "x120 y425 w200 h28")
    gItemEditorCmd.AddCtrl("Button_Select", "Button", "x490 y425 w90 h28", QZLang.ButtonSelect)
    gItemEditorCmd.AddCtrl("Button_Close", "Button", "x590 y425 w90 h28", QZLang.ButtonClose)
    gItemEditorCmd.LS_Category.SetText(QZLang.TextAll)
    gItemEditorCmd.LS_Category.SetText(QZLang.TextUserActions)
    gItemEditorCmd.LS_Category.SetText(QZLang.TextInsideCmds)
    gItemEditorCmd.LS_Category.SetText(QZLang.TextCtrlPanels)
    gItemEditorCmd.LS_Category.SetText(QZLang.TextSystemCmds)
    gItemEditorCmd.LS_Category.SetText(QZLang.TextSystemDirs)
    gItemEditorCmd.LS_Category.SetText(QZLang.TextUtilities)
    gItemEditorCmd.LS_Category.SetText(QZLang.TextShellPaths)
    ;gItemEditorCmd.LS_Category.SetText(QZLang.TextExistMenus)
    gItemEditorCmd.LS_Category.OnEvent("GUI_ItemEditorCmd_Category")
    gItemEditorCmd.LV_Command.OnEvent("GUI_ItemEditorCmd_Command")
    gItemEditorCmd.Edit_Search.OnEvent("GUI_ItemEditorCmd_Search")
    gItemEditorCmd.Button_Select.OnEvent("GUI_ItemEditorCmd_ButtonSelect")
    gItemEditorCmd.Button_Close.OnEvent("GUI_ItemEditorCmd_ButtonClose")
    gItemEditorCmd.OnClose(aHandle)
    gItemEditorCmd.Show()
    LV_ModifyCol(1, 150)
    LV_ModifyCol(2, 250)
    LV_ModifyCol(3, 500)
}

GUI_ItemEditorCmd_Dump()
{
    Global gItemEditorCmd
    Return gItemEditorCmd
}

GUI_ItemEditorCmd_Command()
{
    Global gItemEditorCmd
    If (A_GuiEvent = "DoubleClick") && A_EventInfo
    {
        gItemEditorCmd.Default()
        LV_GetText(txtName, A_EventInfo, 1)
        LV_GetText(txtCmd, A_EventInfo, 2)
        LV_GetText(txtParam, A_EventInfo, 3)
        gItemEditorCmd.Data := {Event:"Select",Name:txtName,Command:txtCmd,Param:txtParam}
        gItemEditorCmd.Close()
    }
}

GUI_ItemEditorCmd_ButtonSelect()
{
    Global gItemEditorCmd
    gItemEditorCmd.Default()
    ID := LV_GetNext()
    If ID
    {
        LV_GetText(txtName, ID, 1)
        LV_GetText(txtCmd, ID, 2)
        LV_GetText(txtParam, ID, 3)
        gItemEditorCmd.Data := {Event:"Select",Name:txtName,Command:txtCmd,Param:txtParam}
        gItemEditorCmd.Close()
    }
}

GUI_ItemEditorCmd_ButtonClose()
{
    Global gItemEditorCmd
    gItemEditorCmd.Close()
}

GUI_ItemEditorCmd_Category(aLoad:=False)
{
    Global gCommandJson, gItemEditorCmd
    Static CategoryPos := {1:"All",2: "UserActions",3: "InsertCmds",4: "CtrlPanels",5: "SystemCmds"
                          ,6: "SystemDirs",7: "Utilities",8: "ShellPaths",9: "ExistMenus"}
    If ( A_GuiEvent = "Normal") || aLoad
    {
        gItemEditorCmd.Default()
        LV_Delete()
        SelectID := gItemEditorCmd.LS_Category.GetChoose()
        If InStr(SelectID, 1)
            SelectID := "1|2|3|4|5|6|7|8|9"
        Loop, Parse, SelectID, |
        {
            If (A_LoopField = 2)
                GUI_ItemEditorCmd_LVAddPlugin()
            ;Else If (A_LoopField = 9)
                ;GUI_ItemEditorCmd_LVAddExist()
            Else
                GUI_ItemEditorCmd_LVAdd(gCommandJson[CategoryPos[A_LoopField]])
        }
    }
}

GUI_ItemEditorCmd_LVAdd(objList)
{
    Global gItemEditorCmd
    txtMatch := gItemEditorCmd.Edit_Search.GetText()
    Loop, % ObjList.MaxIndex()
    {
        objCmd := ObjList[A_Index]
        txtName := Strlen(objCmd.Name_cn) ? objCmd.Name_cn : objCmd.Name
        If TCMatch(txtName . A_Space . objCmd.Command . A_Space . objCmd.Param, txtMatch)
            LV_Add("", txtName, objCmd.Command, objCmd.Param)
    }
}

GUI_ItemEditorCmd_LVAddPlugin()
{
    Global gItemEditorCmd, gQZConfig
    txtMatch := gItemEditorCmd.Edit_Search.GetText()
    Loop , % QZGlobal.PluginDir "*.ahk", 1, 1
    {
        objPlugin := GetPluginInfo(A_LoopFileFullPath)
        If IsObject(objPlugin)
        {
            Loop, 99
            {
                name := objPlugin["Name" A_Index]
                Command := objPlugin["Command" A_Index]
                Param := objPlugin["Param" A_Index]
                If !Strlen(name)
                    Break
                If (!Strlen(Command) && !Strlen(Param))
                    Continue
                If TCMatch(Name . A_Space . Command . A_Space . Param, txtMatch)
                   ;&& ( Strlen(objPlugin.Command) || Strlen(objPlugin.Param) )
                    LV_Add("", Name , Command, Param)
            }
        }
    }
}

GUI_ItemEditorCmd_LVAddExist()
{
    Global gItemEditorCmd, gQZConfig
    txtMatch := gItemEditorCmd.Edit_Search.GetText()
    For UUID, objCmd In gQZConfig.Items
    {
        If (!Strlen(objCmd.Command) && !Strlen(objCmd.Param))
            Continue
        If TCMatch(objCmd.Name . A_Space . objCmd.Command . A_Space . objCmd.Param, txtMatch)
            LV_Add("", objCmd.Name, objCmd.Command, objCmd.Param)
    }
}

GUI_ItemEditorCmd_Search()
{
    Global gItemEditorCmd, gCommandJson
    gItemEditorCmd.Default()
    Settimer, _ItemEditorCmd_Search, -200
    Return
    _ItemEditorCmd_Search:
        CategoryPos := {1:"All",2: "UserActions",3: "InsertCmds",4: "CtrlPanels",5: "SystemCmds"
                          ,6: "SystemDirs",7: "Utilities",8: "ShellPaths",9: "ExistMenus"}
        objGui := GUI_ItemEditorCmd_Dump()
        SelectID := gItemEditorCmd.LS_Category.GetChoose()
        LV_Delete()
        If InStr(SelectID, 1)
            SelectID := "1|2|3|4|5|6|7|8|9"
        Loop, Parse, SelectID, |
        {
            If (A_LoopField = 9)
                GUI_ItemEditorCmd_LVAddExist()
            else If (A_LoopField = 2)
                GUI_ItemEditorCmd_LVAddPlugin()
            Else
                GUI_ItemEditorCmd_LVAdd(gCommandJson[CategoryPos[A_LoopField]])
        }
    Return
}
