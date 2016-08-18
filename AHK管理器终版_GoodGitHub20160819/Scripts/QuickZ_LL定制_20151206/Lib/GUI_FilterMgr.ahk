GUI_FilterMgr_Load(Callback, CloseEvent:="")
{
    Global FilterMgr, gQZConfig
    TBListID := IL_Create(10, 10, 0)
    IL_Add(TBListID, A_WinDir "\System32\imageres.dll", 68)
    IL_Add(TBListID, A_WinDir "\System32\mspaint.exe", 1)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 248)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 247)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 160)
    
    FilterMgr := New GUI2("FilterMgr", "+LastFound +Theme -DPIScale")
    FilterMgr.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    FilterMgr.AddCtrl("Text_ExistFilter", "Groupbox", "x360 y10 w350 h365", QZLang.TextExistFilter)
    FilterMgr.AddCtrl("TV_ExistFilter", "TreeView", "x370 y35 w230 h300 altsubmit -Lines +0x1000")
    FilterMgr.AddCtrl("Text_Search", "Text", "x370 y344 ", QZLang.ButtonSearch)
    FilterMgr.AddCtrl("Edit_Search", "Edit", "x420 y342 w180 ")
    FilterMgr.AddCtrl("Text_FilteListr", "Groupbox", "x5 y10 w345 h330 ", QZLang.TextFilterList)
    FilterMgr.AddCtrl("TV_FilterList", "TreeView", "x10 y35 w228 h300 altsubmit -Lines +0x1000")
    FilterMgr.AddCtrl("Btn_New", "Button", "x250 y35 w90 h26", QZLang.ButtonNew)
    FilterMgr.AddCtrl("Btn_Modify", "Button", "x250 y70 w90 h26", QZLang.ButtonModify)
    FilterMgr.AddCtrl("Btn_Remove", "Button", "x250 y115 w90 h26", QZLang.ButtonRemove)
    FilterMgr.AddCtrl("Btn_Add", "Button", "x250 y150 w90 h26", QZLang.ButtonAddTo)
    FilterMgr.AddCtrl("Btn_More", "Button", "x250 y195 w90 h26", QZLang.ButtonMore)
    FilterMgr.AddCtrl("Radio_Logic", "Text", "x250 y255 w90 h26 ", QZLang.FilterLogic)
    FilterMgr.AddCtrl("Radio_LogicAnd", "Radio", "x262 y280 w80 h26", QZLang.FilterLogicAnd)
    FilterMgr.AddCtrl("Radio_LogicOr" , "Radio", "x262 y310 w80 h26", QZLang.FilterLogicOr)
    FilterMgr.AddCtrl("Btn_Copy", "Button", "x610 y35 w90 h26", QZLang.ButtonCopy)
    FilterMgr.AddCtrl("Btn_DeleteForce", "Button", "x610 y70 w90 h40", QZLang.ButtonDeleteForce)
    FilterMgr.AddCtrl("TextFilterType", "Text", "x610 y315 w90 h26 ", QZLang.TextFilterType)
    Types := ["All", "FileExt", "WinClass", "TextRegex", "keyword", "Function", "FileMulti"
             , "FileName", "FileDir", "WinExe", "WinTitle", "WinControl"]
    Name :=  ""
    Loop, % Types.MaxIndex()
        Name .= QZLang["Filter" Types[A_Index]] "|"
    FilterMgr.AddCtrl("DDL_Type" , "DDL", "x610 y342 w90 h26 r12 choose1 altSubmit", Name)
    FilterMgr.AddCtrl("Btn_OK", "Button", "x50 y345 w90 h26", QZLang.ButtonOK)
    FilterMgr.AddCtrl("Btn_Close", "Button", "x150 y345 w90 h26", QZLang.ButtonClose)
    SetExplorerTheme(FilterMgr.TV_ExistFilter.Hwnd)
    SetExplorerTheme(FilterMgr.TV_FilterList.Hwnd)
    FilterMgr.TV_ExistFilter.OnEvent("GUI_FilterMgr_EventEF")
    FilterMgr.TV_FilterList.OnEvent("GUI_FilterMgr_EventFL")
    FilterMgr.BTN_Add.Disable()
    FilterMgr.BTN_Add.OnEvent("GUI_FilterMgr_BTNAdd")
    FilterMgr.BTN_Remove.OnEvent("GUI_FilterMgr_BTNRemove")
    FilterMgr.BTN_New.OnEvent("GUI_FilterMgr_BTNNew")
    FilterMgr.BTN_Modify.OnEvent("GUI_FilterMgr_BTNModify")
    FilterMgr.BTN_More.OnEvent("GUI_FIlterMgr_More")
    FilterMgr.BTN_Copy.OnEvent("GUI_FIlterMgr_BTNCopy")
    FilterMgr.BTN_DeleteForce.OnEvent("GUI_FilterMgr_BTNDelete")
    FilterMgr.DDL_Type.OnEvent("GUI_FilterMgr_Search")
    FilterMgr.Btn_OK.SetIcon(A_WinDir "\System32\shell32.dll", 302)
    FilterMgr.BTN_OK.OnEvent(Callback)
    If Strlen(CloseEvent)
    {
        FilterMgr.OnClose(CloseEvent)
        FilterMgr.BTN_Close.OnEvent(CloseEvent)
    }
    Else
    {
        FilterMgr.BTN_Close.OnEvent("GUI_FilterMgr_Destroy")
    }
    FilterMgr.Edit_Search.OnEvent("GUI_FilterMgr_Search")
    FilterMgr.DataEF := {} ; 配置中已有的筛选器列表
    FilterMgr.DataFL := {} ; 使用的筛选器列表
    FilterMgr.UUIDListFL := {} ; 保存已有列表的UUID列表
    FilterMgr.DataMenu := "" ; 保存当前编辑的菜单项对象
    FilterMgr.Types := Types ; 筛选器类型对象，用于搜索
    If gQZConfig.Setting.Global.FilterMore
        FilterMgr.Show("", QZLang.TitleFilterMgr)
    Else
        FilterMgr.Show("w356 h380", QZLang.TitleFilterMgr)
    FilterMgr.TV_FilterList.Focus()
}

