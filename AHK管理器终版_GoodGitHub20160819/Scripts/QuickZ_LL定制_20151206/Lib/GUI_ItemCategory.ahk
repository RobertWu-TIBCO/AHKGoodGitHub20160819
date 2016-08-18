GUI_ItemCategory_Load(Callback, CloseEvent, aCategory)
{
    Global ItemCategory, gQZConfig
    ItemCategory := new GUI2("ItemCategory", "+Lastfound +Theme -DPIScale")
    ItemCategory.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    ItemCategory.AddCtrl("Text_Name", "Text",  "x10 y12 h28", QZLang.TextCategoryName)
    ItemCategory.AddCtrl("Edit_Name", "Edit", "x75 y10 w180 h24 readonly", aCategory)
    ItemCategory.AddCtrl("TextTips", "Text",  "x10 y42 h28 w100", QZLang.TextSelectCategory)
    ItemCategory.AddCtrl("LV_Category", "ListView", "x10 y70 w340 r15 -hdr +grid","Title")
    ItemCategory.AddCtrl("Edit_Category", "Edit", "x10 y70 w340 r18")
    ItemCategory.AddCtrl("ButtonManager", "Button", "x260 y38 w90 h26", QZLang.ButtonManager)
    ItemCategory.AddCtrl("ButtonClear", "Button", "x260 y10 w90 h26", QZLang.ButtonClear2)
    ItemCategory.Edit_Category.Hide()
    ItemCategory.LV_Category.OnEvent("GUI_ItemCategory_Event")
    ItemCategory.ButtonManager.OnEvent("GUI_ItemCategory_Manager")
    ItemCategory.ButtonClear.OnEvent("GUI_ItemCategory_Clear")
    ItemCategory.Show("w360 h430")
    ItemCategory.Callback := Callback
    If Strlen(CloseEvent)
        ItemCategory.OnClose(CloseEvent)
    CategoryList := gQZConfig.setting.global.CategoryList
    LV_Delete()
    Loop, Parse, CategoryList, `n
        If strlen(A_LoopField)
            LV_Add("", A_LoopField)
    Return ItemCategory
}


GUI_ItemCategory_Dump()
{
    Global ItemCategory
    Return ItemCategory
}

GUI_ItemCategory_Destroy()
{
    Global ItemCategory
    ItemCategory.Destroy()
}

GUI_ItemCategory_Event()
{
    Global ItemCategory
    If (A_GUIEvent = "DoubleClick") && A_EventInfo
    {
        LV_GetText(strSelect, A_EventInfo)
        ItemCategory.Select := strSelect
        _Func := ItemCategory.Callback
        %_Func%()
        ;msgbox % A_EventInfo
    }
}


GUI_ItemCategory_Clear()
{
    Global ItemCategory
    ItemCategory.Edit_Name.SetText("")
    ItemCategory.Select := ""
     _Func := ItemCategory.Callback
        %_Func%()
}

GUI_ItemCategory_Manager()
{
    Global ItemCategory, gQZConfig
    ItemCategory.LV_Category.Hide()
    ItemCategory.Edit_Category.Show()
    ItemCategory.Edit_Category.SetText(gQZConfig.Setting.Global.CategoryList)
    ItemCategory.ButtonManager.SetText(QZLang.ButtonOK)
    ItemCategory.ButtonManager.OnEvent("GUI_ItemCategory_ManagerOK")
}


GUI_ItemCategory_ManagerOK()
{
    Global ItemCategory, gQZConfig
    ItemCategory.Default()
    ItemCategory.LV_Category.Show()
    ItemCategory.Edit_Category.Hide()
    ItemCategory.ButtonManager.SetText(QZLang.ButtonManager)
    ItemCategory.ButtonManager.OnEvent("GUI_ItemCategory_Manager")
    CategoryList := ItemCategory.Edit_Category.GetText()
    gQZConfig.setting.global.CategoryList := CategoryList 
    LV_Delete()
    Loop, Parse, CategoryList, `n
        If strlen(A_LoopField)
            LV_Add("", A_LoopField)
    GUI_Save()
}

