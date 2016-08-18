/*
    Function: GUI_ItemEditorCode_Load()
        加载AHK代码模式

    Parameters: 
        无

    Returns: 
        返回一个GUI对象

    Example: 
        GUI_ItemEditorCode_Load()
*/
GUI_ItemEditorCode_Load(Callback, CloseEvent:="")
{
    Global ItemEditorCode, ItemEditor, GuiMain
    TBListID := IL_Create(10, 10, 0)
    IL_Add(TBListID, A_WinDir "\System32\mspaint.exe", 1)
    IL_Add(TBListID, A_ScriptDir "\User\Icons\Category.ico")
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 248)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 247)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 160)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 47)
    IL_Add(TBListID, QZGlobal.DefaultIcl, 11)
    ; 初始化数据
    ItemEditorCode := new GUI2("ItemEditorCode", "+Lastfound +Theme +Resize -DPIScale +Delimiter`n")
    ItemEditorCode.Data := {} ;保存界面相关的数据
    ItemEditorCode.API := {} ;保存自定义API函数
    ItemEditorCode.Callback := Callback ; 保存回调函数
    ItemEditorCode.CloseEvent := CloseEvent 
    ItemEditorCode.EditMenu := aMenu ; 保存当前编辑的菜单项
    ItemEditor.CodeMode := True
    ; 添加控件
    ItemEditorCode.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    ItemEditorCode.AddCtrl("GB_ItemName", "GroupBox", "x10 y10 h60 w515", QZLang.TextItemName) 

    If ( GuiMain.EditMode = 1)
    {
        ItemEditorCode.AddCtrl("text_Name", "Text", "x36 y34 h24 w24 border")
        ItemEditorCode.AddCtrl("pic_Icon", "Pic", "x40 y38 h18 w18 ")
        ItemEditorCode.AddCtrl("edit_Name", "Edit", "x72 y34 h26 w330")
    }
    If ( GuiMain.EditMode = 2)
    {
        ItemEditorCode.AddCtrl("text_Name", "Text", "x20 y36 h26 ", QZLang.TextName)
        ItemEditorCode.AddCtrl("edit_Name", "Edit", "x72 y34 h26 w366")
    }
    
    ItemEditorCode.AddCtrl("Edit_Code", "Edit", "x10 y115 h378 w515")
    ItemEditorCode.AddCtrl("Text_Functions", "Text", "x20 y80 h26 w70", QZLang.TextFunctions)
    ItemEditorCode.AddCtrl("DDL_Functions", "DDL", "x72 y78 h26 w250 R10")
    ItemEditorCode.AddCtrl("Button_Info", "Button", "x335 y78 h26 w90", QZLang.ButtonInfo)
    ItemEditorCode.AddCtrl("Button_Insert", "Button", "x435 y78 h26 w90", QZLang.ButtonInsert)
    ;ItemEditor.AddCtrl("btn_Advance", "Button", "x424 y210 h26 w90", QZLang.ButtonAdvance)
    ItemEditorCode.AddCtrl("ButtonOK", "Button", "x336 y500 h26 w90", QZLang.ButtonOK)
    ItemEditorCode.AddCtrl("ButtonClose", "Button", "x436 y500 h26 w90", QZLang.ButtonClose)
    ItemEditorCode.ButtonOK.SetIcon(A_WinDir "\System32\Shell32.dll", 302)
    ItemEditorCode.Show("", QZLang.ItemEditor)
    ItemEditorCode.PIC_Icon.OnEvent("GUI_ItemEditorCode_Pic")
    ItemEditorCode.Text_Icon.OnEvent("GUI_ItemEditorCode_Pic")
    ItemEditorCode.ButtonOK.OnEvent(Callback)
    ItemEditorCode.DDL_Functions.OnEvent("GUI_ItemEditorCode_DDL")
    ItemEditorCode.Button_Info.OnEvent("GUI_ItemEditorCode_Info")
    ItemEditorCode.Button_Insert.OnEvent("GUI_ItemEditorCode_Insert")
    GUI_ItemEditorCode_UpdateFunc()
    ItemEditorcode.DDL_Functions.Choose(1)
    ItemEditorCode.OnDropFiles("GUI_ItemEditorCode_DropFiles")
    If Strlen(CloseEvent)
    {
        ItemEditorCode.OnClose(CloseEvent)
        ItemEditorCode.ButtonClose.OnEvent(CloseEvent)
    }
    Else
    {
        ItemEditorCode.ButtonClose.OnEvent("GUI_ItemEditorCode_Destroy")
    }

    If (GuiMain.EditMode = 1)
    {
        TBCtrl := Toolbar_Add(ItemEditorCode.hwnd, "GUI_ItemEditorCode_Event", "Flat Tooltips List", TBListID, "x415 y30 h36 w100")
        Toolbar_Insert(TBCtrl, QZLang.TB_IconAndColor ", 1, ,dropdown")
    }
    If (GuiMain.EditMode = 2)
    {
        TBCtrl := Toolbar_Add(ItemEditorCode.hwnd, "GUI_ItemEditorCode_Event", "Flat Tooltips List", TBListID, "x450 y30 h36 w60")
    }
    TBAdv  := Toolbar_Add(ItemEditorCode.hwnd, "GUI_ItemEditorCode_Event", "Flat Tooltips Menu", TBListID, "x10 y502 h36 w300")

    ItemEditorCode.ToolbarName := TBCtrl
    ItemEditorCode.ToolbarAdv  := TBAdv
    Toolbar_Insert(TBCtrl, QZLang.TB_Category ", 2, , dropdown")
    Toolbar_Insert(TBAdv, QZLang.TextChangeToNormal ", 6, , ")
    Toolbar_Insert(TBAdv, QZLang.TB_EditBy ", 7, , ")
    Toolbar_SetButtonSize(TBCtrl, 24)
    ;TBAhk  := Toolbar_Add(ItemEditorCode.hwnd, "GUI_ItemEditorCode_Event", "Flat Tooltips Menu", "1S", "x10 y78 h36 w300")
    ;ItemEditorCode.ToolbarAHK  := TBAhk
    ;Toolbar_Insert(TBCtrl, QZLang.IconSelector ", 1, ,dropdown")
    ;Toolbar_Insert(TBCtrl, QZLang.Colorful ", 2, , dropdown")
    ;Toolbar_Insert(TBAHK, ",2")
    ;Toolbar_Insert(TBAHK, ",3")
    ;Toolbar_SetMaxTextRows(TBahk, 0) 
    ;Toolbar_SetButtonSize(TBahk, 32, 32)
    Return ItemEditorCode
}