GUI_FilterMgr_LoadData(objMenu)
{
    Global FilterMgr, gQZConfig
    FilterMgr.DataMenu := objMenu
    GUI_FilterMgr_Add(FilterMgr.TV_FilterList, objMenu.Filter)
    For uuid , objFilter In gQZConfig.Filters
    {
        If FilterMgr.UUIDListFL[uuid]
            Continue
        GUI_FilterMgr_Add(FilterMgr.TV_ExistFilter, {1:uuid})
    }
    If objMenu.Options.FilterLogic
        FilterMgr.Radio_LogicOr.SetText(True)
    Else
        FilterMgr.Radio_LogicAnd.SetText(True)
    FilterMgr.TV_FilterList.SetDefault()
}

GUI_FilterMgr_Save(ByRef aMenu)
{
    Global FilterMgr
    objFilter := [], Index := 1
    For id , UUID In FilterMgr.DataFL
        ObjFilter[Index++] := UUID
    aMenu.Filter := objFilter
    aMenu.Options.FilterLogic := FilterMgr.Radio_LogicOr.GetText()
}

GUI_FilterMgr_Dump()
{
    Global FilterMgr
    Return FilterMgr
}

GUI_FilterMgr_Destroy()
{
    Global FilterMgr
    FilterMgr.Destroy()
}

GUI_FilterMgr_More()
{
    Global FilterMgr
    FilterMgr.BTN_More.SetText(QZLang.ButtonLess)
    FilterMgr.BTN_More.OnEvent("GUI_FIlterMgr_Less")
    FilterMgr.BTN_Add.Enable()
    FilterMgr.Move("","",720,"")
}

GUI_FIlterMgr_Less()
{
    Global FilterMgr
    FilterMgr.BTN_More.SetText(QZLang.ButtonMore)
    FilterMgr.BTN_More.OnEvent("GUI_FIlterMgr_More")
    FilterMgr.BTN_Add.Disable()
    FilterMgr.Move("","",362,"")
}

