/*
    Function: GUI_ItemEditor_Load()
        加载菜单项编辑器

    Parameters: 
        Callback - 用于设置界面关闭后执行某个回调函数。如"test"，代表运行 Test() 函数
*/
GUI_ItemEditor_Load(Callback, CloseEvent:="", CodeMode:=False)
{
    Global ItemEditor, GuiMain
    If CodeMode
    {
        ItemEditor := ""
        GUI_ItemEditorCode_Load(Callback, CloseEvent)
        Return
    }
    ItemEditor.Scroll := ""
    ItemEditor := new GUI2("ItemEditor", "+Lastfound +Theme +Resize -DPIScale")
    TBListID := IL_Create(10, 10, 0)
    IL_Add(TBListID, A_WinDir "\System32\mspaint.exe", 1)
    IL_Add(TBListID, A_ScriptDir "\User\Icons\Category.ico")
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 248)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 247)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 160)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 47)
    ;OnMessage(0x0133, "GUI_ItemEditor_CTLCOLOR")
    ; 初始化数据
    ItemEditor.Data := {} ;保存界面相关的数据
    ItemEditor.Callback   := Callback ; 回调函数 
    ItemEditor.CloseEvent := CloseEvent
    ; 添加控件
    ItemEditor.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    ItemEditor.AddCtrl("GB_ItemName", "GroupBox", "x10 y10 h60 w515", QZLang.TextItemName) 
    If (GuiMain.EditMode = 1)
    {
        ItemEditor.AddCtrl("text_Icon", "Text", "x36 y34 h24 w24 border")
        ItemEditor.AddCtrl("pic_Icon", "Pic", "x40 y38 h18 w18 ")
        ItemEditor.AddCtrl("edit_Name", "Edit", "x72 y34 h26 w330")
    }
    If (GuiMain.EditMode = 2)
    {
        ItemEditor.AddCtrl("text_Name", "Text", "x20 y36 h26", QZLang.TextName)
        ItemEditor.AddCtrl("edit_Name", "Edit", "x72 y34 h26 w366")
    }
    ItemEditor.AddCtrl("GB_Content", "GroupBox", "x10 y75 h175 w515", QZLang.TextItemContent)
    ItemEditor.AddCtrl("text_Cmd", "Text", "x20 y100 h26", QZLang.TextCommand) 
    ItemEditor.AddCtrl("Edit_Cmd", "Edit", "x72 y98 h26 w330")
    ItemEditor.AddCtrl("text_Param", "Text", "x20 y137 h26", QZLang.TextParam) 
    ItemEditor.AddCtrl("Edit_Param", "Edit", "x72 y137 h70 w440")
    /*
    ItemEditor.AddCtrl("text_Param", "Text", "x20 y100 h26", QZLang.TextParam) 
    ItemEditor.AddCtrl("Edit_Param", "Edit", "x72 y100 h110 w440")
    */
    ItemEditor.AddCtrl("BG_RunSetting", "GroupBox", "x10 y305 h100 w515", QZLang.TextItemRunSetting)
    ItemEditor.AddCtrl("Text_WorkingDir", "Text", "x20 y334 h26", QZLang.TextWorkingDir) 
    ItemEditor.AddCtrl("Edit_WorkingDir", "Edit", "x72 y332 h26 w340")
    ItemEditor.AddCtrl("Btn_WorkingDir", "Button", "x424 y332 h26 w90", QZLang.ButtonWorkingDir)
    ItemEditor.AddCtrl("Text_Runmode", "Text", "x20 y372 h26", QZLang.TextRunMode) 
    ItemEditor.AddCtrl("CB_Normal", "Radio", "x90 y370 h26 Checked", QZLang.CBNormal)
    ItemEditor.AddCtrl("CB_Max", "Radio", "x162 y370 h26 ", QZLang.CBMax)
    ItemEditor.AddCtrl("CB_Min", "Radio", "x252 y370 h26 ", QZLang.CBMin)
    ItemEditor.AddCtrl("CB_Hide", "Radio", "x340 y370 h26 ", QZLang.CBHide)
    ItemEditor.AddCtrl("CB_Admin", "CheckBox", "x415 y370 h26 ", QZLang.CBAdmin)
    ItemEditor.AddCtrl("Text_Comment", "Text", "x20 y414 h26", QZLang.TextComment) 
    ItemEditor.AddCtrl("Edit_Comment", "Edit", "x72 y412 r1 w440")
    ;ItemEditor.AddCtrl("GB_ItemView", "GroupBox", "x10 y455 h60 w515", QZLang.TextOtherOptions)
    ;ItemEditor.AddCtrl("ItemHide",    "CheckBox", "x30 y480 h26 w95", QZLang.TextHide)
    ;ItemEditor.AddCtrl("ItemDisable", "CheckBox", "x150 y480 h26 w95", QZLang.TextDisable)
    ;ItemEditor.AddCtrl("ItemDelete",  "Button", "x336 y480 h26 w95", QZLang.ButtonDelete)
    ;ItemEditor.AddCtrl("btn_Advance", "Button", "x424 y210 h26 w90", QZLang.ButtonAdvance)
    ItemEditor.AddCtrl("ButtonOK", "Button", "x336 y260 h26 w90", QZLang.ButtonOK)
    ItemEditor.AddCtrl("ButtonClose", "Button", "x436 y260 h26 w90", QZLang.ButtonClose)
    ItemEditor.ButtonOK.SetIcon(QZGlobal.DefaultIcl, 30)
    ItemEditor.ButtonOK.OnEvent(Callback)
    ItemEditor.PIC_Icon.OnEvent("GUI_ItemEditor_Pic")
    ItemEditor.Text_Icon.OnEvent("GUI_ItemEditor_Pic")
    ItemEditor.Scroll := New ScrollGUI(ItemEditor.hwnd, 535, 295, "+Label_ScrollGUI", 2, 2)
    ItemEditor.Scroll.Show(QZLang.ItemEditor, "ycenter xcenter ")
    ItemEditor.Scroll.SetMax(2, 290)
    ItemEditor.OndropFiles("GUI_ItemEditor_DropFiles")
    If Strlen(CloseEvent)
    {
        ItemEditor.OnClose(CloseEvent)
        ItemEditor.ButtonClose.OnEvent(CloseEvent)
    }
    Else
    {
        ItemEditor.ButtonClose.OnEvent("GUI_ItemEditor_Destroy")
    }
    If (GuiMain.EditMode = 1)
    {
        TBCtrl := Toolbar_Add(ItemEditor.hwnd, "GUI_ItemEditor_Event", "Flat Tooltips List", TBListID, "x415 y30 h36 w100")
        Toolbar_Insert(TBCtrl, QZLang.TB_IconAndColor ", 1, ,dropdown")
    }
    If (GuiMain.EditMode = 2)
    {
        TBCtrl := Toolbar_Add(ItemEditor.hwnd, "GUI_ItemEditor_Event", "Flat Tooltips List", TBListID, "x450 y30 h36 w60")
    }
    TBCMD  := Toolbar_Add(ItemEditor.hwnd, "GUI_ItemEditor_Event", "Flat Tooltips List", TBListID, "x415 y95 h32 w100")
    TBParam  := Toolbar_Add(ItemEditor.hwnd, "GUI_ItemEditor_Event", "Flat Tooltips List ", TBListID, "x72 y212 h32 w440")
    TBAdv  := Toolbar_Add(ItemEditor.hwnd, "GUI_ItemEditor_Event", "Flat Tooltips Menu", TBListID, "x10 y262 h36 w300")
    ItemEditor.ToolbarName := TBCtrl
    ItemEditor.ToolbarCMD := TBCMD
    ItemEditor.ToolbarAdv := TBAdv
    ItemEditor.ToolbarParam := TBParam
    Toolbar_Insert(TBCtrl, QZLang.TB_Category ", 2, , dropdown")
    Toolbar_Insert(TBCMD, QZLang.TextChangeCmd ", 0, , showtext dropdown")
    Toolbar_Insert(TBAdv, QZLang.TextChangeToCode ", 6, , ")
    Toolbar_Insert(TBAdv, QZLang.ItemEditorShowAdv ", 3, , ")
    Toolbar_Insert(TBParam, QZLang.TextFilePath ", 0, ,showtext")
    Toolbar_Insert(TBParam, QZLang.TextFileDir ", 0, ,showtext")
    Toolbar_Insert(TBParam, QZLang.TextLabel ", 0, ,showtext dropdown")
    Toolbar_Insert(TBParam, QZLang.TextVar ", 0, ,showtext dropdown")
    Toolbar_Insert(TBParam, QZLang.TextTools ",  0, ,showtext dropdown")
    Toolbar_Insert(TBParam, QZLang.TextHelp ",  0, ,showtext ")
    Toolbar_SetButtonSize(TBCtrl, 24)
    Return ItemEditor
}