GUI_ItemEditorCode_LoadData(aMenu)
{
    Global gQZConfig, ItemEditorCode
    ItemEditorCode.EditMenu := aMenu
    aUUID := aMenu.UUID
    ItemEditorCode.Data.UUID := aUUID
    
    objItem := gQZConfig.Items[aUUID]
    ItemEditorCode.CategorySelect := objItem.Options.Category
    ItemEditorCode.Edit_Name.SetText(objItem.Name)
    ItemEditorCode.Edit_Code.SetText(objItem.Code)
    ItemEditorCode_SetIcon(aMenu.Options.IconFile, aMenu.Options.IconNumber)

    GUI_ItemEditorCode_SetBold(aMenu.Options.Bold)
    GUI_ItemEditorCode_SetColor(aMenu.Options.ColorBack, aMenu.Options.ColorFore)
}

GUI_ItemEditorCode_Dump()
{
    Global ItemEditorCode
    Return ItemEditorCode
}

GUI_ItemEditorCode_Destroy()
{
    Global ItemEditorCode
    ItemEditorcode.Destroy()
}

GUI_ItemEditorcode_Save(ByRef objMenu)
{
    Global ItemEditorcode, gQZConfig
    If StrLen(objMenu.UUID)
    {
        objItem := gQZConfig.Items[objMenu.UUID]
        objMenu.Options.IconFile := ItemEditorCode.Data.IconFile
        objMenu.Options.IconNumber := ItemEditorCode.Data.IconNumber
        objMenu.Options.ColorBack := ItemEditorCode.Data.ColorBack
        objMenu.Options.ColorFore := ItemEditorCode.Data.ColorFore
        objMenu.Options.Bold := ItemEditorCode.Data.Bold
    }
    Else
    {
        objItem := objMenu
    }
    objItem.Name := ItemEditorcode.Edit_Name.GetText()
    objItem.Code := ItemEditorCode.Edit_Code.GetText()
    objItem.Options.CodeMode := True
    objItem.Options.Category := ItemEditorCode.CategorySelect
    QZ_UpdateCode()
}

