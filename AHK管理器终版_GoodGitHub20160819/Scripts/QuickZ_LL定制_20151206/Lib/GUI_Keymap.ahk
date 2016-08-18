GUI_Keymap_Load(Callback, CloseEvent="")
{
    Global Keymap
    Keymap := new GUI2("Keymap", "+Lastfound +Theme -DPIScale")
    Keymap.UUID := ""
    Keymap.InsideCmd := {"<0>":QZLang.Num0
        ,"<1>":QZLang.Num1
        ,"<2>":QZLang.Num2
        ,"<3>":QZLang.Num3
        ,"<4>":QZLang.Num4
        ,"<5>":QZLang.Num5
        ,"<6>":QZLang.Num6
        ,"<7>":QZLang.Num7
        ,"<8>":QZLang.Num8
        ,"<9>":QZLang.Num9}
    Keymap.KeySuffix := {"<Super>":QZLang.KeySuper
        ,"<NoWait>":QZLang.KeyNowait
        ,"<NoMulti>":QZLang.KeyNoMulti}
        ;,"<AHK>":QZLang.KeyAHK}
    Keymap.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    TBName := Toolbar_Add(Keymap.hwnd, "GUI_Keymap_Event", "Flat Tooltips Menu", "1s", "x385 y36  h36 w200")
    TBCmd  := Toolbar_Add(Keymap.hwnd, "GUI_Keymap_Event", "Flat Tooltips Menu", "1s", "x385 y106 h36 w200")
    Keymap.ToolbarName := TBName
    Keymap.ToolbarCmd  := TBCmd
    Toolbar_Insert(TBName, QZLang.TextKeySuffix)
    Toolbar_Insert(TBName, QZLang.TextKeyHelp)
    Toolbar_Insert(TBCmd, QZLang.TextDefineCmd)
    Toolbar_Insert(TBCmd, QZLang.TextInsideCmd)
    Keymap.AddCtrl("GB_KeyName", "GroupBox", "x10 y10 h65 w520", QZLang.TextKeyName "(&N)") 
    Keymap.AddCtrl("Edit_Name", "Edit", "x20 y35 h26 w355")
    ;Keymap.AddCtrl("Button_help", "Button", "x450 y35 h26 w70", QZLang.ButtonHelp)
    Keymap.AddCtrl("GB_Action", "GroupBox", "x10 y80 h65 w520 ", QZLang.TextAction "(&F)") 
    Keymap.AddCtrl("Edit_Action", "Edit", "x20 y105 h26 w355 readonly")
    ;Keymap.AddCtrl("Button_NewAction", "Button", "x370 y105 h26 w70", QZLang.ButtonNew)
    ;Keymap.AddCtrl("Button_BrowseAction", "Button", "x450 y105 h26 w70", QZLang.ButtonBrowse)
    Keymap.AddCtrl("GB_KeyTips", "GroupBox", "x10 y150 h65 w520 ", QZLang.TextKeyTips "(&T)")
    Keymap.AddCtrl("Edit_KeyTips", "Edit", "x20 y175 h26 w500")
    Keymap.AddCtrl("CB_Disable", "CheckBox", "x15 y225 h26 ", QZLang.TextCBDisable3 "(&D)")
    Keymap.AddCtrl("ButtonOK", "Button", "x336 y225 h26 w90", QZLang.ButtonOK)
    Keymap.AddCtrl("ButtonClose", "Button", "x436 y225 h26 w90", QZLang.ButtonClose)
    Keymap.AddCtrl("ButtonAddAgain", "Button", "x216 y225 h26 w110", QZLang.ButtonAddAgain)
    Keymap.ButtonOK.SetIcon(QZGlobal.Defaulticl, 30)
    Keymap.ButtonAddAgain.SetIcon(QZGlobal.Defaulticl, 30)
    Keymap.ButtonOK.OnEvent(Callback)
    Keymap.ButtonAddAgain.OnEvent("GUI_Keymap_AddAgain")
    If Strlen(CloseEvent)
    {
        Keymap.ButtonClose.OnEvent(CloseEvent)
        Keymap.OnClose(CloseEvent)
    }
    Else
    {
        Keymap.ButtonClose.OnEvent("GUI_Keymap_Destroy")
    }
    Keymap.Button_NewAction.OnEvent("GUI_Keymap_AddItem")
    Keymap.Button_BrowseAction.OnEvent("GUI_Keymap_SelectItem")
    Keymap.Show("xcenter ",QZLang.AddKeymap)
    Return Keymap
}

