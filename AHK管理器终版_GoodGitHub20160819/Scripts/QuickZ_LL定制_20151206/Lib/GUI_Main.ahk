

/* 
    Title:  主界面
        用于管理主界面的各函数
        
        由Toolbar+TreeView组成。

    Var: gQZConfig
        全局变量, 保存配置

    Var: gQZConfigPath
        配置文件的路径，默认在QuickZ\Config.json

    Var: GuiMain
        全局变量, GUI对象。

        GuiMain.Data - 用于根据TreeView Item的"ID"索引对应的菜单项
 */

/*
    Function: GUI_Main_Load
        加载界面

    Parameters: 
        无需参数

    Returns: 
        返回一个GUI对象

    Remarks: 
        无
*/

GUI_Main_Load()
{
    Global GuiMain
    OnMessage(WM_COPYDATA:=0x4A, "GUI_ReciveWMData")
    TBList := IL_Create(10, 10, 0)
    TVList := IL_Create(10, 10, 0)
    IL_Add(TBList, QZGlobal.DefaultIcl, 19)
    IL_Add(TBList, QZGlobal.DefaultIcl, 21)
    IL_Add(TBList, QZGlobal.DefaultIcl, 22)
    IL_Add(TBList, QZGlobal.DefaultIcl, 23)
    IL_Add(TBList, QZGlobal.DefaultIcl, 24)
    IL_Add(TBList, QZGlobal.DefaultIcl, 25)
    IL_Add(TBList, QZGlobal.DefaultIcl, 48)
    IL_Add(TBList, QZGlobal.DefaultIcl, 47)
    IL_Add(TBList, QZGlobal.DefaultIcl, 36)
    IL_Add(TBList, QZGlobal.DefaultIcl, 37)
    IL_Add(TBList, QZGlobal.DefaultIcl, 31)
    GuiMain := New GUI2("GuiMain", "+LastFound +Theme -DPIScale -Resize")
    GuiMain.TVListID := TVList
    GuiMain.Data := {} ; 保存数据
    GuiMain.TVIDs := {}
    GuiMain.Keymap := {} ; 保存热键映射列表
    GuiMain.GlobalKeys := {}
    GuiMain.MenuZKeys := {}
    GuiMain.VimDKeys := {}
    GuiMain.VimDKeysLV := {}
    GuiMain.Count := 0
    GuiMain.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    GuiMain.AddCtrl("Manager", "TreeView", "x5 y42 w450 h450 +Lines AltSubMit ")
    GuiMain.AddCtrl("KeyList", "ListView", "x212 y42 w1 h450 grid AltSubMit ", QZLang.TextListViewTitle)
    ;GuiMain.AddCtrl("Text_Search", "Text", "x215 y465 h26", QZLang.ButtonSearch)
    ;GuiMain.AddCtrl("Edit_Search", "Edit", "x270 y462 h26 w200")
    GuiMain.AddCtrl("SB", "StatusBar", "h40")
    GuiMain.KeyList.Hide()
    TV_SetImageList(TVList)
    LV_ModifyCol(1, "center 150")
    LV_ModifyCol(2, "center 250")
    LV_ModifyCol(3, "center 100")
    LV_ModifyCol(4, "600")
    TBMain := Toolbar_Add(GuiMain.hwnd, "GUI_Main_Event_Toolbar", "Flat Tooltips ", TBList, "x5 y4 w450 h35")
    GuiMain.Toolbar := TBMain
    ; 文件菜单
    Menu, MenuFile, add, % QZLang.ModuleMenuZ, _MenuMain
    Menu, MenuFile, add, % QZLang.ModuleVIMD, _MenuMain
    Menu, MenuFile, add, % QZLang.ModuleGesture, _MenuMain
    Menu, MenuFile, Disable, % QZLang.ModuleGesture
    Menu, MenuFile, add, % QZLang.ReloadQZ , _MenuMain
    Menu, MenuFile, add
    Menu, MenuFile, add, % QZLang.Rebuild , _MenuMain
    ;Menu, MenuFile, add, % QZLang.ExitQZ , GUI_ReloadQZ
    ;Menu, MenuFile, add, % QZLang.ReloadEditor , GUI_ReloadEditor
    Menu, MenuFile, add, % QZLang.ExitEditor , _MenuMain
    Menu, MenuMain, add, % QZLang.ButtonManager, :MenuFile
    Menu, MenuMain, add, % QZLang.ButtonEnv, _MenuMain
    Menu, MenuMain, add, % QZLang.ButtonBrowse, _MenuMain
    GuiMain.SetMenu("MenuMain")
    GuiMain.Show("w460 h520", QZLang.TitleEditor)
    GuiMain.Manager.OnEvent("GUI_Main_Event_TreeView")
    GuiMain.KeyList.OnEvent("GUI_Main_Event_ListView")
    GuiMain.OnSize("GUI_Main_ChangeSize")
    GuiMain.OnClose("GUI_ExitEditor")
    GuiMain.OnDropFiles("GUI_Main_DropFiles")
    SetExplorerTheme(GuiMain.Manager.hwnd) 
    xHotkey.IfWinActive("ahk_id " GuiMain.Hwnd)
    xHotkey("F1", "GUI_Main_LoadMenuZ")
    xHotkey("F2", "GUI_Main_LoadVIMD")
    xHotkey("F4", "GUI_ReloadQZ")
    xHotkey("esc", "GUI_Esc")
    GuiMain.GlobalKeys["c"] := "GUI_Main_MenuCopy"
    GuiMain.GlobalKeys["y"] := "GUI_Main_MenuCut"
    GuiMain.GlobalKeys["p"] := "GUI_Main_MenuPaste"
    GuiMain.GlobalKeys["u"] := "GUI_Main_MoveUp"
    GuiMain.GlobalKeys["d"] := "GUI_Main_MoveDown"
    GuiMain.GlobalKeys["j"] := "GUI_Main_MenuItemDown"
    GuiMain.GlobalKeys["k"] := "GUI_Main_MenuItemUp"
    GuiMain.GlobalKeys["h"] := "GUI_Main_MenuItemLeft"
    GuiMain.GlobalKeys["l"] := "GUI_Main_MenuItemRight"
    GuiMain.GlobalKeys["+j"] := "GUI_Main_MenuItemDownS"
    GuiMain.GlobalKeys["+k"] := "GUI_Main_MenuItemUps"
    GuiMain.GlobalKeys[","] := "GUI_Main_MenuItemDisable"
    GuiMain.GlobalKeys["."] := "GUI_Main_MenuItemHide"

    GuiMain.MenuZKeys["a"] := "GUI_Main_MenuItemAdd"
    GuiMain.MenuZKeys["s"] := "GUI_Main_MenuItemAddSub"
    GuiMain.MenuZKeys["i"] := "GUI_Main_MenuItemAddSep"
    GuiMain.MenuZKeys["x"] := "GUI_Main_MenuItemDelete"
    GuiMain.MenuZKeys["e"] := "GUI_Main_MenuItemEdit"
    GuiMain.MenuZKeys["f"] := "GUI_Main_MenuItemFilter"
    GuiMain.MenuZKeys["r"] := "GUI_Main_MenuItemProperty"

    GuiMain.VimDKeys["a"] := "GUI_Main_AddWin"
    GuiMain.VimDKeys["s"] := "GUI_Main_AddMode"
    GuiMain.VimDKeys["i"] := "GUI_Main_MenuItemAddSep"
    GuiMain.VimDKeys["x"] := "GUI_Main_DeleteWin"
    GuiMain.VimDKeys["e"] := "GUI_Main_ModifyWinOrMode"

    GuiMain.VimDKeysLV["j"] := "GUI_Main_LV_Down"
    ;GUI_Main_Bind(1, "m", "GUI_Main_MenuItemEdit")
    ;GUI_Main_Bind(1, "f", "GUI_Main_MenuItemFilter")
    ;GUI_Main_Bind(1, "r", "GUI_Main_MenuItemProperty")
    Return
    _MenuMain:
        ObjGUI := GUI_Main_Dump()
        If !ObjGUI.CtrlsDisable
        {
            If (A_ThisMenuItem = QZLang.ModuleMenuZ)
                GUI_Main_LoadMenuZ()
            If (A_ThisMenuItem = QZLang.ModuleVIMD)
                GUI_Main_LoadVIMD()
            If (A_ThisMenuItem = QZLang.ReloadQZ)
                GUI_ReloadQZ()
            If (A_ThisMenuItem = QZLang.Rebuild)
                GUI_Rebuild()
            If (A_ThisMenuItem = QZLang.ExitEditor)
                GUI_ExitEditor()
            If (A_ThisMenuItem = QZLang.ButtonEnv)
                GUI_EnvEditor_Load("","")
            If (A_ThisMenuItem = QZLang.ButtonBrowse)
                GUI_ItemSelector_Load("","")
        }
    Return
    
}