GUI_FilterMgr_EventEF()
{
    Global FilterMgr, FilterEditor
    FilterMgr.TV_ExistFilter.SetDefault()
    If A_EventInfo
    {
        If WinExist("ahk_id " FilterEditor.Hwnd)
            Return
        FilterMgr.FocusEF := True
        TV_Modify(A_EventInfo, "Select")
        If (A_GuiEvent = "DoubleClick") 
        {
            UUID := FilterMgr.DataEF[A_EventInfo]
            FilterMgr.DataEF.Delete(A_EventInfo)
            TV_Delete(A_EventInfo)
            GUI_FilterMgr_Add(FilterMgr.TV_FilterList, {1:uuid})
        }
        If (A_GuiEvent = "RightClick")
            GUI_FilterMgr_BTNModify()
    }
}

GUI_FilterMgr_EventFL()
{
    Global FilterMgr, FilterEditor
    FilterMgr.TV_FilterList.SetDefault()
    If A_EventInfo
    {
        If WinExist("ahk_id " FilterEditor.Hwnd)
            Return
        FilterMgr.FocusEF := False
        TV_Modify(A_EventInfo, "Select")
        If (A_GuiEvent = "DoubleClick") && (FilterMgr.BTN_More.GetText() = QZLang.ButtonLess)
        {
            UUID := FilterMgr.DataFL[A_EventInfo]
            FilterMgr.DataFL.Delete(A_EventInfo)
            TV_Delete(A_EventInfo)
            GUI_FilterMgr_Add(FilterMgr.TV_ExistFilter, {1:UUID})
        }
        If (A_GuiEvent = "RightClick")
            GUI_FilterMgr_BTNModify()
    }
}

GUI_FilterMgr_BTNNew()
{
    Gui_FilterEditor_Load("GUI_FilterMgr_BTNNewDo")
}

GUI_FilterMgr_BTNNewDo()
{
    Global FilterMgr, gQZConfig

    objFilter := QZ_CreateConfig_Filter()
    GUI_FilterEditor_Save(objFilter)
    GUI_FilterEditor_Destroy()

    strUUID := UUIDCreate(1, "U")
    gQZConfig.Filters[strUUID] := objFilter ; 保存到filters
    objMenu := FilterMgr.DataMenu
    If !(Index:=objMenu.Filter.MaxIndex())
        Index := 0
    objMenu.Filter[Index+1] := strUUID ; 保存到objMenu中的filter
    GUI_FilterMgr_Add(FilterMgr.TV_FilterList, {1:strUUID})
}

GUI_FilterMgr_BTNModify()
{
    Global FilterMgr
    If FilterMgr.FocusEF
    {
        ObjTV := FilterMgr.TV_ExistFilter
        objData := FilterMgr.DataEF
    }
    Else
    {
        ObjTV := FilterMgr.TV_FilterList
        objData := FilterMgr.DataFL
    }
    ObjTV.SetDefault()
    SelectID := TV_GetSelection()
    If SelectID
    {
        GUI_FilterEditor_Load("GUI_FilterMgr_BTNModifyOK")
        GUI_FilterEditor_LoadData(objData[SelectID])
    }
}

GUI_FilterMgr_BTNModifyOK()
{
    Global FilterMgr, gQZConfig
    If FilterMgr.FocusEF
    {
        ObjTV := FilterMgr.TV_ExistFilter
        objData := FilterMgr.DataEF
    }
    ElsE
    {
        ObjTV := FilterMgr.TV_FilterList
        objData := FilterMgr.DataFL
    }
    objTV.SetDefault()
    SelectID := TV_GetSelection()
    If SelectID
    {
        UUID := objData[SelectID]
        obj := gQZConfig.Filters[UUID].Clone()
        GUI_FilterEditor_Save(obj)
        gQZConfig.Filters[UUID] := obj
    }
    objTV.SetDefault()
    TV_Modify(SelectID, "", obj.Name)
    GUI_FilterEditor_Destroy()
}