GUI_ItemEditorCode_Event(aCtrl, aEvent, aText, aPos)
{
    Global ItemEditorCode, gQZConfig
    If (aCtrl = ItemEditorCode.ToolbarName)
    {
        If (aText = QZLang.TB_IconAndColor) 
        {
            If (aEvent = "Click")
            {
                GUI_ItemEditorCode_Pic()
                Return
            }
            If !(aEvent = "Menu")
                Return
            IconSelHwnd := ItemEditorCode.hwnd
            CoordMode, Menu, Screen
            WinGetPos, GuiX, GuiY, , ,  ahk_id %IconSelHwnd%
            ControlGetPos, TBX, TBY, , , ToolbarWindow321, ahk_id %IconSelHwnd%
            TBH := Toolbar_GetRect(ItemEditorCode.ToolbarName, aPos, "h")
            PosX := GuiX + TBX
            PosY := GuiY + TBY + TBH
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, DeleteAll
            ;Menu, _TBCMDMenu, Add, % QZLang.ButtonAutoIcon, _TBNameMenu_DO2
            ;Menu, _TBCMDMenu, Add, % QZLang.ButtonClear, _TBNameMenu_DO2
            ;Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, Add, % QZLang.ButtonBColor, _TBNameMenu_DO2
            Menu, _TBCMDMenu, Add, % QZLang.ButtonTColor, _TBNameMenu_DO2
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, Add, % QZLang.ButtonBold, _TBNameMenu_DO2
            Menu, _TBCMDMenu, Add
            Menu, _TBCMDMenu, Add, % QZLang.ButtonClearColor, _TBNameMenu_DO2
            If ItemEditorCode.Data.Bold
                Menu, _TBCMDMenu, Check, % QZLang.ButtonBold
            Menu, _TBCMDMenu, Show, %PosX%, %PosY%
            Return
            _TBNameMenu_DO2:
                If (A_ThisMenuItem = QZLang.ButtonBColor)
                    GUI_ItemEditorCode_BColor()
                If (A_ThisMenuItem = QZLang.ButtonTColor)
                    GUI_ItemEditorCode_TColor()
                If (A_ThisMenuItem = QZLang.ButtonBold)
                {
                    objGUI := GUI_ItemEditorCode_Dump()
                    GUI_ItemEditorCode_SetBold(!objGUI.Data.Bold)
                }
                If (A_ThisMenuItem = QZLang.ButtonClearColor)
                {
                    GUI_ItemEditorCode_SetColor("","")
                }
            Return
        }
        If (aText = QZLang.TB_Category) && (aEvent = "Click")
            GUI_ItemCategory_Load("GUI_SelectCategoryDo","GUI_ItemCategory_Destroy", ItemEditorCode.CategorySelect)
    }
    Else If (aCtrl = ItemEditorCode.ToolbarAdv) && (aText = QZLang.TextChangeToNormal) && (aEvent = "menu")
    {
        gQZConfig.Items[ItemEditorCode.EditMenu.UUID].Options.CodeMode := False
        objGUI := GUI_ItemEditor_Load(ItemEditorCode.Callback, ItemEditorCode.CloseEvent)
        GUI_ItemEditor_LoadData(ItemEditorCode.EditMenu)
        objGUI.CategorySelect := ItemEditorCode.CategorySelect
        ItemEditorCode.Destroy()
    }
    Else If (aCtrl = ItemEditorCode.ToolbarAdv) &&  (aText = QZLang.TB_EditBy) && (aEvent = "Menu")
    {
        EditDir := A_Temp "\QZTemp"
        If not Fileexist(EditDir)
            FileCreateDir, % EditDir
        If !Strlen(EditName := ItemEditorCode.Edit_Name.GetText())
            EditName := "New"
        EditPath := EditDir "\" EditName ".ahk"
        Content := ItemEditorCode.Edit_Code.GetText()
        FileAppend, %Content%, %EditPath%
        If !Fileexist(iEditor := gQZConfig.Setting.Global.Editor)
            Target := A_WinDir "\Notepad.exe" . A_Space . """" . EditPath . """"
        Else
            target := iEditor . A_Space . gQZConfig.Setting.Global.EditorParam . A_Space . """" . EditPath . """"
        Run, %Target%, ,Useerrorlevel, EditByPID
        If Errorlevel
        {
            Msgbox  Error
            Return
        }
        ItemEditorCode.EditByPID := EditByPID
        ItemEditorCode.EditDir := EditDir
        ItemEditorCode.EditPath := EditPath
        WatchFolder(Editdir, "GUI_ItemEditorCode_EditByWatch", False, 19)
        Settimer, GUI_ItemEditorCode_EditByTimer, 800
    }
}

GUI_ItemEditorCode_EditByTimer()
{
    Global ItemEditorCode
    If !Winexist("ahk_pid " ItemEditorCode.EditByPID)
    {
        WatchFolder(ItemEditorCode.EditDir, "**END")
        FileDelete, % ItemEditorCode.EditPath
        Settimer, GUI_ItemEditorCode_EditByTimer, off
    }
}

GUI_ItemEditorCode_EditByWatch(folder, changes)
{
    Global ItemEditorCode
    FileRead, Content , % ItemEditorCode.EditPath
    ItemEditorCode.Edit_Code.SetText(Content)
}