GUI_ItemEditor_LoadData(aMenu)
{
    Global ItemEditor, gQZConfig
    If !IsObject(ItemEditor)
    {
        GUI_ItemEditorCode_LoadData(aMenu)
        Return
    }
    ItemEditor.EditMenu := aMenu
    aUUID := aMenu.UUID
    ItemEditor.Data.UUID := aUUID
    objItem := gQZConfig.Items[aUUID]
    ItemEditor.CategorySelect := objItem.Options.Category
    ItemEditor.Edit_Name.SetText(objItem.Name)
    ItemEditor.Edit_Cmd.SetText(objItem.Command)
    ItemEditor.Edit_Param.SetText(objItem.Param)
    ItemEditor.Edit_Comment.SetText(objItem.Tips)
    ItemEditor.Edit_WorkingDir.SetText(objItem.Options.WorkingDir)
    If InStr(objItem.Options.RunState, 0)
        ItemEditor.CB_Normal.SetText(True)
    If InStr(objItem.Options.RunState, 1)
        ItemEditor.CB_Max.SetText(True)
    If InStr(objItem.Options.RunState, 2)
        ItemEditor.CB_Min.SetText(True)
    If InStr(objItem.Options.RunState, 3)
        ItemEditor.CB_Hide.SetText(True)
    If InStr(objItem.Options.RunState, "a")
        ItemEditor.CB_Admin.SetText(True)
    Else
        ItemEditor.CB_Admin.SetText(False)
    GUI_ItemEditor_SetBold(aMenu.Options.Bold)
    GUI_ItemEditor_SetColor(aMenu.Options.ColorBack, aMenu.Options.ColorFore)
    ItemEditor_SetIcon(aMenu.Options.IconFile, aMenu.Options.IconNumber)
    ;ItemEditor.Data.IconSize := aMenu.Options.IconSize
}