GUI_Keymap_LoadData(objKey)
{
    Global Keymap, gQZConfig
    Keymap.Edit_Name.SetText(objKey.Key)
    strUUID := objKey.UUID
    Keymap.UUID := strUUID
    If RegExMatch(strUUID, "^<\d>$")
        Keymap.Edit_Action.SetText(strUUID)
    Else If IsObject(gQZConfig.Items[strUUID])
        Keymap.Edit_Action.SetText(gQZConfig.Items[strUUID].Name)
    Else
        Keympa.Edit_Action.SetText()
    Keymap.Edit_KeyTips.SetText(objKey.Tips)
    If objKey.Disable
        Keymap.CB_Disable.SetText(True)
    Else
        Keymap.CB_Disable.SetText(False)
}

GUI_Keymap_Dump()
{
    Global Keymap
    Return Keymap
}


GUI_Keymap_Save(ByRef objKey)
{
    Global Keymap
    objKey.Key := Keymap.Edit_Name.GetText() 
    objKey.UUID := Keymap.UUID
    objKey.Tips := Keymap.Edit_KeyTips.GetText()
    objKey.Disable := Keymap.CB_Disable.GetText()
}

GUI_Keymap_Destroy()
{
    Global Keymap
    Keymap.Destroy()
}

GUI_Keymap_Event(aCtrl, aEvent, aText, aPos)
{
    Global Keymap
    If (aEvent = "Menu")
    {
        iHwnd := Keymap.hwnd
        CoordMode, Menu, Screen
        WinGetPos, GuiX, GuiY, , ,  ahk_id %iHwnd%
        If (aText = QZLang.TextKeySuffix)
        {
            ControlGetPos, TBX, TBY, , , ToolbarWindow321, ahk_id %iHwnd%
            TBH := Toolbar_GetRect(Keymap.ToolbarName, "1", "h")
            PosX := GuiX + TBX
            PosY := GuiY + TBY + TBH
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, DeleteAll
            For Suffix , Value In Keymap.KeySuffix
                Menu, _TBCMDMenu, Add, % suffix " | " Value,  _KeymapMenu
            Menu, _TBCMDMenu, Show, %PosX%, %PosY%
        }
        If (aText = QZLang.TextKeyHelp)
        {
            ControlGetPos, TBX, TBY, , , ToolbarWindow321, ahk_id %iHwnd%
            TBH := Toolbar_GetRect(Keymap.ToolbarName, aPos, "h")
            TBW := Toolbar_GetRect(Keymap.ToolbarName, aPos, "w")
            PosX := GuiX + TBX + TBW
            PosY := GuiY + TBY + TBH
            objInfo := QZLang.Help_KeyName()
            objTT := TT("CloseButton", "", "")
            ObjTT.Show(objInfo.Text , PosX, PosY, objInfo.Title)
        }
        If (aText = QZLang.TextDefineCmd)
        {
            ControlGetPos, TBX, TBY, , , ToolbarWindow322, ahk_id %iHwnd%
            TBH := Toolbar_GetRect(Keymap.ToolbarCmd, "1", "h")
            PosX := GuiX + TBX
            PosY := GuiY + TBY + TBH
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, DeleteAll
            Menu, _TBCMDMenu, Add, % QZLang.ButtonBrowse, _KeymapMenu
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, Add, % QZLang.ButtonNew, _KeymapMenu
            Menu, _TBCMDMenu, Add, % QZLang.ButtonEdit,   _KeymapMenu
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, Add, % QZLang.ButtonClear1,  _KeymapMenu
            Menu, _TBCMDMenu, Show, %PosX%, %PosY%
        }
        If (aText = QZLang.TextInsideCmd)
        {
            ControlGetPos, TBX, TBY, , , ToolbarWindow322, ahk_id %iHwnd%
            TBH := Toolbar_GetRect(Keymap.ToolbarCmd, "2", "h")
            TBW := Toolbar_GetRect(Keymap.ToolbarCmd, "2", "W")
            PosX := GuiX + TBX + TBW
            PosY := GuiY + TBY + TBH
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, DeleteAll
            For Cmd, Value In Keymap.InsideCmd
                Menu, _TBCMDMenu, Add, % Cmd " | " Value,  _KeymapMenu
            Menu, _TBCMDMenu, Show, %PosX%, %PosY%
        }
        Return
        _KeymapMenu:
            KM := GUI_Keymap_Dump()
            If (A_ThisMenuItem = QZLang.ButtonBrowse)
                GUI_Keymap_SelectItem()
            If (A_ThisMenuItem = QZLang.ButtonNew)
                GUI_Keymap_AddItem()
            If (A_ThisMenuItem = QZLang.ButtonEdit)
                GUI_Keymap_EditItem()
            If (A_ThisMenuItem = QZLang.ButtonClear1)
                GUI_Keymap_ClearCmd()
            If Strlen(KM.InsideCmd[RegExReplace(A_ThisMenuItem, "\s\|\s.*$")])
                GUI_Keymap_InsideCmd(RegExReplace(A_ThisMenuItem, "\s\|\s.*$"))
        Return
    }
}

