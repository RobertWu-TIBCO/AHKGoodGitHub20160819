

GUI_EnvEditor_Load(Callback, CloseEvent:="")
{
    Global EnvEditor, gQZConfig
    EnvEditor := new GUI2("EnvEditor", "+Lastfound +Theme -DPIScale")
    EnvEditor.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    EnvEditor.AddCtrl("Text_Tip", "Text", "x10 y407 w300 h26", QZLang.TextEnvTips)
    EnvEditor.AddCtrl("Text_Tip2", "Text", "x10 y12 h26 hidden", QZLang.TextEnvTips2)
    EnvEditor.AddCtrl("LV_Env", "ListView", "x10 y50 w600 h350 hidden grid altsubmit", QZLang.TextListViewEnv)
    EnvEditor.AddCtrl("CB_UserEnv", "Radio", "x210 y10 w90 h26 hidden checked", QZLang.TextCBUserEnv)
    EnvEditor.AddCtrl("CB_InsideEnv", "Radio", "x310 y10 w90 h26 hidden", QZLang.TextCBInsideEnv)
    EnvEditor.AddCtrl("CB_OutsideEnv", "Radio", "x410 y10 w90 h26 hidden", QZLang.TextCBOutsideEnv)
    EnvEditor.AddCtrl("Button_Manager", "Button", "x520 y10 w90 h26 hidden", QZLang.ButtonManager)
    EnvEditor.AddCtrl("Button_OK", "Button", "x410 y405 w90 h26", QZLang.ButtonOK)
    EnvEditor.AddCtrl("Button_Close", "Button", "x520 y405 w90 h26", QZLang.ButtonClose)
    LV_ModifyCol(1, 150)
    LV_ModifyCol(2, 500)
    If IsFunc(Callback)
    {
        EnvEditor.FuncCallback := Callback
        EnvEditor.AddCtrl("Edit_Env", "Edit", "x10 y50 w600 h350")
        EnvEditor.Text_Tip.Hide()
        EnvEditor.Edit_Env.Hide()
        EnvEditor.Text_Tip2.Show()
        EnvEditor.CB_UserEnv.Show()
        EnvEditor.CB_InsideEnv.Show()
        EnvEditor.CB_OutsideEnv.Show()
        EnvEditor.Button_Manager.Show()
        EnvEditor.LV_Env.Show()
        EnvEditor.LV_Env.OnEvent("GUI_EnvEditor_Event")
        EnvEditor.Button_OK.OnEvent(Callback)
        EnvEditor.Button_Manager.OnEvent("GUI_EnvEditor_Manager")
        EnvEditor.CB_UserEnv.OnEvent("GUI_EnvEditor_UserEnvLoad")
        EnvEditor.CB_InsideEnv.OnEvent("GUI_EnvEditor_InsideEnvLoad")
        EnvEditor.CB_OutsideEnv.OnEvent("GUI_EnvEditor_OutsideEnvLoad")
        GUI_EnvEditor_UserEnvLoad()
    }
    Else
    {
        EnvEditor.AddCtrl("Edit_Env", "Edit", "x10 y10 w600 h385")
        GUI_EnvEditor_EditLoad()
        EnvEditor.Button_OK.OnEvent("GUI_EnvEditor_UpdateOK")
    }
    EnvEditor.Button_Close.OnEvent("GUI_EnvEditor_Destroy")
    EnvEditor.Show("", QZLang.TitleEnv)
}

GUI_EnvEditor_Save()
{
    Global EnvEditor
    Return EnvEditor.Select
}

GUI_EnvEditor_Dump()
{
    Global EnvEditor
    Return EnvEditor
}

GUI_EnvEditor_Destroy()
{
    Global EnvEditor
    EnvEditor.Destroy()
}

GUI_EnvEditor_Event()
{
    Global EnvEditor
    If (A_GuiEvent = "Normal")
    {
        LV_GetText(strSelect, A_EventInfo)
        EnvEditor.Select := strSelect
    }
    If (A_GuiEvent = "DoubleClick")
    {
        LV_GetText(strSelect, A_EventInfo)
        EnvEditor.Select := strSelect
        _Func := EnvEditor.FuncCallback
        %_Func%()
    }
}

GUI_EnvEditor_UpdateOK()
{
    GUI_EnvEditor_Update()
    GUI_EnvEditor_Destroy()
}

