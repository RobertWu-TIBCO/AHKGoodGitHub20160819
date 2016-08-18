GUI_ModeEditor_Load(aHandle, CloseEvent:="")
{
    Global ModeEditor
    ModeEditor := new GUI2("ModeEditor", "+Lastfound +Theme -DPIScale")
    ModeEditor.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    ModeEditor.AddCtrl("GB_ModeName", "GroupBox", "x10 y10 h60 w415", QZLang.TextModeName "(&N)") 
    ModeEditor.AddCtrl("Text_ICON", "Text", "x30 y34 h24 w24 border")
    ModeEditor.AddCtrl("pic_Icon", "Pic", "x34 y38 h18 w18 ")
    ModeEditor.AddCtrl("edit_Name", "Edit", "x68 y34 h26 w335")
    ModeEditor.AddCtrl("CB_Disable", "CheckBox", "x15 y80 h26 ", QZLang.TextCBDisable2 "(&D)")
    ModeEditor.AddCtrl("ButtonOK", "Button", "x236 y80 h26 w90", QZLang.ButtonOK)
    ModeEditor.AddCtrl("ButtonClose", "Button", "x336 y80 h26 w90", QZLang.ButtonClose)
    ModeEditor.ButtonOK.SetIcon(QZGlobal.Defaulticl, 30)
    ModeEditor.ButtonOK.OnEvent(aHandle)
    If Strlen(CloseEvent)
    {
        ModeEditor.ButtonClose.OnEvent(CloseEvent)
        ModeEditor.OnClose(CloseEvent)
    }
    Else
    {
        ModeEditor.ButtonClose.OnEvent("GUI_ModeEditor_Destroy")
    }
    ModeEditor.PIC_ICON.OnEvent("GUI_ModeEditor_Pic")
    ModeEditor.Text_ICON.OnEvent("GUI_ModeEditor_Pic")
    ModeEditor.Show("xcenter h115",QZLang.ModeEditor)
    ModeEditor.Data := {}
    Return ModeEditor
}

GUI_ModeEditor_LoadData(objMode)
{
    Global ModeEditor
    ModeEditor.Edit_Name.SetText(objMode.Name)
    ModeEditor_SetIcon(objMode.Options.IconFile, objMode.Options.IconNumber)
    If objMode.Options.Disable
        ModeEditor.CB_Disable.SetText(True)
    Else
        ModeEditor.CB_Disable.SetText(False)
}

GUI_ModeEditor_Dump()
{
    Global ModeEditor
    Return ModeEditor
}


GUI_ModeEditor_Save(ByRef objMode)
{
    Global ModeEditor
    objMode.Name := ModeEditor.Edit_Name.GetText() 
    objMode.Options := {}
    objMode.Options.IconFile := ModeEditor.Data.IconFile
    objMode.Options.IconNumber := ModeEditor.Data.IconNumber
    objMode.Options.Disable := ModeEditor.CB_Disable.GetText()
}

GUI_ModeEditor_Destroy()
{
    Global ModeEditor
    ModeEditor.Destroy()
}

GUI_ModeEditor_Pic()
{
    Global gQZConfig
    GUI_IconSelector_Load("GUI_ModeEditor_SetIconEvent")
    objGUI := GUI_IconSelector_Dump()
    objGUI.SearchPath.SetText(QZGlobal.DefaultIcons)
    GUI_IconSelector_Search()
    GUI_IconSelector_SetBookMark(gQZConfig.Setting.IconBookMark)
}

GUI_ModeEditor_SetIconEvent()
{
    ObjGUI := GUI_IconSelector_Dump()
    If (ObjGUI.Data.Event = "Select")
        ModeEditor_SetIcon(objGUI.Data.IconFile, objGUI.Data.IconNumber)
    Else If (ObjGUI.Data.Event = "Clear")
        ModeEditor_SetIcon("", 0)
    Else
        ObjGUI.Destroy()
}

ModeEditor_SetIcon(aIconFile, aIconNumber)
{
    Global ModeEditor
    ModeEditor.Data.IconFile := aIconFile
    ModeEditor.Data.IconNumber := aIconNumber
    ModeEditor.Pic_Icon.SetIcon(QZ_ReplaceEnv(aIconFile), aIconNumber)
}
