/* 
    Function: GUI_FilterEditor_Load()
        加载筛选器界面
    Parameters: 
        CallBack - 回调函数
    Returns: 
        返回GUI对象，用于控制筛选器界面
    Remarks: 
        无
*/

GUI_FilterEditor_Load(CallBack)
{
    Global FilterEditor
    TBListID := IL_Create(10, 10, 0)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 248)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 247)
    
    FilterEditor := New GUI2("FilterEditor", "+LastFound +Theme -Resize -DPIScale")
    FilterEditor.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    FilterEditor.AddCtrl("Text_FilterName", "Text", "x10 y12 w100 h26", QZLang.FilterName "(&F)")
    FilterEditor.AddCtrl("Edit_FilterName", "Edit", "x100 y10 w420 h26")
    FilterEditor.AddCtrl("LV_Filter", "ListView", "x10 y45 w510 r12 Grid nosort altsubmit", QZLang.TextListViewTitle2)
    FilterEditor.AddCtrl("Text_Method", "Text", "x10 y359 h26", QZLang.FilterMatchMethod "(&A):")
    FilterEditor.AddCtrl("DDL_Method", "DDL", "x90 y357 w70 h26 r4 altsubmit", QZLang.FilterOption )
    FilterEditor.AddCtrl("Text_Match", "Text", "x10 y394 h26", QZLang.FilterMatchContent "(&S):")
    FilterEditor.AddCtrl("Edit_Match", "Edit", "x90 y392 w430 h26")
    FilterEditor.AddCtrl("Text_Special", "Text", "x10 y433 h26", QZLang.FilterSpecial)
    FilterEditor.AddCtrl("Pic_Found", "PIC", "x230 y353 w32 h32 Border hidden", QZGlobal.CrossCUR)
    FilterEditor.AddCtrl("Btn_Ok", "Button", "x330 y430 w90 h26", QZLang.ButtonOK)
    FilterEditor.AddCtrl("Btn_Close", "Button", "x430 y430 w90 h26", QZLang.ButtonClose)
    FilterEditor.BTN_OK.OnEvent(CallBack)
    FilterEditor.Btn_OK.SetIcon(A_WinDir "\System32\shell32.dll", 302)
    FilterEditor.BTN_Close.OnEvent("GUI_FilterEditor_Destroy")
    FilterEditor.LV_Filter.OnEvent("GUI_FilterEditor_LVEvent")
    FilterEditor.Edit_FilterName.OnEvent("GUI_FilterEditor_UpdateFilter")
    FilterEditor.Edit_Match.OnEvent("GUI_FilterEditor_UpdateFilter")
    FilterEditor.DDL_Method.OnEvent("GUI_FilterEditor_UpdateFilter")
    LV_ModifyCol(1, "90 ")
    LV_ModifyCol(2, "80 center")
    LV_ModifyCol(3, 500)

    ;FilterEditor.TBName := Toolbar_Add(FilterEditor.hwnd, "GUI_FilterEditor_Event", "Flat Menu", TBListID, "x430 y12 h28 w100")
    FilterEditor.TBTools := Toolbar_Add(FilterEditor.hwnd, "GUI_FilterEditor_Event", "Flat Tooltips Menu", TBListID, "x180 y359 h28 w200")
    FilterEditor.TBSpecial := Toolbar_Add(FilterEditor.hwnd, "GUI_FilterEditor_Event", "Flat List", TBListID, "x75 y432 h28 w220")
    Toolbar_Insert(FilterEditor.TBTools, QZLang.TextHelp )
    Toolbar_Insert(FilterEditor.TBSpecial, QZLang.FilterAnyFile ",0,,CHECK ShowText")
    Toolbar_Insert(FilterEditor.TBSpecial, QZLang.FilterAnyText ",0,,CHECK ShowText")
    Toolbar_Insert(FilterEditor.TBSpecial, QZLang.FilterAnyMultiFiles ",0,,CHECK ShowText")
    FilterEditor.Show()
    FilterEditor.OnSize("GUI_FilterEditor_Size")
    FilterEditor.objEdit := QZ_CreateConfig_Filter() ; 保存当前编辑的筛选器对象
    FilterEditor.objTT := TT("CloseButton", "", QZLang.HelpTitleFilter)
    FilterEditor.ConditionList:= ["FileExt", "WinClass", "TextRegex"
            , "Keyword", "Function"
            , "FileMulti", "FileName" , "FileDir"
            , "WinExe", "WinTitle", "WinControl"]
    FilterEditor.ItemNames := [QZLang.FilterFileExt ;1
        ,QZLang.FilterWinClass ;2
        ,QZLang.FilterTextRegex ;3
        ,QZLang.FilterKeyword ;4
        ,QZLang.FilterFunction ;5
        ,QZLang.FilterFileMulti ;6
        ,QZLang.FilterFileName ;7
        ,QZLang.FilterFileDir ;8
        ,QZLang.FilterWinExe ;9
        ,QZLang.FilterWinTitle ;10
        ,QZLang.FilterWinControl] ;11
    Loop % FilterEditor.ItemNames.MaxIndex()
        LV_Add("", FilterEditor.ItemNames[A_Index])
}

