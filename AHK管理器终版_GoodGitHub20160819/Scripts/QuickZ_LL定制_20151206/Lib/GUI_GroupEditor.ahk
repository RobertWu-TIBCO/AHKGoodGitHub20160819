/*
    Function: GUI_GroupEditor_Load()
        加载菜单项编辑器

    Parameters: 
        Callback - 用于设置界面关闭后执行某个回调函数。如"test"，代表运行 Test() 函数
*/
GUI_GroupEditor_Load(Callback, CloseEvent:="")
{
    Global GroupEditor
    TBListID := IL_Create(10, 10, 0)
    IL_Add(TBListID, A_WinDir "\System32\imageres.dll", 68)
    IL_Add(TBListID, A_WinDir "\System32\mspaint.exe", 1)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 248)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 247)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 160)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 47)

    GroupEditor := new GUI2("GroupEditor", "+Lastfound +Theme -DPIScale")
    GroupEditor.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    GroupEditor.AddCtrl("GB_ItemName", "GroupBox", "x10 y10 h60 w515", QZLang.TextGroupName) 
    GroupEditor.AddCtrl("text_Name", "Text", "x36 y34 h24 w24 border")
    GroupEditor.AddCtrl("pic_Icon", "Pic", "x40 y38 h18 w18 ")
    GroupEditor.AddCtrl("edit_Name", "Edit", "x72 y34 h26 w330")
    GroupEditor.AddCtrl("TextGroupType", "Text", "x10 y82 h26 ", QZLang.TextGroupType)
    GroupEditor.AddCtrl("CB_IsSub", "Radio", "x105 y80 h26 ", QZLang.TextGroupIsSub)
    GroupEditor.AddCtrl("CB_IsSibling", "Radio", "x190 y80 h26 ", QZLang.TextGroupIsSibling)
    GroupEditor.AddCtrl("ButtonOK", "Button", "x336 y80 h26 w90", QZLang.ButtonOK)
    GroupEditor.AddCtrl("ButtonClose", "Button", "x436 y80 h26 w90", QZLang.ButtonClose)
    GroupEditor.ButtonOK.SetIcon(A_WinDir "\System32\Shell32.dll", 302)
    GroupEditor.ButtonOK.OnEvent(Callback)
    If Strlen(CloseEvent)
    {
        GroupEditor.ButtonClose.OnEvent(CloseEvent)
        GroupEditor.OnClose(CloseEvent)
    }
    Else
    {
        GroupEditor.ButtonClose.OnEvent("GUI_GroupEditor_Destroy")
    }
    GroupEditor.Show("xcenter h115",QZLang.GroupEditor)
    TBCtrl := Toolbar_Add(GroupEditor.hwnd, "GUI_GroupEditor_Event", "Flat Tooltips List", TBListID, "x415 y30 h36 w100")
    GroupEditor.Data := {} ;保存界面相关的数据
    GroupEditor.ToolbarName := TBCtrl
    Toolbar_Insert(TBCtrl, QZLang.IconSelector ", 1, ,dropdown")
    Toolbar_Insert(TBCtrl, QZLang.Colorful ", 2, , dropdown")
    Toolbar_SetButtonSize(TBCtrl, 24)
    ;Return GroupEditor
}

GUI_GroupEditor_LoadData(objMenu)
{
    Global GroupEditor, gQZConfig
    objItem := gQZConfig.Items[objMenu.UUID]
    GroupEditor.Edit_Name.SetText(objItem.Name)
    GroupEditor_SetIcon(objMenu.Options.IconFile, objMenu.Options.IconNumber)
    If (objMenu.Options.Type = 1)
        GroupEditor.CB_IsSub.SetText(True)
    If (objMenu.Options.Type = 2)
        GroupEditor.CB_IsSibling.SetText(True)
}

GUI_GroupEditor_Dump()
{
    Global GroupEditor
    Return GroupEditor
}


GUI_GroupEditor_Save(ByRef objMenu)
{
    Global GroupEditor, gQZConfig
    objItem := gQZConfig.Items[objMenu.UUID]
    IsSub:= 1, IsSibling := 2
    objItem.Name := GroupEditor.Edit_Name.GetText() 
    objMenu.Options.IconFile := GroupEditor.Data.IconFile
    objMenu.Options.IconNumber := GroupEditor.Data.IconNumber
    objMenu.Options.Type := GroupEditor.CB_IsSub.GetText() ? IsSub : IsSibling 
}

GUI_GroupEditor_Destroy()
{
    Global GroupEditor
    GroupEditor.Destroy()
}

GUI_GroupEditor_Event(aCtrl, aEvent, aText, aPos)
{
    Global GroupEditor, gQZConfig
    Static ShowAdv := False
    If (aEvent = "Click")
    {
        If (aCtrl = GroupEditor.ToolbarName)
        {
            If (aPos = 1)
            {
                GUI_IconSelector_Load("GUI_GroupEditor_SetIconEvent")
                objGUI := GUI_IconSelector_Dump()
                objGUI.SearchPath.SetText(QZGlobal.DefaultIcons)
                GUI_IconSelector_Search()
                GUI_IconSelector_SetBookMark(gQZConfig.Setting.IconBookMark)
            }
            If (aPos = 2)
            {
            }
        }
    }
}

GUI_GroupEditor_SetIconEvent()
{
    ObjGUI := GUI_IconSelector_Dump()
    If (ObjGUI.Data.Event = "Select")
        GroupEditor_SetIcon(objGUI.Data.IconFile, objGUI.Data.IconNumber)
    Else If (ObjGUI.Data.Event = "Clear")
        GroupEditor_SetIcon("", 0)
    Else
        ObjGUI.Destroy()
}

GroupEditor_SetIcon(aIconFile, aIconNumber)
{
    Global GroupEditor
    GroupEditor.Data.IconFile := aIconFile
    GroupEditor.Data.IconNumber := aIconNumber
    GroupEditor.Pic_Icon.SetIcon(QZ_ReplaceEnv(aIconFile), aIconNumber)
}


/*
^1::
Toolbar_Customize(TBCtrl)
Return

Close:
    ExitApp
Return


#Include %A_ScriptDir%\Lib\Class_GUI2.ahk
#Include %A_ScriptDir%\Lib\Class_ScrollGUI.ahk
#Include %A_ScriptDir%\Lib\Toolbar.ahk
#Include <Class_QZLang>
*/