GUI_Main_Dump()
{
    Global GuiMain
    Return GuiMain
}

GUI_Editing_Disable()
{
    Global GuiMain
    GuiMain.CtrlsDisable := True
    GuiMain.Manager.Disable()
    GuiMain.KeyList.Disable()
    GuiMain.Edit_Search.Disable()
    GuiMain.Text_Search.Disable()
    Control, Disable, ,ToolbarWindow321, % "ahk_id " GuiMain.Hwnd
}

GUI_Editing_Enable()
{
    Global GuiMain
    GuiMain.CtrlsDisable  := False
    GuiMain.Manager.Enable()
    GuiMain.KeyList.Enable()
    GuiMain.Edit_Search.Enable()
    GuiMain.Text_Search.Enable()
    Control, Enable, ,ToolbarWindow321, % "ahk_id " GuiMain.Hwnd
}

GUI_Main_ChangeSize()
{
    Global GuiMain
    Return
    GuiMain.Default()
    MenuZMode := 1
    VimDMode  := 2
    If (GuiMain.EditMode = MenuZMode)
    {
        Anchor(GuiMain.Manager.Hwnd, "w h")
        Anchor(GuiMain.KeyList.Hwnd, "")
        Anchor(GuiMain.Edit_Search.Hwnd, "")
        Anchor(GuiMain.Text_Search.Hwnd, "")
    }
    Else If (GuiMain.EditMode = VimDMode)
    {
        Anchor(GuiMain.Manager.Hwnd, "h")
        Anchor(GuiMain.KeyList.Hwnd, "h w")
        Anchor(GuiMain.Edit_Search.Hwnd, "y")
        Anchor(GuiMain.Text_Search.Hwnd, "y")
    }
}

GUI_Main_DropFiles()
{
    Global GUIMain
    If GuiMain.CtrlsDisable
        Return
    GUI_Editing_Disable()
    objGUI := GUI_ItemEditor_Load("GUI_Main_MenuItemAddDo", "GUI_Main_MenuItemAddEnd")
    Loop, parse, A_GuiEvent, `n
    {
        SplitPath, A_LoopField, , , , FileName
        objGUI.Edit_Name.SetText(FileName)
        objGUI.Edit_Cmd.SetText(A_LoopField)
        Break
    }
}

GUI_Main_Bind(aMode, aKey, aFunc)
{
    Global GuiMain
    If !aMode
        GuiMain.GlobalKeys[aKey] := aFunc
    If (aMode = 1)
        GuiMain.MenuZKeys[aKey] := aFunc
    If (aMode = 2)
        GuiMain.VimDKeys[aKey] := aFunc
}


/*
    Function: GUI_Main_LoadMenuZ
        加载配置内容到界面中

    Parameters: 
        无参数

    Returns: 
        无返回
*/
GUI_Main_LoadMenuZ()
{
    Global GuiMain, gQZConfig
    If GuiMain.IsLoading
        Return
    GuiMain.IsLoading := True
    TBMain := GuiMain.Toolbar
    Toolbar_Clear(TBMain)
    Toolbar_Insert(TBMain, QZLang.TB_AddItem ", 1, , ")
    Toolbar_Insert(TBMain, QZLang.TB_AddSubItem ", 2, , ")
    Toolbar_Insert(TBMain, QZLang.TB_AddSep ", 3, , ")
    Toolbar_Insert(TBMain, QZLang.TB_DeleteItem ", 4, , Dropdown")
    Toolbar_Insert(TBMain, "-")
    Toolbar_Insert(TBMain, QZLang.TB_MoveUp ", 5, , ")
    Toolbar_Insert(TBMain, QZLang.TB_MoveDown ", 6, , ")
    Toolbar_Insert(TBMain, QZLang.TB_Disable ", 7, , ")
    Toolbar_Insert(TBMain, QZLang.TB_Hide ", 8, , ")
    Toolbar_SetMaxTextRows(TBMain, 0) 
    Toolbar_SetButtonSize(TBMain, 24, 24)
    ;xHotkey("a", BIND("GUI_Main_MenuItemAdd"))
    ;xHotkey("s", BIND("GUI_Main_MenuItemAddSub"))
    ;xHotkey("i", BIND("GUI_Main_MenuItemAddSep"))
    ;xHotkey("x", BIND("GUI_Main_MenuItemDelete"))
    ;xHotkey("e", BIND("GUI_Main_MenuItemEdit"))
    ;xHotkey("f", BIND("GUI_Main_MenuItemFilter"))
    ;xHotkey("r", BIND("GUI_Main_MenuItemProperty"))
    /*
    */
    ;Toolbar_AutoSize(TBMain)
    GuiMain.Default()
    gQZConfig := QZ_ReadConfig(QZGlobal.Config)
    TV_Delete()
    GUIMain.EditMode := 0
    GuiMain.Manager.Move("w450")
    GuiMain.KeyList.Move("w1")
    GuiMain.KeyList.Hide()
    GuiMain.Text_Search.Hide()
    GuiMain.Edit_Search.Hide()
    GuiMain.Move((A_ScreenWidth-462)/2,"",467,"")
    GUIMain.EditMode := 1
    GUIMain.TVColor := new TreeView(GuiMain.Manager.hwnd)
    GUI_Main_ChangeSize() ; 预先进行一次 Anchor，避免最大化时候出错。
    GUI_Main_LoadDataSub(gQZConfig.MenuZ, 0)
    GuiMain.IsLoading := False
}



GUI_Main_LoadVimd()
{
    Global GuiMain,gQZConfig
    If GuiMain.IsLoading
        Return
    GuiMain.IsLoading := True
    GuiMain.Default()
    TV_Delete()
    LV_Delete()
    GUIMain.EditMode := 0
    GuiMain.KeyList.Show()
    GuiMain.Text_Search.Show()
    GuiMain.Edit_Search.Show()
    GuiMain.Manager.Move("w200")
    GuiMain.KeyList.Move("w600")
    GuiMain.Move((A_ScreenWidth-825)/2,"",825,"")
    GUIMain.EditMode := 2
    TBMain := GuiMain.Toolbar
    Toolbar_Clear(TBMain)
    Toolbar_Insert(TBMain, QZLang.TB_AddWin ", 1, , ")
    Toolbar_Insert(TBMain, QZLang.TB_AddMode ", 2, , ")
    Toolbar_Insert(TBMain, QZLang.TB_Delete2 ", 4, , ")
    Toolbar_Insert(TBMain, "-")
    Toolbar_Insert(TBMain, QZLang.TB_MoveUp ", 5, , ")
    Toolbar_Insert(TBMain, QZLang.TB_MoveDown ", 6, , ")
    Toolbar_Insert(TBMain, QZLang.TB_Disable2 ", 7, , ")
    Toolbar_Insert(TBMain, "-")
    Toolbar_Insert(TBMain, QZLang.TB_AddKey ", 9, , ")
    Toolbar_Insert(TBMain, QZLang.TB_ModifyKey ", 10, , ")
    Toolbar_Insert(TBMain, QZLang.TB_DeleteKey ", 11, , ")
    Toolbar_SetMaxTextRows(TBMain, 0) 
    Toolbar_SetButtonSize(TBMain, 32, 32)
    GUI_Main_LoadDataSub(gQZConfig.Vimd, 0)
    GuiMain.IsLoading := False
}

/*
    Function: GUI_Main_LoadDataSub
        用于LoadData的子函数

    Parameters: 
        aObj - 保存菜单项的数组
        aParentID - 父项的ID，初始化为0

    Returns: 
        无
*/
GUI_Main_LoadDataSub(aObj, aParentID)
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    For idx, objMenu In aObj
    {
        NewID := GUI_Main_TreeViewUpdate(objMenu, TV_Add("", aParentID))
        If !strlen(objMenu.ID) && (GuiMain.EditMode = 1)
            objMenu.ID := UUIDCreate(1, "U")
    }
}

/*
    Function: GUI_Main_Event_TreeView
        执行TreeView事件

    Parameters: 
        无需参数

    右键菜单如下:
        编辑[功能项] - 如果有则修改，如果没有则新增
        筛选器 - 如果有则修改，如果没有则新增
        复制 - 复制当前项
        剪切 - 剪切当前项
        粘贴 - 粘贴当前项
        删除 - 删除当前项
        高级 - 高级功能（多筛选器+多功能项使用）
        属性 - 快速查看当前规则。
 */

GUI_Main_Event_TreeView()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    GuiMain.Manager.SetDefault()
    If (A_GuiEvent = "K")
    {
        ThisHotkey := chr(A_EventInfo)
        If RegExMatch(ThisHotkey, "^\d$")
        {
            GuiMain.Count := GuiMain.Count * 10 + ThisHotkey
            If GuiMain.Count > 99
                GuiMain.Count := 99
            Return
        }
        If !RegExMatch(ThisHotkey, "^[A-Z]$") || GuiMain.IsLoading
            Return
        If GetKeyState("Shift", "P")
            ThisHotkey := "+" ThisHotkey
        If !IsFunc(_func := GuiMain.GlobalKeys[ThisHotkey])
        {
            If (GuiMain.EditMode = 1)
                _func := GuiMain.MenuZKeys[ThisHotkey]
            If (GuiMain.EditMode = 2)
                _func := GuiMain.VimDKeys[ThisHotkey]
        }
        If IsFunc(_Func)
        {
            xCount := GuiMain.Count ? GuiMain.Count : 1
            Loop % xCount
            %_Func%()
            GuiMain.Count := 0
        }
    }
    If (A_GuiEvent = "S")
        GUI_Main_MenuItemSelected(A_EventInfo)
    If (GuiMain.EditMode = 1)
    {
        If (A_GuiEvent = "RightClick") && A_EventInfo
        {
            GuiMain.Data.SelectID := A_EventInfo
            TV_Modify(A_EventInfo, "+Select")
            SetTimer, _GUI_Main_ContextMenu, -1
        }
    }
    Else If (GuiMain.EditMode = 2)
    {
        If (A_GuiEvent = "S")
        {
            LV_Delete()
            If TV_GetParent(GuiMain.Data.SelectID)
            {
                GuiMain.Keymap := {}
                GuiMain.KeyList.SetDefault()
                For Index , Obj in GuiMain.Data[GuiMain.Data.SelectID].Maps
                    GUI_Main_ListViewUpdata(Obj, LV_Add(""))
            }
            LV_ModifyCol(1, "sort")
        }
        If (A_GuiEvent = "RightClick") && A_EventInfo
        {
            GuiMain.Data.SelectID := A_EventInfo
            TV_Modify(A_EventInfo, "+Select")
            SetTimer, _GUI_Main_ContextMenu, -1
        }
    }
    Return
    _GUI_Main_ContextMenu:
        GUI_Main_ContextMenu()
    Return
}

GUI_Main_Event_ListView()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    GuiMain.KeyList.SetDefault()
    If (A_GuiEvent = "K")
    {
    }
    If (A_GuiEvent = "RightClick") && A_EventInfo
    {
        Menu, Some, Add
        Menu, Some, DeleteAll
        Menu, Some, Add, % QZLang.CM_ModifyKey, __ContextMenuHandle
        Menu, Some, Add, % QZLang.CM_DeleteKey, __ContextMenuHandle
        Menu, Some, Show
    }
}

GUI_Main_MenuItemSelected(aID)
{
    Global GuiMain, gQZConfig
    GuiMain.Data.SelectID := aID
    objFilter := GuiMain.Data[GuiMain.Data.SelectID].Filter
    newSB := ""
    Loop % ObjFilter.MaxIndex()
        newSB .= gQZConfig.Filters[objFilter[A_Index]].name "`;"
    newSB := SubStr(newSB, 1, StrLen(newSB)-1)
    SB_SetText(" 筛选器: " newSB)
}