GUI_FilterMgr_BTNDelete()
{
    Global FilterMgr, gQZConfig
    filterMgr.TV_ExistFilter.SetDefault()
    SelectID := TV_GetSelection()
    If SelectID
    {
        gQZConfig.Filters.Delete(FilterMgr.DataEF[SelectID])
        FilterMgr.DataEF.Delete(SelectID)
        TV_Delete(SelectID)
    }
}

GUI_FilterMgr_BTNAdd()
{
    Global FilterMgr
    FilterMgr.TV_ExistFilter.SetDefault()
    SelectID := TV_GetSelection()
    If !SelectID
        SelectID := TV_GetChild(0)
    If SelectID
    {
        UUID := FilterMgr.DataEF[SelectID]
        FilterMgr.DataEF.Delete(SelectID)
        TV_Delete(SelectID)
        GUI_FilterMgr_Add(FilterMgr.TV_FilterList, {1:UUID})
    }
}

GUI_FilterMgr_BTNRemove()
{
    Global FilterMgr
    FilterMgr.TV_FilterList.SetDefault()
    SelectID := TV_GetSelection()
    If !SelectID
        SelectID := TV_GetChild(0)
    If SelectID
    {
        UUID := FilterMgr.DataFL[SelectID]
        FilterMgr.DataFL.Delete(SelectID)
        TV_Delete(SelectID)
        GUI_FilterMgr_Add(FilterMgr.TV_ExistFilter, {1:UUID})
    }
}

GUI_FilterMgr_BTNCopy()
{
    Global FilterMgr, gQZConfig
    filterMgr.TV_ExistFilter.SetDefault()
    SelectID := TV_GetSelection()
    If SelectID
    {
        oldFilter := gQZConfig.Filters[FilterMgr.DataEF[SelectID]]
        newFilter := ObjectCopy(oldFilter)
        newFilter.Name := newFilter.Name . QZLang.SuffixCopy
        strUUID := UUIDCreate(1, "U")
        gQZConfig.Filters[strUUID] := newFilter
        GUI_FilterMgr_Add(FilterMgr.TV_ExistFilter, {1:strUUID})
    }
}

GUI_FilterMgr_Add(objTV, objList)
{
    Global FilterMgr, gQZConfig
    objTV.SetDefault()
    Loop % ObjList.MaxIndex()
    {
        UUID := objList[A_Index]
        Obj := gQZConfig.Filters[UUID]
        newID := TV_Add(Obj.Name, 0, "Select")
        TV_Modify(0, "Sort")
        FilterMgr.UUIDListFL[UUID] := False
        If (objTV.hwnd = FilterMgr.TV_ExistFilter.hwnd)
        {
            FilterMgr.DataEF[newID] := UUID
        }
        Else
        {
            FilterMgr.DataFL[newID] := UUID
            FilterMgr.UUIDListFL[UUID] := True
        }
    }
}

GUI_FilterMgr_Search()
{
    Global FilterMgr, gQZConfig
    FilterMgr.SearchSignal := True
    SetTimer, _FilterMgr_Search, -200
    Return
    _FilterMgr_Search:
        objGUI := GUI_FilterMgr_Dump()
        objGUI.SearchSignal := False
        keyword := objGui.Edit_Search.GetText()
        objGUI.TV_ExistFilter.SetDefault()
        TV_Delete()
        objGUI.DataEF := {}
        numPos  := objGUI.DDL_Type.GetText()
        strType := objGUI.Types[numPos]
        For UUID, objFilter In gQZConfig.Filters
        {
            If objGUI.SearchSignal
            {
                ;TV_Delete()
                Return
            }
            If objGUI.UUIDListFL[uuid]
                Continue
            obj := gQZConfig.Filters[UUID]
            If (numPos > 1)
            {
                If IsObject(obj[strType]) && !obj[strType].Method 
                    Continue
                Else If !IsObject(obj[strType]) && !Strlen(obj[strType]) 
                    Continue
            }
            If TCMatch(obj.name, keyword)
                GUI_FilterMgr_Add(objGUI.TV_ExistFilter, {1:uuid})
        }
    Return
}