GUI_FilterEditor_Size()
{
    Global FilterEditor
    FilterEditor.TT.Remove()
}

GUI_FilterEditor_Dump()
{
    Global FilterEditor
    Return FilterEditor
}

GUI_FilterEditor_Destroy()
{
    Global FilterEditor
    FilterEditor.Destroy()
    FilterEditor.Scroll := ""
}

GUI_FilterEditor_Save(ByRef Obj)
{
    Global FilterEditor, gQZConfig
    obj := FilterEditor.objEdit
}

GUI_FilterEditor_LoadData(aUUID)
{
    Global FilterEditor, gQZConfig
    objFilter := gQZConfig.Filters[aUUID].Clone()
    FilterEditor.objEdit := objFilter
    FilterEditor.Edit_FilterName.SetText(objFilter.Name)
    Ctrls := ["FileExt", "WinClass", "TextRegex"
            , "Keyword", "Function"
            , "FileMulti", "FileName" , "FileDir"
            , "WinExe", "WinTitle", "WinControl"]

    Loop % Ctrls.MaxIndex()
    {
        objCondition := objFilter[Ctrls[A_Index]]
        If (A_Index = 4) || (A_Index = 5)
            GUI_FilterEditor_UpdateLV(A_Index, "", objCondition)
        Else
            GUI_FilterEditor_UpdateLV(A_Index, objCondition.Method, objCondition.Match)
    }
    aCtrl := FilterEditor.TBSpecial
    Toolbar_Clear(aCtrl)
    If objFilter.Special
    {
        LV_Delete(8)
        LV_Delete(7)
        LV_Delete(6)
        LV_Delete(3)
        LV_Delete(1)
        FilterEditor.ConditionList:= ["WinClass"
            , "Keyword", "Function"
            , "WinExe", "WinTitle", "WinControl"]
    }
    If (objFilter.Special = 1)
        Toolbar_Insert(aCtrl, QZLang.FilterAnyFile ",0,Checked,CHECK ShowText")
    Else
        Toolbar_Insert(aCtrl, QZLang.FilterAnyFile ",0,,CHECK ShowText")

    If (objFilter.Special = 2)
        Toolbar_Insert(aCtrl, QZLang.FilterAnyText ",0,Checked,CHECK ShowText")
    Else
        Toolbar_Insert(aCtrl, QZLang.FilterAnyText ",0,,CHECK ShowText")

    If (objFilter.Special = 3)
        Toolbar_Insert(aCtrl, QZLang.FilterAnyMultiFiles ",0,Checked,CHECK ShowText")
    Else
        Toolbar_Insert(aCtrl, QZLang.FilterAnyMultiFiles ",0,,CHECK ShowText")
}

GUI_FilterEditor_UpdateLV(aPos, aMethod, aMatch)
{
    Global FilterEditor
    FilterEditor.Default()
    strMethod := ["包含", "排除", "正则"]
    LV_Modify(aPos, "col2", strMethod[aMethod])
    LV_Modify(aPos, "col3", aMatch)
}

GUI_FilterEditor_UpdateFilter()
{
    Global FilterEditor
    FilterEditor.Default()
    objFilter := FilterEditor.objEdit
    objFilter.Name := FilterEditor.Edit_FilterName.GetText()
    lPos := LV_GetNext(0, "F")
    If lPos
    {
        ConditionType := FilterEditor.ConditionList[lPos]
        Condition:= objFilter[ConditionType] 
        If IsObject(Condition)
            Condition := {Method:FilterEditor.DDL_Method.GetText()-1, Match:FilterEditor.Edit_Match.GetText()}
        Else
            Condition := FilterEditor.Edit_Match.GetText()
        objFilter[ConditionType] := Condition
        If (lPos = 4) || (lPos = 5)
            GUI_FilterEditor_UpdateLV(lPos, "", Condition)
        Else
            GUI_FilterEditor_UpdateLV(lPos, Condition.Method, Condition.Match)
    }
}