GUI_Main_ContextMenu()
{
    Global GuiMain, gQZConfig
    If (GUIMain.EditMode = 1)
    {
        Menu, Some, Add
        Menu, Some, DeleteAll
        Menu, Some, Add, % QZLang.CM_Edit, __ContextMenuHandle
        Menu, Some, Add, % QZLang.CM_Filter, __ContextMenuHandle
        Menu, Some, Add
        Menu, Some, Add, % QZLang.CM_Cut, __ContextMenuHandle
        Menu, Some, Add, % QZLang.CM_Copy, __ContextMenuHandle
        Menu, Some, Add, % QZLang.CM_Paste, __ContextMenuHandle
        Menu, Some, Add, % QZLang.CM_Delete, __ContextMenuHandle
        Menu, Some, Add
        Menu, Some, Add, % QZLang.CM_Property, __ContextMenuHandle
        Menu, Some, Show
    }
    Else If (GUIMain.EditMode = 2)
    {
        Menu, Some, Add
        Menu, Some, DeleteAll
        GuiMain.Default()
        If TV_GetParent(GuiMain.Data.SelectID)
            Menu, Some, Add, % QZLang.CM_Edit3, __ContextMenuHandle
        Else
            Menu, Some, Add, % QZLang.CM_Edit2, __ContextMenuHandle
        Menu, Some, Add
        Menu, Some, Add, % QZLang.CM_Cut, __ContextMenuHandle
        Menu, Some, Add, % QZLang.CM_Copy, __ContextMenuHandle
        Menu, Some, Add, % QZLang.CM_Paste, __ContextMenuHandle
        Menu, Some, Add, % QZLang.CM_Delete, __ContextMenuHandle
        Menu, Some, Show
    }
    Return
    __ContextMenuHandle:
        If (A_ThisMenuItem = QZLang.CM_Edit)
            GUI_Main_MenuItemEdit() 
        Else If (A_ThisMenuItem = QZLang.CM_Filter)
            GUI_Main_MenuItemFilter()
        Else If (A_ThisMenuItem = QZLang.CM_Property)
            GUI_Main_MenuItemProperty()
        Else If (A_ThisMenuItem = QZLang.CM_Edit2)
            GUI_Main_ModifyWin()
        Else If (A_ThisMenuItem = QZLang.CM_Edit3)
            GUI_Main_ModifyMode()
        Else If (A_ThisMenuItem = QZLang.CM_ModifyKey)
            GUI_Main_ModifyKey()
        Else If (A_ThisMenuItem = QZLang.CM_DeleteKey)
            GUI_Main_DeleteKey()
        Else If (A_ThisMenuItem = QZLang.CM_Copy)
                GUI_Main_MenuCopy()
        Else If (A_ThisMenuItem = QZLang.CM_Cut)
                GUI_Main_MenuCut()
        Else If (A_ThisMenuItem = QZLang.CM_Paste)
        {
            If (GuiMain.EditMode = 1)
                GUI_Main_MenuPaste()
            If (GuiMain.EditMode = 2)
                GUI_Main_VimdPaste()
        }
        Else If (A_ThisMenuItem = QZLang.CM_Delete)
        {
            If (GuiMain.EditMode = 1)
                GUI_Main_MenuItemDelete()
            If (GuiMain.EditMode = 2)
                GUI_Main_DeleteWin()
        }
        Else If (A_ThisMenuItem = QZLang.CM_Cut)
        {
            If (GuiMain.EditMode = 1)
                GUI_Main_MenuCut()
        }
        Else If (A_ThisMenuItem = QZLang.CM_Paste)
        {
            If (GuiMain.EditMode = 1)
                GUI_Main_MenuPaste()
        }
        Else If (A_ThisMenuItem = QZLang.CM_Delete)
        {
            If (GuiMain.EditMode = 1)
                GUI_Main_MenuItemDelete()
            If (GuiMain.EditMode = 2)
                GUI_Main_DeleteWin()
        }
    Return
}