GUI_EnvEditor_Update()
{
    Global EnvEditor, gQZConfig
    EnvList := EnvEditor.Edit_Env.GetText()
    If EnvEditor.CB_UserEnv.GetText()
    {
        arrEnv := []
        idx := 1
        Loop, Parse, EnvList, `n
        {
            If !Strlen(A_LoopField)
                Continue
            arrEnv[idx] := {Name:Regexreplace(A_loopfield, "=.*$"), Value:Regexreplace(A_loopfield, "^[^=]*=")}
            idx++
        }
        gQZConfig.Setting.UserEnv := arrEnv
        QZ_UpdateUserEnv()
        GUI_EnvEditor_UserEnvLoad()
    }
    If EnvEditor.CB_OutsideEnv.GetText()
    {
        FileDelete, % QZGlobal.OutsideEnv
        BackFileEncoding := A_FileEncoding
        FileEncoding, UTF-16
        FileAppend, %EnvList%, % QZGlobal.OutsideEnv
        FileEncoding, %BackFileEncoding%
        GUI_EnvEditor_OutsideEnvLoad()
    }
    GUI_Save()
}



GUI_EnvEditor_EditLoad()
{
    Global EnvEditor, gQZConfig
    EnvList := ""
    If EnvEditor.CB_UserEnv.GetText()
    {
        Loop % gQZConfig.Setting.UserEnv.MaxIndex()
        {
            objEnv := gQZConfig.Setting.UserEnv[A_Index]
            EnvList .= objEnv.Name "=" objEnv.Value
            If IsObject(gQZConfig.Setting.UserEnv[A_Index+1])
                EnvList .= "`n"
        }
    }
    If EnvEditor.CB_OutsideEnv.GetText()
    {
        If FileExist(QZGlobal.OutsideEnv)
            FileRead, EnvList, % QZGlobal.OutsideEnv
    }
    EnvEditor.Edit_Env.SetText(EnvList)
}

GUI_EnvEditor_UserEnvLoad()
{
    Global EnvEditor, gQZConfig
    EnvEditor.Default()
    LV_Delete()
    Loop % gQZConfig.Setting.UserEnv.MaxIndex()
    {
        objEnv := gQZConfig.Setting.UserEnv[A_Index]
        LV_Add("","%" objEnv.Name "%", objEnv.Value)
    }
}

GUI_EnvEditor_InsideEnvLoad()
{
    Global EnvEditor, gQZConfig
    EnvEditor.Default()
    LV_Delete()
    varList := "Apps|User|Icons|" QZGlobal.InsideEnv "|" QZGlobal.SystemEnv
    Loop, Parse, varList, |
        LV_Add("", "%" A_LoopField "%", QZ_ReplaceEnv( "%" A_LoopField "%" ) )
}

GUI_EnvEditor_OutsideEnvLoad()
{
    Global EnvEditor, gQZConfig
    EnvEditor.Default()
    LV_Delete()
    FileRead, EnvText, % QZGlobal.OutsideEnv
    Loop, Parse, EnvText, `n, `r
    {
        If Strlen(A_LoopField)
        {
            If RegExMatch(A_LoopField, "^\s*\[.*\]\s*$")
                Continue
            If InStr(A_LoopField, "=")
                LV_Add("", "%" Regexreplace(A_loopfield, "=.*$") "%", Regexreplace(A_loopfield, "^[^=]*="))
            Else
                LV_Add("", A_LoopField, "")
        }
    }
}

GUI_EnvEditor_Manager()
{
    Global EnvEditor
    If EnvEditor.CB_InsideEnv.GetText()
        Return
    EnvEditor.Button_Manager.SetText(QZLang.ButtonSave)
    EnvEditor.Button_Manager.OnEvent("GUI_EnvEditor_ManagerOK")
    EnvEditor.CB_UserEnv.Disable()
    EnvEditor.CB_InsideEnv.Disable()
    EnvEditor.CB_OutsideEnv.Disable()
    EnvEditor.Edit_Env.Show()
    EnvEditor.Text_Tip.Show()
    EnvEditor.LV_Env.Hide()
    EnvEditor.Button_OK.Hide()
    EnvEditor.Button_Close.Hide()
    GUI_EnvEditor_EditLoad()
}

GUI_EnvEditor_ManagerOK()
{
    Global EnvEditor
    EnvEditor.Button_Manager.SetText(QZLang.ButtonManager)
    EnvEditor.Button_Manager.OnEvent("GUI_EnvEditor_Manager")
    EnvEditor.CB_UserEnv.Enable()
    ;EnvEditor.CB_UserEnv.SetText(True)
    EnvEditor.CB_InsideEnv.Enable()
    EnvEditor.CB_OutsideEnv.Enable()
    EnvEditor.Edit_Env.Hide()
    EnvEditor.Text_Tip.Hide()
    EnvEditor.LV_Env.Show()
    EnvEditor.Button_OK.Show()
    EnvEditor.Button_Close.Show()
    GUI_EnvEditor_Update()
}
