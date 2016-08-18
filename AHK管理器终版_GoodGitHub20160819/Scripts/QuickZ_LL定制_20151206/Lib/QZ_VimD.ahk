QZ_VIMD()
{
    Global gQZConfig, VIMD
    VIMD := new VimDesktop()
    VIMD.KeyFunc    := "QZ_VIMD_Do"
    VIMD.ActionFunc := "QZ_VIMD_Action"
    VIMD.TimeOutFunc := "QZ_VIMD_TimeOut"
    VIMD.ShowFunc := "QZ_VIMD_Show"
    Loop % gQZConfig.VIMD.MaxIndex()
    {
        objW := gQZConfig.VIMD[A_Index]
        If objW.Options.Disable
            Continue
        objVimWin := VIMD.SetWin(objW.Name, objW.WinClass, objW.WinExe)
        objVimWin.TimeOut := objW.Options.TimeOut
        objVimWin.MaxCount := objW.Options.MaxCount
        objVimWin.OnActionBefore := objW.Options.OnActionBefore
        objVimWin.OnActionAfter := objW.Options.OnActionAfter
        objVimWin.OnChangeMode := objW.Options.ChangeMode
        objVimWin.OnShow := objW.Options.OnShow
        _Func := ObjW.Options.OnInit
        %_Func%()
        Loop % objW.Modes.MaxIndex()
        {
            objM := objW.Modes[A_Index]
            If objM.Options.Disable
                Continue
            objVimMode := VIMD.SetMode(objM.Name, objVimWin)
            objVimMode.IconFile := QZ_ReplaceEnv(objM.Options.IconFile)
            objVimMode.IconNumber := objM.Options.IconNumber
            Loop % objM.Maps.MaxIndex()
            {
                objK := objM.Maps[A_Index]
                If !objK.Disable
                {
                    Action := objK.UUID
                    If RegExMatch(gQZConfig.Items[Action].Name, "^<\d>$")
                        Action := gQZConfig.Items[Action].Name
                    VIMD.Map(objK.Key, Action, objVimMode)
                }
            }
        }
        If Strlen(objW.Options.DefaultMode)
            VIMD.ChangeMode(objW.Options.DefaultMode, objVimWin)
    }
}

QZ_VIMD_Do()
{
    Global VIMD
    VIMD.Key()
}

QZ_VIMD_Action(aObjKey)
{
    Global gQZConfig, gVimAction
    gVimAction := aObjKey
    SetTimer, _VIMD_ActionDo, -1
    Return
    _VIMD_ActionDo:
        Config := QZ_GetConfig()
        ObjKey := QZ_GetVimdAct()
        If objKey.NoMulti || !objKey.Count
            Cnt := 1
        Else
            Cnt := objKey.Count
        objItem := Config.Items[ObjKey.UUID]
        Command := objItem.Command
        Param   := objItem.Param
        WorkingDir := objItem.WorkingDir
        RunState   := objItem.RunState
        Loop % Cnt
        {
            If Config.Items[ObjKey.UUID].Options.CodeMode
            {
                GoSub % ObjKey.UUID
            }
            Else
            {
                If !IsObject(Config.Items[ObjKey.UUID])
                    break
                ;msgbox % "Action: " Config.Items[objKey.UUID].Name "`n" objkey.uuid
                QZ_Engine(Command, Param, WorkingDir, RunState)
            }
        }
    Return
}

QZ_GetVimdAct()
{
    Global gVimAction
    Return gVimAction
}

QZ_VIMD_TimeOut()
{
    Global VIMD
    VIMD.IsTimeOut()
}

QZ_VIMD_GetItem(aUUID)
{
    Global gQZConfig
    Return gQZConfig.Items[aUUID]
}

QZ_VIMD_Show(aTemp, aMore, aWin)
{
    Global VIMD
    Static sTooltip
    thisMode := VIMD.GetMode(aWin)
    If !IsObject(sTooltip)
        sTooltip := TT("CloseButton", "", "")
    If aWin.Count
        strTitle := aWin.Count
    If Strlen(aTemp)
        strTitle .= aTemp
    If strlen(aMore)
    {
        If InStr(aMore, "`n")
        {
            Loop, Parse, aMore, `n
            {
                If !Strlen(A_LoopField)
                    Continue
                objVK := ThisMode.Maps[A_LoopField]
                objItem := QZ_VIMD_GetItem(objVK.UUID)
                newMore .= QZ_CheckSep(VIMD.ShiftUpper(A_LoopField) ,objItem.Name) "`n"
            }
        }
    }
    Sort, newMore
    strText := "============================`n" newMore
    ;If !Strlen(aTemp) && !Strlen(aMore)
    If Strlen(strTitle)
        sTooltip.Show(strText,  POSX, POSY, strTitle " ")
    Else
        sTooltip.Hide()
    sTooltip.Icon(ThisMode.IconFile, ThisMode.IconNumber)
}

QZ_CheckSep(Text1, Text2, Length:=20)
{
    Loop % Length - Strlen(Text1)
    {
        Sep .= A_Space
    }
    Return Text1 Sep Text2
}