GUI_Main_MenuItemProperty()
{
    Global GuiMain
    GUI_ItemProperty_Load("")
    GUI_ItemProperty_LoadData(GuiMain.Data[GuiMain.Data.SelectID])
}

GUI_Main_MenuItemFilter()
{
    Global GuiMain
    GUI_Editing_Disable()
    objMenu := GuiMain.Data[GuiMain.Data.SelectID]
    GUI_FilterMgr_Load("GUI_Main_MenuFilter", "GUI_Main_MenuFilterEnd")
    GUI_FilterMgr_LoadData(objMenu)
}

GUI_Main_MenuItemEdit()
{
    Global GuiMain, gQZConfig
    objMenu := GuiMain.Data[GuiMain.Data.SelectID]
    If Strlen(objMenu.UUID)
    {
        GUI_Editing_Disable()
        If objMenu.Options.Type && IsObject(objMenu.SubItem[1])
        {
            GUI_GroupEditor_Load("GUI_Main_MenuGroupModify", "GUI_Main_MenuGroupModifyEnd")
            GUI_GroupEditor_LoadData(objMenu)
        }
        Else
        {
            ;If gQZConfig.Items[objMenu.UUID].Options.CodeMode
                ;GUI_ItemEditorCode_Load("GUI_Main_MenuItemModify", objMenu, "GUI_Main_MenuItemModifyEnd2")
            ;Else
            GUI_ItemEditor_Load("GUI_Main_MenuItemModify", "GUI_Main_MenuItemModifyEnd", gQZConfig.Items[objMenu.UUID].Options.CodeMode)
            GUI_ItemEditor_LoadData(objMenu)
        }
    }
}

GUI_Main_MenuItemDown()
{
    Global GuiMain
    GuiMain.Default()
    SelectID := TV_GetSelection()
    If TV_Get(SelectID, "Expand")
        NextID := TV_GetNext(SelectID, "F")
    Else
        NextID := TV_GetNext(SelectID)
    If !NextID
    {
        ParentID := SelectID
        Loop
        {
            if (NextID := TV_GetNext(TV_GetParent(ParentID)))
                break
            else
                ParentID := TV_GetParent(ParentID)
        }
    }
    If NextID && TV_GetNext(SelectID, "F")
        GuiMain.Data.SelectID := TV_Modify(NextID, "select")
}

GUI_Main_MenuItemDownS()
{
    Global GuiMain
    GuiMain.Default()
    SelectID := TV_GetNext(TV_GetSelection())
    If SelectID
        GuiMain.Data.SelectID := TV_Modify(SelectID, "Select")
}

GUI_Main_MenuItemUpS()
{
    Global GuiMain
    GuiMain.Default()
    SelectID := TV_GetPrev(TV_GetSelection())
    If SelectID
        GuiMain.Data.SelectID := TV_Modify(SelectID, "Select")
}

GUI_Main_MenuItemUp()
{
    Global GuiMain
    GuiMain.Default()
    SelectID := TV_GetSelection()
    PrevID := TV_GetPrev(SelectID)
    If !PrevID
        PrevID := TV_GetParent(SelectID)
    else
    {
        If TV_Get(PrevID, "Expand") && TV_GetChild(PrevID)
        {
            Loop
            {
                ChildID := TV_GetChild(PrevID)
                Loop
                {
                    PrevID := ChildID
                    ChildID := TV_GetNext(ChildID)
                    If !ChildID
                        break
                }
                if !TV_Get(PrevID, "Expand")
                    break
                if !TV_GetChild(PrevID) 
                    break
            }
        }
    }
    If PrevID
        GuiMain.Data.SelectID := TV_Modify(PrevID, "select")
}

GUI_Main_MenuItemLeft()
{
    Global GuiMain
    GuiMain.Default()
    If !TV_Modify(TV_GetSelection(), "-Expand")
        If ParentID := TV_GetParent(TV_GetSelection())
            GuiMain.Data.SelectID := TV_Modify(ParentID, "select")
}

GUI_Main_MenuItemRight()
{
    Global GuiMain
    GuiMain.Default()
    if TV_Get(TV_GetSelection(), "Expand")
        GuiMain.Data.SelectID := TV_Modify(TV_GetChild(TV_GetSelection()), "select")
    else
        TV_Modify(TV_GetSelection(), "Expand")
}

/*
    Function: GUI_Main_Event_Toolbar
        响应Toolbar事件

    Parameters: 
        aCtrl - Toolbar的HWND值
        aEvent - Toolbar事件
        aTxt - 按钮的名称
        aPos - 按钮的序号

    Returns: 
        无返回
*/
GUI_Main_Event_Toolbar(aCtrl, aEvent, aTxt, aPos)
{
    Global GuiMain, gQZConfig
    If (aCtrl = GuiMain.Toolbar) && (aEvent = "Click")
    {
        If (aTxt = QZLang.TB_AddItem)
            GUI_Main_MenuItemAdd()
        If (aTxt = QZLang.TB_AddSubItem)
            GUI_Main_MenuItemAddSub()
        If (aTxt = QZLang.TB_AddSep)
            GUI_Main_MenuItemAddSep()
        If (aTxt = QZLang.TB_DeleteItem)
            GUI_Main_MenuItemDelete()
        If (aTxt = QZLang.TB_MoveUp)
            GUI_Main_MoveUp()
        If (aTxt = QZLang.TB_MoveDown)
            GUI_Main_MoveDown()
        If (aTxt = QZLang.TB_Disable)
            GUI_Main_MenuItemDisable()
        If (aTxt = QZLang.TB_Hide)
            GUI_Main_MenuItemHide()
        If (aTxt = QZLang.TB_AddWin)
            Gui_Main_AddWin()
        If (aTxt = QZLang.TB_AddMode)
            Gui_Main_AddMode()
        If (aTxt = QZLang.TB_Delete2)
            Gui_Main_DeleteWin()
        If (aTxt = QZLang.TB_Disable2)
            GUI_Main_DisableWin()
        If (aTxt = QZLang.TB_AddKey)
            GUI_Main_AddKey()
        If (aTxt = QZLang.TB_ModifyKey)
            GUI_Main_ModifyKey()
        If (aTxt = QZLang.TB_DeleteKey)
            GUI_Main_DeleteKey()
    }
    If (aTxt = QZLang.TB_DeleteItem) && (aEvent = "Menu")
    {
        MainHwnd := GUIMain.hwnd
        CoordMode, Menu, Screen
        WinGetPos, GuiX, GuiY, , ,  ahk_id %MainHwnd%
        ControlGetPos, TBX, TBY, , , ToolbarWindow321, ahk_id %MainHwnd%
        TBH := Toolbar_GetRect(GuiMain.Toolbar, aPos, "h")
        TBW := Toolbar_GetRect(GuiMain.Toolbar, aPos, "x")
        PosX := GuiX + TBX + TBW
        PosY := GuiY + TBY + TBH
        Menu, _TBCMDMenu, Add
        Menu, _TBCMDMenu, DeleteAll
        Menu, _TBCMDMenu, Add, % QZLang.ButtonForceDelete, _TBMainMenu_DO
        Menu, _TBCMDMenu, Show, %PosX%, %PosY%
        Return
        _TBMainMenu_DO:
            If Strlen(strUUID := GUI_Main_MenuItemDelete())
                gQZConfig.Items.Delete(strUUID)
        Return
    }
}

GUI_Main_MenuCopy()
{
    Global GuiMain
    GuiMain.Default()
    GuiMain.CopySelectID := TV_GetSelection()
    GuiMain.IsCut := False
}

GUI_Main_MenuCut()
{
    Global GuiMain
    GuiMain.Default()
    GuiMain.CopySelectID := TV_GetSelection()
    GuiMain.IsCut := True
}