GUI_FilterEditor_LVEvent()
{
    Global FilterEditor
    FilterEditor.Default()
    fPos := LV_GetNext(0, "Focus")
    If fPos && ((A_GuiEvent = "Normal")||(A_GuiEvent = "K"))
    {
        FilterEditor.TT.Remove()
        FilterEditor.Edit_Match.OnEvent("")
        FilterEditor.DDL_Method.OnEvent("")
        objFilter := FilterEditor.objEdit
        ConditionType := FilterEditor.ConditionList[fPos]
        Condition := objFilter[ConditionType]
        If IsObject(Condition)
        {
            ;Msgbox % Json.Dump(Condition, 2)
            FilterEditor.DDL_Method.Enable()
            FilterEditor.DDL_Method.Choose(Condition.Method+1)
            FilterEditor.Edit_Match.SetText(Condition.Match)
        }
        Else
        {
            FilterEditor.DDL_Method.Disable()
            FilterEditor.DDL_Method.Choose(1)
            FilterEditor.Edit_Match.SetText(Condition)
        }
        FilterEditor.Edit_Match.OnEvent("GUI_FilterEditor_UpdateFilter")
        FilterEditor.DDL_Method.OnEvent("GUI_FilterEditor_UpdateFilter")
        ;Msgbox % FilterEditor.ConditionList[fPos]
        Toolbar_Clear(FilterEditor.TBTools)
        Toolbar_Insert(FilterEditor.TBTools, QZLang.TextHelp )
        If (ConditionType = "FileExt") || (ConditionType = "FileMulti")
            Toolbar_Insert(FilterEditor.TBTools, QZLang.FilterAddFileType)
        If (ConditionType = "Keyword")
            Toolbar_Insert(FilterEditor.TBTools, QZLang.FilterMenuMode)
        If (ConditionType = "Function")
            Toolbar_Insert(FilterEditor.TBTools, QZLang.FilterMenuFunc)
        If InStr(ConditionType , "Win")
        {
            FilterEditor.Pic_Found.Show()
            If (ConditionType = "WinClass")
                FilterEditor.Pic_Found.OnEvent("GUI_FilterEditor_FoundClass")
            If (ConditionType = "WinExe")
                FilterEditor.Pic_Found.OnEvent("GUI_FilterEditor_FoundExe")
            If (ConditionType = "WinControl")
                FilterEditor.Pic_Found.OnEvent("GUI_FilterEditor_FoundControl")
            If (ConditionType = "WinTitle")
                FilterEditor.Pic_Found.OnEvent("GUI_FilterEditor_FoundTitle")
        }
        Else
        {
            FilterEditor.Pic_Found.Hide()
        }
    }
}