GUI_ItemEditorCode_UpdateFunc()
{
    Global ItemEditorcode
    FuncList := QZLang.Help_QZFunctions() "`n"
    Loop , % QZGlobal.PluginDir "*.ahk", 1, 1
    {
        objPlugin := GetPluginInfo(A_LoopFileFullPath)
        If IsObject(objPlugin)
        {
            If !Strlen(objPlugin.API)
                Continue
            FileRead, iText, %A_LoopFileFullPath%
            strName := objPlugin.API "   " objPlugin.Tips
            FuncList .= strName "`n"
            Loop
            {
                iText := GetPluginInfo_Cut(iText)
                objInfo := GetPluginInfoM(iText)
                If !IsObject(objInfo)
                    Break
                If Strlen(objInfo.Func)
                {
                    ItemEditorCode.API[objPlugin.API] := objInfo["All"]
                    Break
                }
            }
        }
    }
    ItemEditorCode.DDL_Functions.SetText(FuncList)
    ;msgbox % FuncList
}

GUI_ItemEditorCode_Info()
{
    Global ItemEditorCode
    InfoFunc := RegExReplace(ItemEditorCode.DDL_Functions.GetText(), "\s+.*$")
    _Func := InfoFunc . "_Help"
    If IsFunc(QZLang[_Func])
        objInfo := QZLang[_Func]()
    Else
        objInfo := {Title: ItemEditorCode.DDL_Functions.GetText(), Text:"==============================`n"  ItemEditorCode.API[InfoFunc]}
    iHwnd := ItemEditorCode.Hwnd
    WinGetPos, PosX, PosY, PosW, , A
    PosX := PosX + PosW
    objTT := TT("CloseButton", "", "")
    ObjTT.Show(objInfo.Text , PosX, PosY, objInfo.Title)
}

GUI_ItemEditorCode_Insert()
{
    Global ItemEditorCode
    InfoFunc := RegExReplace(ItemEditorCode.DDL_Functions.GetText(), "\s+.*$")
    ItemEditorCode.Edit_Code.InsertText(InfoFunc "(  )")
}

GUI_ItemEditorCode_Pic()
{
    Global gQZConfig
    GUI_IconSelector_Load("GUI_ItemEditorCode_SetIconEvent")
    objGUI := GUI_IconSelector_Dump()
    objGUI.SearchPath.SetText(QZGlobal.DefaultIcons)
    GUI_IconSelector_Search()
    GUI_IconSelector_SetBookMark(gQZConfig.Setting.IconBookMark)
}

GUI_ItemEditorCode_SetBold(aBold)
{
    Global ItemEditorCode
    If aBold
        ItemEditorCode.Edit_Name.SetFont("Bold")
    Else
        ItemEditorCode.Edit_Name.SetFont("Norm")
    ItemEditorCode.Data.Bold := aBold
}

GUI_ItemEditorCode_SetColor(aBack, aFore)
{
    Global ItemEditorCode
    ItemEditorCode.Data.ColorBack := aBack
    ItemEditorCode.Data.ColorFore := aFore
    If Strlen(aBack) || Strlen(aFore)
        CtlColors.Attach(ItemEditorCode.Edit_Name.hwnd, SubStr(aBack,3), SubStr(aFore,3))
    Else
        CtlColors.Detach(ItemEditorCode.Edit_Name.hwnd)
}


GUI_ItemEditorCode_BColor()
{
    Global ItemEditorCode
    If Dlg_Color(aBack,ItemEditorCode.Hwnd)
    {
        ItemEditorCode.Data.ColorBack := aBack
        aFore := ItemEditorCode.Data.ColorFore
        CtlColors.Change(ItemEditorCode.Edit_Name.hwnd, SubStr(aBack,3), SubStr(aFore,3))
    }
}

GUI_ItemEditorCode_TColor()
{
    Global ItemEditorCode
    If Dlg_Color(aFore, ItemEditorCode.Hwnd)
    {
        ItemEditorCode.Data.ColorFore := aFore
        aBack := ItemEditorCode.Data.ColorBack
        CtlColors.Change(ItemEditorCode.Edit_Name.hwnd, SubStr(aBack,3), SubStr(aFore,3))
    }
}

GUI_ItemEditorCode_SetIconEvent()
{
    ObjGUI := GUI_IconSelector_Dump()
    If (ObjGUI.Data.Event = "Select")
        ItemEditorCode_SetIcon(objGUI.Data.IconFile, objGUI.Data.IconNumber)
    Else If (ObjGUI.Data.Event = "Clear")
        ItemEditorCode_SetIcon("", 0)
    Else
        ObjGUI.Destroy()
}

ItemEditorCode_SetIcon(aIconFile, aIconNumber)
{
    Global ItemEditorCode
    ItemEditorCode.Data.IconFile := aIconFile
    ItemEditorCode.Data.IconNumber := aIconNumber
    ItemEditorCode.Pic_Icon.SetIcon(QZ_ReplaceEnv(aIconFile), aIconNumber)
}