GUI_ItemEditor_Dump()
{
    Global ItemEditor, ItemEditorCode
    If !IsObject(ItemEditor)
        Return ItemEditorCode
    Return ItemEditor
}


GUI_ItemEditor_Save(ByRef objMenu)
{
    Global ItemEditor, gQZConfig
    If !IsObject(ItemEditor)
    {
        GUI_ItemEditorCode_Save(objMenu)
        Return
    }
    If Strlen(objMenu.UUID)
    {
        objItem := gQZConfig.Items[objMenu.UUID]
        objMenu.Options.IconFile := ItemEditor.Data.IconFile
        objMenu.Options.IconNumber := ItemEditor.Data.IconNumber
        objMenu.Options.Bold := ItemEditor.Data.Bold
        objMenu.Options.ColorBack := ItemEditor.Data.ColorBack
        objMenu.Options.ColorFore := ItemEditor.Data.ColorFore
        ;objMenu.Options.IconSize := ItemEditor.Data.IconSize
    }
    Else
        objItem := objMenu
    objItem.Name := ItemEditor.Edit_Name.GetText()
    objItem.Command := ItemEditor.Edit_CMD.GetText()
    objItem.Param := ItemEditor.Edit_Param.GetText()
    objItem.Tips := ItemEditor.Edit_Comment.GetText()
    objItem.Options.WorkingDir := ItemEditor.Edit_WorkingDir.GetText()
    objItem.Options.CodeMode := False
    objItem.Options.Category := ItemEditor.CategorySelect
}

GUI_ItemEditor_Destroy()
{
    Global ItemEditor
    If IsObject(ItemEditor)
    {
        ItemEditor.Scroll := ""
        ItemEditor.Destroy()
    }
    Else
    {
        GUI_ItemEditorCode_Destroy()
    }
    CtlColors.Detach(ItemEditor.Edit_Name.Hwnd)
}