GUI_FilterEditor_Event(aCtrl, aEvent, aText, aPos)
{
    Global FilterEditor, gQZConfig
    If (aCtrl = FilterEditor.TBTools) && (aEvent = "Menu")
    {
        _hwnd := FilterEditor.hwnd
        CoordMode, Menu, Screen
        WinGetPos, GuiX, GuiY, , ,  ahk_id %_hwnd%
        ControlGetPos, TBX, TBY, , , ToolbarWindow321, ahk_id %_hwnd%
        TBH := Toolbar_GetRect(FilterEditor.TBTools, aPos, "h")
        TBX2 := Toolbar_GetRect(FilterEditor.TBTools, aPos, "X")
        PosX := GuiX + TBX + TBX2
        PosY := GuiY + TBY + TBH
        If (aText = QZLang.TextHelp)
        {
            FilterEditor.Default()
            fPos := LV_GetNext(0, "F")
            If fPos
                objInfo := QZLang["Help_Filter" FilterEditor.ConditionList[fPos]]()
            Else
                objInfo := QZLang.Help_Filter()
            FilterEditor.TT.Remove()
            objTT := TT("CloseButton", "", "")
            ObjTT.Show(objInfo.Text , PosX, PosY, objInfo.Title)
            FilterEditor.TT := objTT
            Return
        }
        Menu, FilterEditor, Add
        Menu, FilterEditor, DeleteAll
        If (aText = QZLang.FilterAddFileType) 
        {
            Menu, FilterEditor, Add, % QZLang.FilterMenuExtFolder, _MenuHandle_FileEditor
            Menu, FilterEditor, Add, % QZLang.FilterMenuExtDrive, _MenuHandle_FileEditor
            Menu, FilterEditor, Add, % QZLang.FilterMenuExtNoExt, _MenuHandle_FileEditor
        }
        If (aText = QZLang.FilterMenuMode)
        {
            objMode := Strlen(gQZConfig.Setting.MenuZ.Keyword[1]) 
                       ? gQZConfig.Setting.MenuZ.Keyword 
                       : QZGlobal.KeywordList
            Loop % objMode.MaxIndex()
            {
                strName := objMode[A_Index]
                Menu, FilterEditor, Add, %strName%, _MenuHandle_FileEditor
            }
        }
        If (aText = QZLang.FilterMenuFunc)
        {
            Loop , % QZGlobal.PluginDir "*.ahk", 1, 1
            {
                objPlugin := GetPluginInfo(A_LoopFileFullPath)
                If IsObject(objPlugin)
                {
                    If !(objPlugin.Filter)
                        Continue
                    strName := objPlugin.Filter "  |  " objPlugin.Tips
                    Menu, FilterEditor, Add, %strName%, _MenuHandle_FileEditor
                }
            }
        }
        Menu, FilterEditor, Show, %PosX%, %PosY%
        Return
        _MenuHandle_FileEditor:
            objGUI := GUI_FilterEditor_Dump()
            OldText := objGUI.Edit_Match.GetText()
            newType := RegExReplace(A_ThisMenuItem, "\s.*")
            objGUI.Edit_Match.Append(GUI_FilterEditor_TextToAdd(oldText, newType))
        Return
    }
    If (aCtrl = FilterEditor.TBSpecial) && (aEvent = "Click")
    {
        FilterEditor.Default()
        Toolbar_Clear(aCtrl)
        If ( aPos = FilterEditor.objEdit.Special)
        {
            aPos := 0
            objFilter := FilterEditor.objEdit
            LV_Insert(1, "", FilterEditor.ItemNames[1])
            GUI_FilterEditor_UpdateLV(1, objFilter.FileExt.Method
                , objFilter.FileExt.Match)
            LV_Insert(3, "", FilterEditor.ItemNames[3])
            GUI_FilterEditor_UpdateLV(3, objFilter.TextRegex.Method
                , objFilter.TextRegex.Match)
            LV_Insert(6, "", FilterEditor.ItemNames[6])
            GUI_FilterEditor_UpdateLV(6, objFilter.FileMulti.Method
                , objFilter.FileMulti.Match)
            LV_Insert(7, "", FilterEditor.ItemNames[7])
            GUI_FilterEditor_UpdateLV(7, objFilter.FileName.Method
                , objFilter.FileName.Match)
            LV_Insert(8, "", FilterEditor.ItemNames[8])
            GUI_FilterEditor_UpdateLV(8, objFilter.FileDir.Method
                , objFilter.FileDir.Match)
            FilterEditor.ConditionList:= ["FileExt", "WinClass", "TextRegex"
                , "Keyword", "Function"
                , "FileMulti", "FileName" , "FileDir"
                , "WinExe", "WinTitle", "WinControl"]
        }
        Else
        {
            ; 特殊条件，禁用：/文本类型/多文件/文件名/文件目录名
            If ( LV_GetCount() = 11)
            {
                LV_Delete(8)
                LV_Delete(7)
                LV_Delete(6)
                LV_Delete(3)
                LV_Delete(1)
                Toolbar_Clear(FilterEditor.TBTools)
                Toolbar_Insert(FilterEditor.TBTools, QZLang.TextHelp )
                FilterEditor.DDL_Method.Choose(1)
                FilterEditor.Edit_Match.SetText("")
                FilterEditor.ConditionList:= ["WinClass"
                    , "Keyword", "Function"
                    , "WinExe", "WinTitle", "WinControl"]
            }
        }
        If (aPos = 1)
            Toolbar_Insert(aCtrl, QZLang.FilterAnyFile ",0,Checked,CHECK ShowText")
        Else
            Toolbar_Insert(aCtrl, QZLang.FilterAnyFile ",0,,CHECK ShowText")

        If (aPos = 2)
            Toolbar_Insert(aCtrl, QZLang.FilterAnyText ",0,Checked,CHECK ShowText")
        Else
            Toolbar_Insert(aCtrl, QZLang.FilterAnyText ",0,,CHECK ShowText")
        If (aPos = 3)
            Toolbar_Insert(aCtrl, QZLang.FilterAnyMultiFiles ",0,Checked,CHECK ShowText")
        Else
            Toolbar_Insert(aCtrl, QZLang.FilterAnyMultiFiles ",0,,CHECK ShowText")
        FilterEditor.objEdit.Special := aPos
    }
}