GUI_Main_MenuPaste()
{
    Global GuiMain, gQZConfig
    If !GuiMain.CopySelectID
        Return
    GuiMain.Default()
    strUUID := UUIDCreate(1, "U")
    objMenu := ObjectCopy(GuiMain.Data[GuiMain.CopySelectID])
    objItem := ObjectCopy(gQZConfig.Items[objMenu.UUID])
    gQZConfig.Items[strUUID] := objItem
    objMenu.UUID := strUUID
    objMenu.ID := UUIDCreate(1, "U")
    SelectID := TV_GetSelection()
    ParentID := TV_GetParent(SelectID)
    aID := TV_Add("", ParentID, SelectID " Select Vis")
    If ParentID
    {
        If !IsObject(GuiMain.Data[ParentID].SubItem)
            GuiMain.Data[ParentID].SubItem := {}
        ParentObj := GuiMain.Data[ParentID].SubItem
    }
    Else
    {
        ParentObj := gQZConfig.MenuZ
    }
    ; 增加到主界面中的TreeView控件
    GuiMain.Manager.SetDefault()
    If (Pos:=TV_GetPos(ParentID, aID))
    {
        ParentObj.Insert(Pos, ObjMenu)
        GUI_Main_TreeViewUpdate(objMenu, aID)
    }
    If GuiMain.IsCut
    {
        SelectID := GuiMain.CopySelectID
        ParentID := TV_GetParent(GuiMain.CopySelectID)
        If ParentID
        {
            ParentObj := GuiMain.Data[ParentID].SubItem
            ParentObj.RemoveAt(TV_GetPos(ParentID, SelectID))
            If !IsObject(ParentObj[1])
            {
                GuiMain.Data[ParentID].Options.Type := 0
                objItem := gQZConfig.Items[GuiMain.Data[ParentID].UUID]
                objItem.Options.IsGroup := False
            }
        }
        Else
        {
            ParentObj := gQZConfig.MenuZ
            ParentObj.RemoveAt(TV_GetPos(ParentID, SelectID))
        }
        gQZConfig.Items.Remove(GuiMain.Data[SelectID].UUID)
        TV_Delete(SelectID)
        GuiMain.CopySelectID := 0
    }
    GUI_Save()
}

GUI_Main_VimdPaste()
{
    Global GuiMain, gQZConfig
    If !GuiMain.CopySelectID
        Return
    GuiMain.Default()
    GuiMain.Manager.SetDefault()
    objWin := ObjectCopy(GuiMain.Data[GuiMain.CopySelectID])
    ; 源是win对象
    SelectID := TV_GetSelection() 
    ParentID := TV_GetParent(SelectID)
    If IsObject(ObjWin.Modes)
    {
        If ( ParentID <> 0 )
        {
            SelectID := ParentID
            ParentID := 0
        }
        ParentObj := gQZConfig.Vimd
    }
    Else ; 源是mode对象
    {
        If !ParentID
        {
            ParentID := SelectID
            SelectID := TV_GetChild(SelectID)
        }
        ParentObj := GuiMain.Data[ParentID].Modes
    }

    newID := GUI_Main_TreeViewUpdate(objWin, TV_Add("", ParentID, SelectID " Select") )
    Pos := TV_GetPos(ParentID, newID)
    ParentObj.Insert(Pos, objWin)

    If GuiMain.IsCut
    {
        SelectID := GuiMain.CopySelectID
        ParentID := TV_GetParent(SelectID)
        If !ParentID
        {
            Pos := TV_GetPos(ParentID, SelectID)
            gQZConfig.Vimd.RemoveAt(Pos)
        }
        Else
        {
            Pos := TV_GetPos(ParentID, SelectID)
            ParentObj := GuiMain.Data[ParentID]
            ParentObj.Modes.RemoveAt(Pos)
        }
        TV_Delete(SelectID)
        GuiMain.CopySelectID := 0
    }
    GUI_Save()
}

GUI_Main_MenuItemAdd()
{
    GUI_Editing_Disable()
    GUI_ItemEditor_Load("GUI_Main_MenuItemAddDo", "GUI_Main_MenuItemAddEnd")
}

GUI_Main_MenuItemAddDo()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    SelectID := TV_GetSelection()
    ParentID := TV_GetParent(SelectID)
    aID := TV_Add("", ParentID, SelectID " Select Vis")
    GUI_Main_MenuItemDo(aID, ParentID)
}

GUI_Main_MenuFilter()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    objMenu := GuiMain.Data[TV_GetSelection()]
    GUI_FilterMgr_Save(objMenu)
    GuiMain.Data[TV_GetSelection()]:= objMenu
    GUI_Save()
    GUI_Main_MenuFilterEnd()
}

GUI_Main_MenuFilterEnd()
{
    Global GuiMain
    GUI_Editing_Enable()
    Gui_FilterMgr_Destroy()
}

GUI_Main_MenuItemAddSub()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    SelectID := TV_GetSelection()
    ParentID := SelectID
    objMenu := GuiMain.Data[SelectID]
    If objMenu.UUID
    {
        GUI_Editing_Disable()
        GUI_ItemEditor_Load("GUI_Main_MenuItemAddSubDo", "GUI_Main_MenuItemAddEnd")
    }
}

GUI_Main_MenuItemAddEnd()
{
    Global GuiMain
    GUI_Editing_Enable()
    Gui_ItemEditor_Destroy()
}

GUI_Main_MenuItemAddSubDo()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    SelectID := TV_GetSelection()
    ParentID := SelectID
    objMenu := GuiMain.Data[SelectID]
    objItem := gQZConfig.Items[objMenu.UUID]
    objItem.Options.IsGroup := True
    objMenu.Options.Type := 1
    SubID := TV_Add("", ParentID, SelectID " Select Vis" )
    GUI_Main_MenuItemDo(SubID, ParentID)
}


GUI_Main_MenuItemAddSep()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    SelectID := TV_GetSelection()
    ParentID := TV_GetParent(SelectID)
    TID := TV_Add("", ParentID, SelectID " Select Vis")
    objMenu := QZ_CreateConfig_MenuItem(IsSep:=True)
    If ParentID
    {
        If !IsObject(GuiMain.Data[ParentID].SubItem)
            GuiMain.Data[ParentID].SubItem := {}
        ParentObj := GuiMain.Data[ParentID].SubItem
    }
    Else
    {
        ParentObj := gQZConfig.MenuZ
    }
    GuiMain.Manager.SetDefault()
    If (Pos := TV_GetPos(ParentID, TID))
    {
        ParentObj.Insert(Pos, ObjMenu)
        GUI_Main_TreeViewUpdate(objMenu, TID)
        GUI_Save()
    }
}

GUI_Main_MenuItemDo(aID, ParentID)
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    ; 初始化数据
    strUUID := UUIDCreate(1, "U")
    objItem := QZ_CreateConfig_Item()
    objMenu := QZ_CreateConfig_MenuItem()
    ; 将数据保存到对应的数据里
    gQZConfig.Items[strUUID] := objItem
    objMenu.UUID := strUUID
    ; 读取ItemEditor中的配置
    objGUI  := GUI_ItemEditor_Dump()
    If objGUI.CodeMode
    {
        objGUI := GUI_ItemEditorCode_Dump()
        GUI_ItemEditorCode_Save(objMenu)
    }
    else
    {
        GUI_ItemEditor_Save(objMenu)
    }
    ; 保存到gQZConfig.MenuZ中
    If ParentID
    {
        If !IsObject(GuiMain.Data[ParentID].SubItem)
            GuiMain.Data[ParentID].SubItem := {}
        ParentObj := GuiMain.Data[ParentID].SubItem
    }
    Else
    {
        ParentObj := gQZConfig.MenuZ
    }
    ; 销毁ItemEditor界面
    GUI_Main_MenuItemAddEnd()
    ; 增加到主界面中的TreeView控件
    GuiMain.Manager.SetDefault()
    If (Pos:=TV_GetPos(ParentID, aID))
    {
        ParentObj.Insert(Pos, ObjMenu)
        GUI_Main_TreeViewUpdate(objMenu, aID)
        GUI_Save()
    }
    Return objMenu
}