GUI_Keymap_ClearCmd()
{
    Global Keymap
    Keymap.Edit_Action.SetText("")
    Keymap.UUID := ""
}

GUI_Keymap_InsideCmd(aCmd)
{
    Global Keymap
    Keymap.Edit_Action.SetText(aCmd)
    Keymap.UUID := aCmd
}

GUI_Keymap_SelectItem()
{
    GUI_ItemSelector_Load("GUI_Keymap_SelectItemDo")
}

GUI_Keymap_SelectItemDo()
{
    Global Keymap, gQZConfig
    objGUI := GUI_ItemSelector_Dump()
    strUUID := objGUI.UUID
    Keymap.UUID := objGUI.UUID
    Keymap.Edit_Action.SetText(gQZConfig.Items[strUUID].Name)
    GUI_ItemSelector_Destroy()
}

GUI_Keymap_EditItem()
{
    Global Keymap, gQZConfig
    GUI_ItemEditor_Load("GUI_Keymap_EditItemDo", "GUI_ItemEditor_Destroy", gQZConfig.Items[Keymap.UUID].Options.CodeMode)
    Gui_ItemEditor_LoadData({"UUID":Keymap.UUID})
}

GUI_Keymap_EditItemDo()
{
    Global Keymap, gQZConfig
    objItem := gQZConfig.Items[Keymap.UUID]
    GUI_ItemEditor_Save(objItem)
    Keymap.Edit_Action.SetText(objItem.Name)
    GUI_ItemEditor_Destroy()
}

GUI_Keymap_AddAgain()
{
    Global Keymap, GuiMain
    If !Strlen(Keymap.Edit_Name.GetText())
    {
        Msgbox Please Input Key Name!
        Return
    }
    objMode := GuiMain.Data[GuiMain.Data.SelectID]
    objKey := QZ_CreateConfig_VimKey()
    GUI_Keymap_Save(objKey)
    If !IsObject(objMode.Maps)
        objMode.Maps := []
    objMode.Maps.Insert(objKey)
    GuiMain.KeyList.SetDefault()
    newID := LV_Add("", "","","","")
    Gui_Main_ListViewUpdata(ObjKey, newID, Option:="select")
    GUI_Save()
    Keymap.Edit_Name.SetText("")
    Keymap.Edit_Action.SetText("")
    Keymap.Edit_KeyTips.SetText("")
    Keymap.UUID := ""
}

GUI_Keymap_AddItem()
{
    GUI_ItemEditor_Load("GUI_Keymap_AddItemDo", "GUI_ItemEditor_Destroy")
}

GUI_Keymap_AddItemDo()
{
    Global Keymap, gQZConfig
    objItem := QZ_CreateConfig_Item()
    GUI_ItemEditor_Save(objItem)
    GUI_ItemEditor_Destroy()
    If Strlen(objItem.Name)
    {
        strUUID := UUIDCreate(1, "U")
        gQZConfig.Items[strUUID] := objItem
        Keymap.UUID := strUUID
        Keymap.Edit_Action.SetText(objItem.Name)
    }
}

/*
GUI_Keymap_AddItemEnd()
{
    GUI_ItemEditor_Destroy()
}
*/