GUI_FilterEditor_FoundClass()
{
    GUI_FilterEditor_PicCross("WinClass")
}

GUI_FilterEditor_FoundExe()
{
    GUI_FilterEditor_PicCross("WinExe")
}

GUI_FilterEditor_FoundTitle()
{
    GUI_FilterEditor_PicCross("WinTitle")
}

GUI_FilterEditor_FoundControl()
{
    GUI_FilterEditor_PicCross("WinControl")
}

GUI_FilterEditor_PicCross(aCtrlName)
{
    Global FilterEditor
    iCursor := DllCall("LoadCursorFromFile", Str, QZGlobal.CrossCUR)
    DllCall( "SetSystemCursor", Uint, iCursor, Int,32512 )
    FilterEditor.Cursor := iCursor
    pToken := GDIP_StartUp()
    Gui, _987: -Caption +E0x80000 +hwndhID +LastFound +OwnDialogs +Owner +AlwaysOnTop
    Gui, _987: Show, NA
    hbm := CreateDIBSection(A_ScreenWidth, A_ScreenHeight)
    hdc := CreateCompatibleDC()
    obm := SelectObject(hdc, hbm)
    G := Gdip_GraphicsFromHDC(hdc)
    Gdip_SetSmoothingMode(G, 4)
    pPen := Gdip_CreatePen(0xFFFF0000,3)
    FilterEditor.objCross := {"HWND":hID, "Token":pToken, "Pen":pPen
                             , "G":G, "HDC":HDC, "Ctrl":aCtrlName, "Text":FilterEditor.Edit_Match.GetText()}
    SetTimer, _FoundWinClass, 200
    KeyWait,LButton
    SetTimer, _FoundWinClass, Off
    
    Gdip_DeletePen(pPen)
    SelectObject(hdc, obm)
    DeleteObject(hbm)
    DeleteDC(hdc)
    Gdip_DeleteGraphics(G)
    Gdip_Shutdown(pToken)
    GUI, _987:Destroy
    ;还原鼠标指针
    DllCall( "SystemParametersInfo", UInt,0x57, UInt,0, UInt,0, UInt,0 )
    Return

    _FoundWinClass:
        objGUI := GUI_FilterEditor_Dump()
        ctrlName := objGUI.objCross.Ctrl
        MouseGetPos,,,id, FocusCtrl
        WinGetPos,x,y,w,h,ahk_id %id%
        If (ctrlName = "WinControl")
        {
            ControlGetPos, cx, cy, w, h, %FocusCtrl%, ahk_id %id%
            x += cx, y += cy
            newType := FocusCtrl
        }
        Else
        {
            If (CtrlName = "WinClass")
                WinGetClass, newType, ahk_id %id%
            Else If (CtrlName = "WinTitle")
                WinGetTitle, newType , ahk_id %id%
            Else If (CtrlName = "WinExe")
                WinGet, newType, processName, ahk_Id %id%
        }
        x < 0 ? x := 0 
        y < 0 ? y := 0
        w < 0 ? w := 3
        h < 0 ? h := 3
        Gdip_GraphicsClear(objGUI.objCross.G)
        Gdip_DrawRectangle(objGUI.objCross.G,objGUI.objCross.Pen,x+1,y+1,w-2,h-2)
        UpdateLayeredWindow(objGUI.objCross.hwnd, objGUI.objCross.HDC, 0, 0, A_ScreenWidth, A_ScreenHeight)
        oldText := objGUI.objCross.Text
        objGUI.Edit_Match.SetText(oldText . GUI_FilterEditor_TextToAdd(oldText, newType))
    Return
}

GUI_FilterEditor_TextToAdd(aText, aType)
{
    If !StrLen(aText)
        newText := aType
    Else If StrLen(aText) && (SubStr(aText, 0) = "`;")
        newText := aType
    Else
        newText := "`;" aType
    Return newText
}
