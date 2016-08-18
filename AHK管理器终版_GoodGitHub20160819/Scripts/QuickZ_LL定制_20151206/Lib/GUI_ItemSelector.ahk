GUI_ItemSelector_Load(Callback, CloseEvent:="")
{
    Global ItemSelector, gQZConfig
    TBListID := IL_Create(10, 10, 0)
    IL_Add(TBListID, A_WinDir "\System32\imageres.dll", 68)
    IL_Add(TBListID, A_WinDir "\System32\mspaint.exe", 1)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 248)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 247)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 160)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 47)
    ItemSelector := new GUI2("ItemSelector", "+Lastfound +Theme -DPIScale")
    ItemSelector.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    ItemSelector.AddCtrl("Text_Item", "Text",  "x12 y13 h26 w100", QZLang.TextCategory "(&T)")
    ItemSelector.AddCtrl("LS_Item", "ListBox",  "x10 y40 h420 w100 ")
    ItemSelector.AddCtrl("LV_Item", "ListView", "x120 y40 h263 w485 AltSubmit grid +Multi", QZLang.TextName2 "|" QZLang.TextUUID)
    ItemSelector.AddCtrl("LV_Path", "ListView", "x120 y310 h142 w485 AltSubmit grid +Multi", QZLang.TextType "|" QZLang.TextPath "|" QZLang.TextUUID)
    ItemSelector.AddCtrl("Text_Search", "Text", "x65 y462 h26 ", QZLang.ButtonSearch)
    ItemSelector.AddCtrl("Edit_Search", "Edit", "x120 y460 h26 w160")
    ItemSelector.AddCtrl("ButtonOK", "Button", "x416 y460 h26 w90", QZLang.ButtonSelect)
    ItemSelector.AddCtrl("ButtonClose", "Button", "x516 y460 h26 w90", QZLang.ButtonClose)
    ItemSelector.LS_Item.OnEvent("GUI_ItemSelector_LSEvent")
    ItemSelector.LV_Item.OnEvent("GUI_ItemSelector_TreeEvent")
    ItemSelector.Edit_Search.OnEvent("GUI_ItemSelector_SearchEvent")
    ItemSelector.ButtonOK.SetIcon(QZGlobal.Defaulticl, 30)
    ItemSelector.ButtonOK.OnEvent("GUI_ItemSelector_SelectDo")
    ItemSelector.Callback := Callback
    ItemSelector.ButtonClose.OnEvent("GUI_ItemSelector_Destroy")
    ItemSelector.Show("xcenter ",QZLang.ItemSelector)
    TBCtrl := Toolbar_Add(ItemSelector.hwnd, "GUI_ItemSelector_TBEvent", "Tooltips Menu", "1S", "x120 y10 h36 w380")
    Toolbar_Insert(TBCtrl, QZLang.TB_AddItem ", 1, ,")
    Toolbar_Insert(TBCtrl, QZLang.TB_ModifyItem ", 2, ,")
    Toolbar_Insert(TBCtrl, QZLang.TB_DeleteItem ", 3, ,")
    ;Toolbar_Insert(TBCtrl, "-")
    ;Toolbar_Insert(TBCtrl, QZLang.TB_Check ", 4, ,")
    ;Toolbar_Insert(TBCtrl, QZLang.TB_Import ", 5, ,")
    Toolbar_SetButtonSize(TBCtrl, 24)
    Toolbar_SetDrawTextFlags(TBCtrl, 3, 2)
    ItemSelector.UUID := ""
    ItemSelector.Data := {}
    ItemSelector.CategoryList := {}
    ItemSelector.Callback := Callback
    ItemSelector.LS_Item.SetText(QZLang.TextAll)
    ItemSelector.CategoryList[QZLang.TextAll] := True
    CL := gQZConfig.Setting.Global.CategoryList
    Loop, Parse, CL, `n
        If Strlen(A_LoopField)
        {
            ItemSelector.LS_Item.SetText(A_LoopField)
            ItemSelector.CategoryList[A_LoopField] := True
        }
    LV_ModifyCol(1, 390)
    LV_ModifyCol(2, "200 nosort")
    ItemSelector.LV_Path.SetDefault()
    LV_ModifyCol(1, "50 center")
    LV_ModifyCol(2, 450)
    LV_ModifyCol(3, "200 nosort")
    ;SetExplorerTheme(ItemSelector.TV_Item.hwnd) 
    GUI_ItemSelector_LoadData()
    Return ItemSelector
}

GUI_ItemSelector_LoadData(aCategory:="", aKeyword:="", IsSearch:=False)
{
    Global ItemSelector, gQZConfig
    ItemSelector.LV_Item.SetDefault()
    LV_Delete()
    For strUUID, objItem IN gQZConfig.Items
    {
        If Strlen(objItem.Options.Category) && !IsSearch
        {
            If !ItemSelector.CategoryList[objItem.Options.Category]
            {
                ItemSelector.LS_Item.SetText(objItem.Options.Category)
                ItemSelector.CategoryList[objItem.Options.Category] := True
            }
        }
        If !(objItem.Options.Category = aCategory) && Strlen(aCategory)
            Continue
        If !TCMatch(objItem.Name, aKeyword) && Strlen(aKeyword)
            Continue
        ;newID := ;TV_Add(objItem.Name)
        LV_Add("", objItem.Name, strUUID)
    }
    LV_ModifyCol(1, "sort")
}

GUI_ItemSelector_Dump()
{
    Global ItemSelector
    Return ItemSelector
}

GUI_ItemSelector_Save(ByRef objKey)
{
    Global ItemSelector
    objKey.Key := ItemSelector.Edit_Name.GetText() 
    objKey.UUID := ItemSelector.UUID
    objKey.Tips := ItemSelector.Edit_KeyTips.GetText()
    objKey.Disable := ItemSelector.CB_Disable.GetText()
}

GUI_ItemSelector_Destroy()
{
    Global ItemSelector
    ItemSelector.Destroy()
}

GUI_ItemSelector_TBEvent(aCtrl, aEvent, aText, aPos)
{
    If (aEvent = "Menu")
    {
        If (aText = QZLang.TB_Check)
            GUI_ItemSelector_Check()
        If (aText = QZLang.TB_ModifyItem)
            GUI_ItemSelector_Modify()
        If (aText = QZLang.TB_DeleteItem)
            GUI_ItemSelector_Delete()
        If (aText = QZLang.TB_AddItem)
            GUI_ItemSelector_Add()
    }
}

GUI_ItemSelector_TreeEvent()
{
    Global ItemSelector, gQZConfig
    ItemSelector.LV_Item.SetDefault()
    If (A_GuiEvent = "Normal")
    {
        LV_GetText(strUUID, A_EventInfo, 2)
        ItemSelector.UUID := strUUID
        ItemSelector.LV_Path.SetDefault()
        LV_Delete()
        GUI_ItemSelector_FindMenuZ(gQZConfig.MenuZ)
        GUI_ItemSelector_FindVIMD()
    }
    If (A_GuiEvent = "DoubleClick")
    {
        LV_GetText(strUUID, A_EventInfo, 2)
        ItemSelector.UUID := strUUID
        GUI_ItemSelector_SelectDo()
        ;LV_GetText(strUUID, A_EventInfo, 2)
    }
    If (A_GuiEvent = "RightClick")
    {
        LV_GetText(strUUID, A_EventInfo, 2)
        ItemSelector.UUID := strUUID
        TV_Modify(A_EventInfo, "+Select")
        GUI_ItemSelector_Modify()
    }
}

GUI_ItemSelector_FindVIMD()
{
    Global ItemSelector, gQZConfig
    Loop % gQZConfig.VIMD.MaxIndex()
    {
        ;Msgbox % gQZConfig.VIMD[A_Index].Name
        ObjWin := gQZConfig.VIMD[A_Index]
        WinName := "\" ObjWin.Name
        Loop % ObjWin.Modes.MaxIndex()
        {
            ObjMode := ObjWin.Modes[A_Index]
            ModeName := WinName "\" ObjMode.Name
            Loop % ObjMode.Maps.MaxIndex()
            {
                ObjKey := ObjMode.Maps[A_Index]
                KeyName := ModeName "\" ObjKey.Key
                If (ObjKey.UUID = ItemSelector.UUID)
                    LV_Add("", QZLang.TextKey, KeyName, "")
            }
        }
    }
}

GUI_ItemSelector_FindMenuZ(aObj, Step:="")
{
    Global ItemSelector, gQZConfig
    strUUID := ItemSelector.UUID
    Loop % aObj.MaxIndex()
    {
        objSub := aObj[A_Index]
        Name := Step "\" gQZConfig.Items[objSub.UUID].Name
        If (objSub.UUID = strUUID)
        {
            LV_Add("", QZLang.TextMenu, Name, objSub.ID)
        }
        If IsObject(objSub.SubItem)
            GUI_ItemSelector_FindMenuZ(objSub.SubItem, Name)
    }
}

GUI_ItemSelector_SelectDo()
{
    Global ItemSelector
    ItemSelector.LV_Item.SetDefault()
    Line := LV_GetNext(0, "F")
    LV_GetText(strUUID, Line, 2)
    ItemSelector.UUID := strUUID
    _Func := ItemSelector.Callback
    %_Func%()
}

GUI_ItemSelector_LSEvent()
{
    Global ItemSelector
    SetTimer, GUI_ItemSelector_SearchDo, -1
}


GUI_ItemSelector_SearchEvent()
{
    Global ItemSelector
    SetTimer, GUI_ItemSelector_SearchDo, -1
}

GUI_ItemSelector_SearchDo()
{
    Global ItemSelector
    ItemSelector.LV_Item.SetDefault()
    strCategory := ItemSelector.LS_Item.GetChoose()
    strKeyword  := ItemSelector.Edit_Search.GetText()
    If (strCategory = QZLang.TextAll)
        strCategory := ""
    GUI_ItemSelector_LoadData(strCategory, strKeyword, IsSearch:=True)
}

GUI_ItemSelector_Add()
{
    Global ItemSelector, gQZConfig
    ItemSelector.LV_Item.SetDefault()
    ItemSelector.LV_Item.Disable()
    ItemSelector.LS_Item.Disable()
    ItemSelector.Edit_Search.Disable()
    ItemSelector.ButtonOK.Disable()
    ItemSelector.ButtonClose.Disable()
    Control, Disable, ,ToolbarWindow321, % "ahk_id " ItemSelector.Hwnd
    GUI_ItemEditor_Load("GUI_ItemSelector_AddDo","GUI_ItemSelector_ModifyEnd", objItem.Options.CodeMode)
}

GUI_ItemSelector_AddDo()
{
    Global ItemSelector, gQZConfig
    ItemSelector.LV_Item.SetDefault()
    strUUID := UUIDCreate(1, "U")
    objItem := QZ_CreateConfig_Item()
    gQZConfig.Items[strUUID] := objItem
    objGUI := GUI_ItemEditor_Dump()
    If objGUI.CodeMode
        GUI_ItemEditorCode_Save(objItem)
    Else
        GUI_ItemEditor_Save(objItem)
    ItemSelector.Default()
    ItemSelector.LV_Item.SetDefault()
    ;newID := TV_Add(objItem.Name, 0, "Select")
    ;ItemSelector.Data[newID] := strUUID
    LV_Add("select focus", objItem.Name, strUUID)
    LV_ModifyCol(1, "sort")
    Line := LV_GetNext(0, "F")
    LV_Modify(Line, "vis")
    GUI_ItemSelector_ModifyEnd()
    GUI_Save()
}


GUI_ItemSelector_Modify()
{
    Global ItemSelector, gQZConfig
    ItemSelector.Default()
    ItemSelector.LV_Item.SetDefault()
    Line := LV_GetNext(0, "F")
    LV_GetText(strUUID, Line, 2)
    ;strUUID := ItemSelector.Data[TV_GetSelection()]
    If Strlen(strUUID)
    {
        Control, Disable, ,ToolbarWindow321, % "ahk_id " ItemSelector.Hwnd
        ItemSelector.LV_Item.Disable()
        ItemSelector.LS_Item.Disable()
        ItemSelector.Edit_Search.Disable()
        ItemSelector.ButtonOK.Disable()
        ItemSelector.ButtonClose.Disable()
        objItem := gQZConfig.Items[strUUID]
        GUI_ItemEditor_Load("GUI_ItemSelector_ModifyDo","GUI_ItemSelector_ModifyEnd", objItem.Options.CodeMode)
        GUI_ItemEditor_LoadData({UUID:strUUID})
    }
}

GUI_ItemSelector_ModifyDo()
{
    Global ItemSelector, gQZConfig
    ItemSelector.Default()
    ItemSelector.LV_Item.SetDefault()
    strUUID := ItemSelector.UUID
    objItem := gQZConfig.Items[strUUID]
    objGUI := GUI_ItemEditor_Dump()
    If objGUI.CodeMode
        GUI_ItemEditorCode_Save(objItem)
    Else
        GUI_ItemEditor_Save(objItem)
    ItemSelector.Default()
    ItemSelector.LV_Item.SetDefault()
    Line := LV_GetNext(0, "F")
    LV_Modify(Line, "vis", objItem.Name, strUUID)
    ;newID := TV_Modify(TV_GetSelection(), "Select", objItem.Name)
    ;ItemSelector.Data[newID] := strUUID
    GUI_ItemSelector_ModifyEnd()
    GUI_Save()
}

GUI_ItemSelector_ModifyEnd()
{
    Global ItemSelector
    ItemSelector.LV_Item.SetDefault()
    ItemSelector.LV_Item.Enable()
    ItemSelector.LS_Item.Enable()
    ItemSelector.Edit_Search.Enable()
    ItemSelector.ButtonOK.Enable()
    ItemSelector.ButtonClose.Enable()
    Control, Enable, ,ToolbarWindow321, % "ahk_id " ItemSelector.Hwnd
    GUI_ItemEditor_Destroy()
}

GUI_ItemSelector_Delete()
{
    Global ItemSelector, gQZConfig
    ItemSelector.Default()
    ItemSelector.LV_Item.SetDefault()
    arrDelete := []
    Line := 0
    Loop
    {
        Line := LV_GetNext(Line)
        If !Line
            Break
        arrDelete[A_Index] := Line
    }
    Max := arrDelete.MaxIndex()
    Loop % Max
    {
        Line := arrDelete[Max-A_Index+1]
        LV_GetText(strUUID, Line, 2)
        If Strlen(strUUID)
        {
            Msgbox, 4, Confirm, % "Confirm to delete " gQZConfig.Items[strUUID].Name "?"
            IfMsgBox, Yes
            {
                gQZConfig.Items.Delete(strUUID)
                ;TV_Delete(TV_GetSelection())
                LV_Delete(Line)
            }
        }
    }
    GUI_Save()
}

GUI_ItemSelector_Check()
{
    Global gQZConfig
    ItemSelector.LV_Item.SetDefault()
    For strUUID, objItem IN gQZConfig.Items
    {
        If !Strlen(objItem.Command objItem.Param objItem.Code) && !objItem.Options.IsGroup
            gQZConfig.Items.Delete(strUUID)
    }
    GUI_ItemSelector_LoadData()
    GUI_Save()
}