GUI_ItemEditor_DropFiles()
{
    Global ItemEditor
    Loop, parse, A_GuiEvent, `n
    {
        ItemEditor.Edit_Cmd.SetText(A_LoopField)
        Break
    }
}

GUI_ItemEditor_Event(aCtrl, aEvent, aText, aPos)
{
    Global ItemEditor, gQZConfig
    Static ShowAdv := False
    If (aCtrl = ItemEditor.ToolbarCMD)
    {
        If (aEvent = "Click")
        {
            GUI_ItemEditorCmd_load("GUI_ItemEditor_SetCmdEvent")
            objGUI := GUI_ItemEditorCmd_Dump()
            objGUI.LS_Category.Choose(1)
            GUI_ItemEditorCmd_Category(True)
        }
        If (aEvent = "Menu")
        {
            IconSelHwnd := ItemEditor.hwnd
            CoordMode, Menu, Screen
            WinGetPos, GuiX, GuiY, , ,  ahk_id %IconSelHwnd%
            ControlGetPos, TBX, TBY, , , ToolbarWindow322, ahk_id %IconSelHwnd%
            TBH := Toolbar_GetRect(ItemEditor.ToolbarCMD, "1", "h")
            PosX := GuiX + TBX
            PosY := GuiY + TBY + TBH
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, DeleteAll
            Menu, _TBCMDMenu, Add, % QZLang.TextInsertFile, _TBCMDMenu_DO
            Menu, _TBCMDMenu, Add, % QZLang.TextInsertDir, _TBCMDMenu_DO
            Menu, _TBCMDMenu, Add, % QZLang.TextInsertVar, _TBCMDMenu_DO
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, Add, % QZLang.TextRelativePath, _TBCMDMenu_DO
            Menu, _TBCMDMenu, Add, % QZLang.TextFullPath, _TBCMDMenu_DO
            Menu, _TBCMDMenu, Show, %PosX%, %PosY%
            Return
            _TBCMDMenu_DO:
                If (A_ThisMenuItem = QZLang.TextInsertVar)
                {
                    GUI_EnvEditor_Load("GUI_ItemEditor_SelectCmdEnv", "")
                    Return
                }
                _ItemEditor := GUI_ItemEditor_Dump()
                If (A_ThisMenuItem = QZLang.TextInsertFile)
                {
                    FileSelectFile,	newCmd, 3,  , % QZLang.TextPleaseSelectFile, *.*
                }
                Else If (A_ThisMenuItem = QZLang.TextInsertDir)
                {
                    FileSelectFolder, newCmd, , , % QZLang.TextPleaseSelectDir
                }
                Else If (A_ThisMenuItem = QZLang.TextRelativePath)
                {
                    FullPath := _ItemEditor.Edit_Cmd.GetText()
                    newCmd := PathRelativeTo(FullPath, A_ScriptDir)
                }
                Else If (A_ThisMenuItem = QZLang.TextFullPath)
                {
                    RelativePath := _ItemEditor.Edit_Cmd.GetText()
                    newCmd := PathResolve(RelativePath)
                }
                _ItemEditor.Edit_Cmd.SetText(newCmd)
            Return
        }
    }
    Else If (aCtrl = ItemEditor.ToolbarName)
    {
        If (aText = QZLang.TB_IconAndColor) 
        {
            If (aEvent = "Click")
            {
                GUI_ItemEditor_Pic()
                Return
            }
            If !(aEvent = "Menu")
                Return
            IconSelHwnd := ItemEditor.hwnd
            CoordMode, Menu, Screen
            WinGetPos, GuiX, GuiY, , ,  ahk_id %IconSelHwnd%
            ControlGetPos, TBX, TBY, , , ToolbarWindow321, ahk_id %IconSelHwnd%
            TBH := Toolbar_GetRect(ItemEditor.ToolbarName, aPos, "h")
            PosX := GuiX + TBX
            PosY := GuiY + TBY + TBH
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, DeleteAll
            Menu, _TBCMDMenu, Add, % QZLang.ButtonAutoIcon, _TBNameMenu_DO
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, Add, % QZLang.ButtonBColor, _TBNameMenu_DO
            Menu, _TBCMDMenu, Add, % QZLang.ButtonTColor, _TBNameMenu_DO
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, Add, % QZLang.ButtonBold, _TBNameMenu_DO
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, Add, % QZLang.ButtonClear, _TBNameMenu_DO
            Menu, _TBCMDMenu, Add, % QZLang.ButtonClearColor, _TBNameMenu_DO
            If ItemEditor.Data.Bold
                Menu, _TBCMDMenu, Check, % QZLang.ButtonBold
            /*
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, Add, % QZLang.TextMenu16x, _TBNameMenu_DO
            If (ItemEditor.Data.IconSize = 16) || !ItemEditor.Data.IconSize
                Menu, _TBCMDMenu, Check, % QZLang.TextMenu16x
            Menu, _TBCMDMenu, Add, % QZLang.TextMenu24x, _TBNameMenu_DO
            If (ItemEditor.Data.IconSize = 24)
                Menu, _TBCMDMenu, Check, % QZLang.TextMenu24x
            Menu, _TBCMDMenu, Add, % QZLang.TextMenu32x, _TBNameMenu_DO
            If (ItemEditor.Data.IconSize = 32)
                Menu, _TBCMDMenu, Check, % QZLang.TextMenu32x
                */
            Menu, _TBCMDMenu, Show, %PosX%, %PosY%
            Return
            _TBNameMenu_DO:
                If (A_ThisMenuItem = QZLang.ButtonAutoIcon)
                    GUI_ItemEditor_AutoIcon()
                If (A_ThisMenuItem = QZLang.ButtonClear)
                    GUI_ItemEditor_ClearIcon()
                If (A_ThisMenuItem = QZLang.ButtonBColor)
                    GUI_ItemEditor_BColor()
                If (A_ThisMenuItem = QZLang.ButtonTColor)
                    GUI_ItemEditor_TColor()
                If (A_ThisMenuItem = QZLang.ButtonBold)
                {
                    objGUI := GUI_ItemEditor_Dump()
                    GUI_ItemEditor_SetBold(!objGUI.Data.Bold)
                }
                If (A_ThisMenuItem = QZLang.ButtonClearColor)
                {
                    GUI_ItemEditor_SetColor("","")
                }
                /*
                If (A_ThisMenuItem = QZLang.TextMenu16x)
                {
                    objGUI := GUI_ItemEditor_Dump()
                    objGUI.Data.IconSize := 16
                }
                If (A_ThisMenuItem = QZLang.TextMenu24x)
                {
                    objGUI := GUI_ItemEditor_Dump()
                    objGUI.Data.IconSize := 24
                }
                If (A_ThisMenuItem = QZLang.TextMenu32x)
                {
                    objGUI := GUI_ItemEditor_Dump()
                    objGUI.Data.IconSize := 32
                }
                */
            Return
        }
        If (aText = QZLang.TB_Category) && (aEvent = "Click")
        {
            GUI_ItemCategory_Load("GUI_SelectCategoryDo","GUI_ItemCategory_Destroy", ItemEditor.CategorySelect)
        }
        ;If (aPos = 2) && (aEvent = "Menu")
        ;{
        ;}
    }
    Else If (aEvent = "Menu") && ((aCtrl = ItemEditor.ToolbarAdv) || (aCtrl = ItemEditor.ToolbarBottom))
    {
        If (aText = QZLang.ItemEditorShowAdv) || (aText = QZLang.ItemEditorHideAdv)
        {
            GUI_ItemEditor_ShowOrHideAdv(ShowAdv:=!ShowAdv)
        }
        Else If (aText = QZLang.TextChangeToCode)
        {
            ItemEditor.CodeMode := True
            ExistName := ItemEditor.Edit_Name.GetText()
            objGUI := GUI_ItemEditorCode_Load(ItemEditor.Callback, ItemEditor.CloseEvent)
            GUI_ItemEditorCode_LoadData(ItemEditor.EditMenu)
            ObjGUI.Edit_Name.SetText(ExistName)
            objGUI.CategorySelect := ItemEditor.CategorySelect
            ItemEditor.Destroy()
            ItemEditor.Scroll := ""
            ItemEditor := ""
        }
    }
    Else If (aCtrl = ItemEditor.ToolbarParam) && (aEvent = "Click")
    {
        If (aText = QZLang.TextFilePath)
        {
            FileSelectFile,	newCmd, 3,  , % QZLang.TextPleaseSelectFile, *.*
            ItemEditor.Edit_Param.Append(newCmd)
        }
        If (aText = QZLang.TextFileDir)
        {
            FileSelectFolder, newCmd, , , % QZLang.TextPleaseSelectDir
            ItemEditor.Edit_Param.Append(newCmd)
        }
        If (aText = QZLang.TextVar)
        {
            GUI_EnvEditor_Load("GUI_ItemEditor_SelectParamEnv", "")
        }
        If (aText = QZLang.TextLabel)
        {
        }
        If (aText = QZLang.TextTools)
        {
        }
        If (aText = QZLang.TextHelp)
        {
        }
    }
}

GUI_ItemEditor_SelectCmdEnv()
{
    Global ItemEditor, EnvEditor
    GUI_EnvEditor_Destroy()
    ItemEditor.Edit_Cmd.InsertText(EnvEditor.Select)
}

GUI_ItemEditor_SelectParamEnv()
{
    Global ItemEditor, EnvEditor
    GUI_EnvEditor_Destroy()
    ItemEditor.Edit_Param.InsertText(EnvEditor.Select)
}

GUI_ItemEditor_Pic()
{
    Global gQZConfig
    GUI_IconSelector_Load("GUI_ItemEditor_SetIconEvent")
    objGUI := GUI_IconSelector_Dump()
    objGUI.SearchPath.SetText(QZGlobal.DefaultIcons)
    GUI_IconSelector_Search()
    GUI_IconSelector_SetBookMark(gQZConfig.Setting.IconBookMark)
}

GUI_ItemEditor_SetIconEvent()
{
    ObjGUI := GUI_IconSelector_Dump()
    If (ObjGUI.Data.Event = "Select")
        ItemEditor_SetIcon(objGUI.Data.IconFile, objGUI.Data.IconNumber)
    Else If (ObjGUI.Data.Event = "Clear")
        ItemEditor_SetIcon("", 0)
    Else
        ObjGUI.Destroy()
}

ItemEditor_SetIcon(aIconFile, aIconNumber)
{
    Global ItemEditor
    ItemEditor.Data.IconFile := aIconFile
    ItemEditor.Data.IconNumber := aIconNumber
    ItemEditor.Pic_Icon.SetIcon(QZ_ReplaceEnv(aIconFile), aIconNumber)
}

GUI_ItemEditor_ClearIcon()
{
    Global ItemEditor
    ItemEditor_SetIcon("", 0)
}

GUI_ItemEditor_AutoIcon()
{
    Global ItemEditor
    If FileExist(ExeFile := QZ_ReplaceEnv(ItemEditor.Edit_Cmd.GetText()))
    {
        SplitPath, ExeFile, , , OutExtension
        If (OutExtension = "exe")
            ItemEditor_SetIcon(ExeFile, "1")
        Return
    }
    Msgbox Can't Load ExeFile
}

GUI_ItemEditor_SetBold(aBold)
{
    Global ItemEditor
    If aBold
        ItemEditor.Edit_Name.SetFont("Bold")
    Else
        ItemEditor.Edit_Name.SetFont("Norm")
    ItemEditor.Data.Bold := aBold
}

GUI_ItemEditor_SetColor(aBack, aFore)
{
    Global ItemEditor
    ItemEditor.Data.ColorBack := aBack
    ItemEditor.Data.ColorFore := aFore
    If Strlen(aBack) || Strlen(aFore)
        CtlColors.Attach(ItemEditor.Edit_Name.hwnd, SubStr(aBack,3), SubStr(aFore,3))
    Else
        CtlColors.Detach(ItemEditor.Edit_Name.hwnd)
}


GUI_ItemEditor_BColor()
{
    Global ItemEditor
    If Dlg_Color(aBack,ItemEditor.Hwnd)
    {
        ItemEditor.Data.ColorBack := aBack
        aFore := ItemEditor.Data.ColorFore
        CtlColors.Change(ItemEditor.Edit_Name.hwnd, SubStr(aBack,3), SubStr(aFore,3))
    }
}

GUI_ItemEditor_TColor()
{
    Global ItemEditor
    If Dlg_Color(aFore, ItemEditor.Hwnd)
    {
        ItemEditor.Data.ColorFore := aFore
        aBack := ItemEditor.Data.ColorBack
        CtlColors.Change(ItemEditor.Edit_Name.hwnd, SubStr(aBack,3), SubStr(aFore,3))
    }
}


GUI_ItemEditor_SetCmdEvent()
{
    Global ItemEditor
    objGUI := GUI_ItemEditorCmd_Dump()
    If (objGUI.Data.Event = "Select")
    {
        ItemEditor.Edit_Name.SetText(objGUI.Data.Name)
        ItemEditor.Edit_Cmd.SetText(objGUI.Data.Command)
        ItemEditor.Edit_Param.SetText(objGUI.Data.Param)
    }
    Else
    {
        objGUI.Destroy()
    }
}

GUI_ItemEditor_ShowOrHideAdv(aState)
{
    Global ItemEditor
    Static HigthScroll := 290, SBI := 2, HigthShowAdv := 475, ButtonPos := 2
    If aState 
    {
        iHwnd := ItemEditor.Scroll.hwnd
        WinMove, ahk_id %iHwnd%, , , , , %HigthShowAdv%
        ItemEditor.Scroll.SetMax(SBI, HigthScroll)
        Toolbar_DeleteButton(ItemEditor.ToolbarAdv, ButtonPos)
        Toolbar_Insert(ItemEditor.ToolbarAdv, QZLang.ItemEditorHideAdv ", 4, , ", ButtonPos)
        ;Toolbar_Insert(ItemEditor.ToolbarAdv, "切换到AHK代码模式, 6, , ")
    }
    Else
    {
        iHwnd := ItemEditor.Scroll.hwnd
        WinMove, ahk_id %iHwnd%, , , , , 325
        GUI_ItemEditor_ScrollbarTop()
        ; 让滚动条消失
        ItemEditor.Scroll.SetMax(2, HigthScroll)
        Toolbar_DeleteButton(ItemEditor.ToolbarAdv, ButtonPos)
        Toolbar_Insert(ItemEditor.ToolbarAdv, QZLang.ItemEditorShowAdv ", 3, , ", ButtonPos)
    }
}

GUI_ItemEditor_ScrollbarTop()
{
    Global ItemEditor
    Static SB := 1
    iHwnd := ItemEditor.Scroll.hwnd
    ; 滚动栏到最顶端
    ItemEditor.Scroll.GetScrollInfo(SB, SI)
    PN := NumGet(SI, 20, "Int")
    DllCall("User32.dll\ScrollWindow", "Ptr", iHWND, "Int", 0, "Int", PN, "Ptr", 0, "Ptr", 0)
    ; 设置垂直滚动条的位置为0，避免出错
    ItemEditor.Scroll.PosV := 0
    ItemEditor.Scroll.SetScrollInfo(SB, {Pos:0})
}

_ScrollGUIClose:
    GUI2_HandlerSub(ItemEditor.CloseEvent)
return

GUI_SelectCategoryDo()
{
    Global ItemEditor, ItemEditorCode
    objGUI := GUI_ItemCategory_Dump()
    If IsObject(ItemEditor)
        ItemEditor.CategorySelect := objGUI.Select
    Else
        ItemEditorCode.CategorySelect := objGUI.Select
    GUI_ItemCategory_Destroy()
}

GUI_ItemEditor_CTLCOLOR(wParam, lParam, msg, hwnd)
{
    Global ItemEditor
    static hBrush := ""
    BkColor := ItemEditor.Data.ColorBack
    TxColor := ItemEditor.Data.ColorFore
    ;BkColor   := 0x5F67FA    ; Background Color | BGR (BLUE - GREEN - RED)
    ;TxColor   := 0xFFFFFF 
    ;Tooltip % ItemEditor.Data.ColorBack "`n" BkColor "`n" ItemEditor.Data.ColorFore "`n" TxColor
    If ItemEditor.IsLoad
    {
        if (hBrush = "")
            hBrush := DllCall("Gdi32.dll\CreateSolidBrush", "UInt", BkColor, "UPtr")
        If (lParam = ItemEditor.Edit_Name.hwnd)
        {
            DllCall("gdi32.dll\SetTextColor", "Ptr", wParam, "UInt", TxColor)
            DllCall("gdi32.dll\SetBkColor", "Ptr", wParam, "UInt", BkColor)
            DllCall("gdi32.dll\SetBkMode", "Ptr", wParam, "Int", 2)
            ;DllCall("User32.dll\InvalidateRect", "Ptr", ItemEditor.HWND, "Ptr", 0, "Int", 1)
            return hBrush
        }
    }
}