GUI_Main_MenuItemDelete()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    SelectID := GuiMain.Data.SelectID
    strUUID := GuiMain.Data[SelectID].UUID
    objItem := gQZConfig.Items[strUUID]
    ;If !Strlen(strUUID)
        ;Return
    MsgBox, 4, QuickZ, % "Confirm Delete """ objItem.Name """ ?"
    IfMsgBox, No
        Return
    ParentID := TV_GetParent(SelectID)
    If ParentID
    {
        ParentObj := GuiMain.Data[ParentID].SubItem
        ParentObj.RemoveAt(TV_GetPos(ParentID, SelectID))
        If !IsObject(ParentObj[1])
        {
            GuiMain.Data[ParentID].Options.Type := 0
            objItem := gQZConfig.Items[GuiMain.Data[ParentID].UUID]
            objItem.Options.IsGroup := False
        }
    }
    Else
    {
        ParentObj := gQZConfig.MenuZ
        ParentObj.RemoveAt(TV_GetPos(ParentID, SelectID))
    }
    TV_Delete(SelectID)
    GUI_Save()
    Return strUUID
}


/*
    Function: GUI_Main_MenuItemModify
        保存已修改的菜单项，并加载到主界面中。
    Parameters: 
        无
    Returns: 
        无
 */
GUI_Main_MenuItemModify()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    objGUI := GUI_ItemEditor_Dump()
    objMenu := GuiMain.Data[GuiMain.Data.SelectID]
    GUI_ItemEditor_Save(objMenu)
    ;msgbox % json.dump(objMenu, 2)
    GUI_Main_MenuItemModifyEnd()
    GUI_Main_TreeViewUpdate(objMenu, GuiMain.Data.SelectID)
    GUI_Save()
}

GUI_Main_MenuItemModifyEnd()
{
    Global GuiMain
    GUI_Editing_Enable()
    GUI_ItemEditor_Destroy()
}

GUI_Main_MenuItemModifyEnd2()
{
    Global GuiMain
    GUI_ItemEditorCode_Destroy()
}

GUI_Main_MenuGroupModify()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    objGUI := GUI_GroupEditor_Dump()
    objMenu := GuiMain.Data[GuiMain.Data.SelectID]
    GUI_GroupEditor_Save(objMenu)
    GUI_Main_MenuGroupModifyEnd()
    GUI_Main_TreeViewUpdate(objMenu, GuiMain.Data.SelectID)
    GUI_Save()
}

GUI_Main_MenuGroupModifyEnd()
{
    Global GuiMain
    GUI_Editing_Enable()
    Gui_GroupEditor_Destroy()
}

GUI_Main_MoveDown()
{
    Global GuiMain, gQZConfig 
    GuiMain.Default()
    GuiMain.Manager.SetDefault()
    SelectID := TV_GetSelection()
    NextID := TV_GetNext(SelectID)
    ParentID := TV_GetParent(SelectID)
    Pos1 := TV_GetPos(ParentID, SelectID)
    Pos2 := TV_GetPos(ParentID, NextID)
    If (GuiMain.EditMode = 1)
        cons_Enum := {"Sub":"SubItem", "Obj":"MenuZ"}
    Else If (GuiMain.EditMode = 2)
        cons_Enum := {"Sub":"Modes", "Obj":"VimD"}
    If ParentID
    {
        If !IsObject(GuiMain.Data[ParentID][cons_Enum.Sub])
            GuiMain.Data[ParentID][cons_Enum.Sub] := {}
        ParentObj := GuiMain.Data[ParentID][cons_Enum.Sub]
    }
    Else
    {
        ParentObj := gQZConfig[cons_Enum.Obj]
    }
    If SelectID && NextID
    {
        objItem1 := GuiMain.Data[SelectID]
        objItem2 := GuiMain.Data[NextID]
        GUI_Main_TreeViewUpdate(objItem2, SelectID) 
        TV_Modify(GUI_Main_TreeViewUpdate(objItem1, NextID), "Select")
        ParentObj[Pos1] := objItem2
        ParentObj[Pos2] := objItem1
        GUI_Save()
    }
}

GUI_Main_MoveUp()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    GuiMain.Manager.SetDefault()
    SelectID := TV_GetSelection()
    PrevID := TV_GetPrev(SelectID)
    ParentID := TV_GetParent(SelectID)
    Pos1 := TV_GetPos(ParentID, SelectID)
    Pos2 := TV_GetPos(ParentID, PrevID)
    If (GuiMain.EditMode = 1)
        cons_Enum := {"Sub":"SubItem", "Obj":"MenuZ"}
    Else If (GuiMain.EditMode = 2)
        cons_Enum := {"Sub":"Modes", "Obj":"VimD"}
    If ParentID
    {
        If !IsObject(GuiMain.Data[ParentID][cons_Enum.Sub])
            GuiMain.Data[ParentID][cons_Enum.Sub] := {}
        ParentObj := GuiMain.Data[ParentID][cons_Enum.Sub]
    }
    Else
    {
        ParentObj := gQZConfig[cons_Enum.obj]
    }
    If SelectID && PrevID
    {
        objItem1 := GuiMain.Data[SelectID]
        objItem2 := GuiMain.Data[PrevID]
        GUI_Main_TreeViewUpdate(objItem2, SelectID) 
        TV_Modify(GUI_Main_TreeViewUpdate(objItem1, PrevID), "Select")
        ParentObj[Pos1] := objItem2
        ParentObj[Pos2] := objItem1
        GUI_Save()
    }
}

GUI_Main_MenuItemDisable()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    SelectID := TV_GetSelection()
    objMenu := GuiMain.Data[SelectID]
    objMenu.Options.Disable := !objMenu.Options.Disable
    GuiMain.Data[SelectID] := objMenu
    GUI_Main_TreeViewUpdate(objMenu, SelectID)
    GUI_Save()
}

GUI_Main_MenuItemHide()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    SelectID := TV_GetSelection()
    objMenu := GuiMain.Data[SelectID]
    objMenu.Options.Hide := !objMenu.Options.Hide
    GuiMain.Data[SelectID] := objMenu
    GUI_Main_TreeViewUpdate(objMenu, SelectID)
    GUI_Save()
}

Gui_Main_AddWin()
{
    Global GuiMain
    GUI_Editing_Disable()
    GUI_WinEditor_Load("GUI_Main_AddWinDo", "GUI_Main_AddWinEnd")
}

GUI_Main_AddWinEnd()
{
    GUI_Editing_Enable()
    GUI_WinEditor_Destroy()
}

GUI_Main_ModifyWinOrMode()
{
    Global GuiMain
    If TV_GetParent(GuiMain.Data.SelectID)
        GUI_Main_ModifyMode()
    Else
        GUI_Main_ModifyWin()
}

Gui_Main_ModifyWin()
{
    Global GuiMain
    GUI_Editing_Disable()
    GuiMain.Default()
    GuiMain.Manager.SetDefault()
    GUI_WinEditor_Load("GUI_Main_ModifyWinDo", "GUI_Main_ModifyWinEnd")
    GUI_WinEditor_LoadData(GuiMain.Data[GuiMain.Data.SelectID])
}

GUI_Main_ModifyWinEnd()
{
    Global GuiMain
    GUI_Editing_Enable()
    GUI_WinEditor_Destroy()
}

GUI_Main_ModifyWinDo()
{
    Global GuiMain, gQZConfig
    objWin := GuiMain.Data[GuiMain.Data.SelectID]
    GUI_WinEditor_Save(objWin)
    GUI_Main_ModifyWinEnd()
    GUI_Main_TreeViewUpdate(objWin, GuiMain.Data.SelectID, " Select")
    GUI_Save()
}

GUI_Main_AddWinDo()
{
    Global GuiMain, gQZConfig
    GUI_Editing_Enable()
    objWin := QZ_CreateConfig_VimWin()
    objMode := QZ_CreateConfig_VimMode()
    objMode.Name := QZLang.TextNormalMode
    objWin.Modes[1] := objMode
    GUI_WinEditor_Save(objWin)
    GUI_Main_AddWinEnd()
    GuiMain.Default()
    GuiMain.Manager.SetDefault()
    SelectID := TV_GetSelection() 
    ParentID := TV_GetParent(SelectID)
    If ParentID <> 0
    {
        SelectID := ParentID
        ParentID := 0
    }
    newID := GUI_Main_TreeViewUpdate(objWin, TV_Add("", 0, SelectID " Select") )
    Pos := TV_GetPos(ParentID, newID)
    gQZConfig.Vimd.Insert(Pos, objWin)
    GUI_Save()
}

GUI_Main_DeleteWin()
{
    Global GuiMain, gQZConfig
    objWin := GuiMain.Data[GuiMain.Data.SelectID]
    GuiMain.Default()
    GuiMain.Manager.SetDefault()
    If !(ParentID:=TV_GetParent(GuiMain.Data.SelectID))
    {
        Pos := TV_GetPos(ParentID, GuiMain.Data.SelectID)
        gQZConfig.Vimd.RemoveAt(Pos)
    }
    Else
    {
        ParentObj := GuiMain.Data[ParentID]
        Pos := TV_GetPos(ParentID, GuiMain.Data.SelectID)
        ParentObj.Modes.RemoveAt(Pos)
    }
    TV_Delete(GuiMain.Data.SelectID)
    GUI_Save()
}

GUI_Main_DisableWin()
{
    Global GuiMain
    GuiMain.Default()
    SelectID := GuiMain.Data.SelectID
    objWin := GuiMain.Data[SelectID]
    If !IsObject(objWin.Options)
        objWin.Options := {}
    objWin.Options.Disable := !objWin.Options.Disable
    GuiMain.Data[SelectID] := objWin
    GUI_Main_TreeViewUpdate(objWin, SelectID)
    GUI_Save()
}

Gui_Main_AddMode()
{
    GUI_Editing_Disable()
    GUI_ModeEditor_Load("GUI_Main_AddModeDo", "GUI_Main_AddModeEnd")
    
}

GUI_Main_AddModeDo()
{
    Global GuiMain, gQZConfig
    objMode := QZ_CreateConfig_VimMode()
    GUI_ModeEditor_Save(objMode)
    GUI_Main_AddModeEnd()
    GuiMain.Default()
    GuiMain.Manager.SetDefault()
    If (SelectID := TV_GetSelection()) 
    {

        If (ParentID := TV_GetParent(SelectID))
            NewID := TV_Add("", ParentID, SelectID)
        Else
            NewID := TV_Add("", SelectID, "")
        GUI_Main_TreeViewUpdate(objMode,  NewID,"Vis Select")
        ParentObj := GuiMain.Data[ParentID]
        If !IsObject(ParentObj.Modes)
            ParentObj.Modes := {}
        ParentObj.Modes.Insert(objMode)
        GUI_Save()
    }
}

GUI_Main_AddModeEnd()
{
    Global GuiMain
    GUI_Editing_Enable()
    GUI_ModeEditor_Destroy()
}

Gui_Main_ModifyMode()
{
    Global GuiMain
    GUI_Editing_Disable()
    GuiMain.Manager.SetDefault()
    GUI_ModeEditor_Load("GUI_Main_ModifyModeDo", "GUI_Main_ModifyModeEnd")
    GUI_ModeEditor_LoadData(GuiMain.Data[GuiMain.Data.SelectID])
}

GUI_Main_ModifyModeDo()
{
    Global GuiMain, gQZConfig
    objGUI := GUI_ModeEditor_Dump()
    objMode := GuiMain.Data[GuiMain.Data.SelectID]
    GUI_ModeEditor_Save(objMode)
    GUI_Main_ModifyModeEnd()
    GUI_Main_TreeViewUpdate(objMode, GuiMain.Data.SelectID, " Select")
    GUI_Save()
}

GUI_Main_ModifyModeEnd()
{
    Global GuiMain
    GUI_Editing_Enable()
    GUI_ModeEditor_Destroy()
}

GUI_Main_AddKey()
{
    Global GuiMain
    GuiMain.Default()
    If TV_GetParent(GuiMain.Data.SelectID)
    {
        GUI_Editing_Disable()
        GUI_Keymap_Load("GUI_Main_AddKeyDo", "GUI_Main_AddKeyEnd")
    }
}

GUI_Main_AddKeyEnd()
{
    GUI_Editing_Enable()
    GUI_Keymap_Destroy()
}

GUI_Main_AddKeyDo()
{
    Global GuiMain
    objGUI := GUI_Keymap_Dump()
    If !Strlen(objGui.Edit_Name.GetText())
    {
        Msgbox Please Input Key Name !
        Return
    }
    objKey := QZ_CreateConfig_VimKey()
    GUI_Keymap_Save(objKey)
    GuiMain.Default()
    objMode := GuiMain.Data[GuiMain.Data.SelectID]
    If !IsObject(objMode.Maps)
        objMode.Maps := []
    objMode.Maps.Insert(objKey)
    GuiMain.KeyList.SetDefault()
    newID := LV_Add("", "","","","")
    Gui_Main_ListViewUpdata(ObjKey, newID, Option:="select")
    GUI_Save()
    GUI_Editing_Enable()
    GUI_Main_AddKeyEnd()
}

GUI_Main_ModifyKey()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    If TV_GetParent(GuiMain.Data.SelectID)
    {
        GUI_Editing_Disable()
        RowNum := LV_GetNext(0, "F")
        LV_GetText(strKey, RowNum, 1)
        LV_GetText(strAct, RowNum, 2)
        objKey := GuiMain.Keymap[strKey A_Tab strAct]
        GUI_Keymap_Load("GUI_Main_ModifyKeyDo", "GUI_Main_ModifyKeyEnd")
        GUI_Keymap_LoadData(objKey)
    }
}

GUI_Main_ModifyKeyEnd()
{
    Global GuiMain
    GUI_Editing_Enable()
    GUI_Keymap_Destroy()
}


GUI_Main_ModifyKeyDo()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    If TV_GetParent(GuiMain.Data.SelectID)
    {
        RowNum := LV_GetNext(0, "F")
        LV_GetText(strKey, RowNum, 1)
        LV_GetText(strAct, RowNum, 2)
        objKey := GuiMain.Keymap[strKey A_Tab strAct]
        GUI_Keymap_Save(objKey)
        GUI_Main_ModifyKeyEnd()
        Gui_Main_ListViewUpdata(ObjKey, RowNum, Option:="select")
        GUI_Editing_Enable()
        GUI_Save()
    }
}

GUI_Main_DeleteKey()
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    If TV_GetParent(GuiMain.Data.SelectID)
    {
        RowNum := LV_GetNext(0, "F")
        LV_GetText(strKey, RowNum, 1)
        LV_GetText(strAct, RowNum, 2)
        LV_Delete(RowNum)
        objKey := GuiMain.Keymap[strKey A_Tab strAct]
        ParentObj := GuiMain.Data[GuiMain.Data.SelectID]
        Addr := &objKey
        Loop % ParentObj.Maps.MaxIndex()
        {
            ObjLoop := ParentObj.Maps[A_Index]
            Addr2 := &ObjLoop
            If (Addr2 = Addr)
                ParentObj.Maps.RemoveAt(A_Index)
        }
    }
}

/*
    Function: Gui_Main_ListViewUpdata(aObj, aID, aOption:="")
        更新ListView的项，用于VIMD模块和GestureZ模块

    Parameters:
        aObj - 对象
        aID - 编辑的ListView 模块
        aOption - 选项值
*/

Gui_Main_ListViewUpdata(aObj, aID, aOption:="")
{
    Global GuiMain, gQZConfig
    objItem := gQZConfig.Items[aObj.UUID]
    aOption := A_Space
    GuiMain.KeyList.SetDefault()
    strStatus := aObj.Disable ? QZLang.TextDisable2 : QZLang.TextEnable
    txtMatch := GuiMain.Edit_Search.GetText()
    If RegExMatch(aObj.UUID, "^<\d>$")
        Name := aObj.UUID
    Else
        Name := objItem.Name
    If TCMatch(aObj.Key . A_Space . Name . A_Space . aObj.Tips, txtMatch)
    {
        LV_Modify(aID, aOption, aObj.Key, Name, strStatus, aObj.Tips)
        GuiMain.Keymap[aObj.Key A_Tab Name] := aObj
    }
}

/*
    Function: GUI_Main_TreeViewUpdate(aObj, aID, aOption:="")
        更新TV_Add并保存相关的设置

    Parameters: 
        Item - 用于TV_Add的对象
        aID - 需要更新的TreeView ID
        aOption - 初始化的选项

    Returns: 
        返回TV_Add的ID
 */

GUI_Main_TreeViewUpdate(aObj, aID, aOption:="")
{
    Global GuiMain, gQZConfig
    GuiMain.Default()
    aOption .= A_Space
    If (GuiMain.EditMode = 1)
    {
        If StrLen(aObj.UUID)
        {
            NewName := ""
            Item := gQZConfig.Items[aObj.UUID]
            If (aObj.Options.Disable || aObj.Options.Hide)
            {
                If aObj.Options.Disable
                    NewName .= QZLang.TextDisable
                If aObj.Options.Hide
                    NewName .= QZLang.TextHide
                aOption .= "icon" . GUI_Main_ILAdd(QZGlobal.DisIconFile, QZGlobal.DisIconNum) . A_Space
            }
            Else
            {
                aOption .= "icon" . GUI_Main_ILAdd(aObj.Options.IconFile, aObj.Options.IconNumber) . A_Space
            }
            aOption .= (aObj.Options.Bold ? "Bold" : "-Bold") . A_Space
        }

        If (aObj.Options.Type)
        {
            NewName .= Item.Name
            If !Strlen(NewName)
                NewName .= QZGlobal.ItemNull
        }
        Else If !StrLen(aObj.UUID) && IsObject(aObj)
        {
            aOption .= "icon" . GUI_Main_ILAdd(aObj.Options.IconFile, aObj.Options.IconNumber) . A_Space
            NewName .= QZGlobal.Line
        }
        Else If StrLen(Item.Name)
        {
            NewName .= Item.Name
        }
        Else
        {
            NewName .= QZGlobal.ItemNull
        }
        SubItem := aObj.SubItem
    }
    If (GuiMain.EditMode = 2)
    {
        NewName := aObj.Name

        If aObj.Options.Disable
            aOption .= "icon" . GUI_Main_ILAdd(QZGlobal.DisIconFile, QZGlobal.DisIconNum) . A_Space
        Else If TV_GetParent(aID)
            aOption .= "icon" . GUI_Main_ILAdd(aObj.Options.IconFile, aObj.Options.IconNumber) . A_Space
        Else
            aOption .= "icon" . GUI_Main_ILAdd(QZGlobal.WinIconFile , QZGlobal.WinIconNum) . A_Space
        SubItem := aObj.Modes
    }
    NewID := TV_Modify(aID, aOption, NewName)
    GuiMain.Data[NewID] := aObj
    If Strlen(aObj.Options.ColorFore) || Strlen(aObj.Options.ColorBack)
        GuiMain.TVColor.Modify({Hwnd:NewID, Fore:aObj.Options.ColorFore,Back:aObj.Options.ColorBack})
    Else
        GuiMain.TVColor.Remove(NewID)
    GuiMain.TVIDs[aObj.ID] := NewID
    TV_DeleteChild(NewID)
    If IsObject(SubItem[1])
        GUI_Main_LoadDataSub(SubItem, NewID)
    Return NewID
}

TV_DeleteChild(aID)
{
    Child := TV_GetChild(aID)
    If Child
    {
        Loop
        {
            NextID := TV_GetNext(Child)
            TV_Delete(Child)
            Child := NextID
            If !NextID
                Break
        }
    }
}

TV_GetPos(ParentID, SelectID)
{
    ChildID := TV_GetChild(ParentID)
    Loop
    {
        If (ChildID = SelectID) || !ChildID
            Return A_Index
        ChildID := TV_GetNext(ChildID)
    }
}

/*
    Function: GUI_Main_ILAdd
        加载图标到TreeView控件中

    Parameters: 
        aFile - 图标文件路径
        aNumber - 图标文件中图标编号

    Returns: 
        返回一个ImageList的ID
 */

GUI_Main_ILAdd(aFile, aNumber)
{
    Global GuiMain
    Static objIconHistroy := {}
    aFile := QZ_ReplaceEnv(aFile)
    If FileExist(aFile)
    {
        If !(IconID := objIconHistroy[ aFile A_Tab aNumber])
        {
            IconID := IL_Add(GuiMain.TVListID, aFile, aNumber)
            objIconHistroy[ aFile A_Tab aNumber] := IconID
        }
    }
    Else
    {
        IconID := 99999
    }
    Return IconID
}

GUI_Esc()
{
    Global GuiMain
    GuiMain.Count := 0
}

GUI_Save()
{
    Return
    SetTimer, _GUI_SaveDo, -5000
    Return
    _GUI_SaveDo:
        GUI_ReloadQZ()
    Return
}
/*
GUI_SendWMData(aCmd)
{
    IniRead, nHwnd, %A_TEMP%\QZRunTime, Auto, HWND
    If !WinExist("ahk_id " nHwnd)
    {
        IniRead, FullPath, %A_TEMP%\QZRunTime, Auto, FullPath
        If !FileExist(FullPath)
            FullPath := A_ScriptDir "\QuickZ.ahk"
        Run,%A_AhkPath% "%FullPath%"
    }
    Else
        QZ_SendWMData(aCmd, nHwnd)
}
*/
GUI_ExitEditor()
{
    ExitApp
}

GUI_ExitQZ()
{
    Send_WM_COPYData("ExitApp")
    ;GUI_SendWMData("ExitApp")
}


GUI_Rebuild()
{
    QZ_UpdatePlugin()
    QZ_UpdateCode()
}

GUI_ReloadQZ()
{
    QZ_WriteConfig(QZ_GetConfig(), QZGlobal.Config)
    GUI_Rebuild()
    Send_WM_COPYData("Reload")
    ;GUI_SendWMData("Reload")
}

GUI_ReloadEditor()
{
    Reload
}

GUI_ReciveWMData(wParam, lParam)
{
    global gQZWMCMD
    StringAddress := NumGet(lParam + 2*A_PtrSize)  
    ; 获取 CopyDataStruct 的 lpData 成员.
    gQZWMCMD := StrGet(StringAddress)  ; 从结构中复制字符串.
    Settimer, GUI_WMCMD, -50 ; 使用settimer运行，方便直接return一个true过去
    return True
}

GUI_WMCMD()
{
    global gQZWMCmd, gQZConfig, GuiMain
    If (gQZWMCmd = "Reload")
        Reload
    If (gQZWMCmd = "ExitApp")
        ExitApp
    If RegExMatch(gQZWMCmd, "i)^\-[fm]\s[a-f\d]{8}(-[a-f\d]{4}){3}-[a-f\d]{12}$")
    {
        If RegExMatch(gQZWMCmd, "i)^\-f ")
            IsFilter := True
        If RegExMatch(gQZWMCmd, "i)^\-m ")
            IsMenu := True
        gQZWMCmd := RegExReplace(gQZWMCmd, "^\-[fm]\s")
        If IsObject(objMenu := LocalObjMenu(gQZConfig.MenuZ, gQZWMCmd)) 
        {
            If (GuiMain.EditMode <> 1)
                GUI_Main_LoadMenuZ()
            GuiMain.Data.SelectID := GuiMain.TVIDs[objMenu.ID]
            GuiMain.Default()
            TV_Modify(GuiMain.Data.SelectID, "Select")
            If IsMenu
            {
                GUI_ItemEditor_Load("GUI_Main_MenuItemModify", "GUI_Main_MenuItemModifyEnd", gQZConfig.Items[objMenu.UUID].Options.CodeMode)
                GUI_ItemEditor_LoadData(objMenu)
            }
            Else If IsFilter
            {
                GUI_FilterMgr_Load("GUI_Main_MenuFilter", "GUI_Main_MenuFilterEnd")
                GUI_FilterMgr_LoadData(objMenu)
            }
        }
    }
}

LocalObjMenu(aParent, aUUID)
{
    Loop % aParent.MaxIndex()
    {
        objMenu := aParent[A_Index]
        If (objMenu.ID = aUUID) || (ObjMenu.UUID = aUUID)
            Return ObjMenu
        If IsObject(objMenu.SubItem[1])
            If IsObject(objSub := LocalObjMenu(objMenu.SubItem, aUUID))
                Return objSub
    }
    Return ""
}
