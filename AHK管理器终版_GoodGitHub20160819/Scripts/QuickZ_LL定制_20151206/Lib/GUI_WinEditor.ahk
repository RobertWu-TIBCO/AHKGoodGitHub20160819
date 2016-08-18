/*
    Function: GUI_WinEditor_Load(Callback, aWin)
        用于配置VIMD中的“程序”设置界面

    Parameters:
        Callback - 回调函数
        CloseEvent - 关闭界面的时候调用的函数
*/

GUI_WinEditor_Load(Callback, CloseEvent:="")
{
    Global WinEditor
    TBListID := IL_Create(3, 1, 0)
    IL_Add(TBListID, A_WinDir "\System32\Shell32.dll", 248)
    WinEditor := new GUI2("WinEditor", "+Lastfound +Theme +Resize -DPIScale")
    WinEditor.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    WinEditor.AddCtrl("GB_WinDefine", "GroupBox", "x10 y8 h150 w450", QZLang.TextWinDefine) 
    WinEditor.AddCtrl("Text_WinName", "Text", "x30 y40 h26 w80", QZLang.TextWinName "(&N):") 
    WinEditor.AddCtrl("Edit_WinName", "Edit", "x115 y38 h26 w330")
    WinEditor.AddCtrl("Text_WinClass", "Text", "x35 y80 h26 w70", QZLang.FilterWinClass "(&A):") 
    WinEditor.AddCtrl("Edit_WinClass", "Edit", "x115 y78 h26 w280")
    WinEditor.AddCtrl("Text_WinExe", "Text", "x30 y120 h26 w80", QZLang.FilterWinExe "(&E):") 
    WinEditor.AddCtrl("Edit_WinExe", "Edit", "x115 y118 h26 w280")
    WinEditor.AddCtrl("GB_WinOptions", "GroupBox", "x10 y165 h110 w450", QZLang.TextWinOptions) 
    WinEditor.AddCtrl("Text_TimeOut", "Text", "x30 y195 h26 w80", QZLang.TextTimeOut "(&T):") 
    WinEditor.AddCtrl("Edit_TimeOut", "Edit", "x115 y193 h26 w70")
    WinEditor.AddCtrl("Text_TimeOutMS", "Text", "x192 y195 h26 w80", "(ms)") 
    WinEditor.AddCtrl("Text_MaxCount", "Text", "x250 y195 h26 w120", QZLang.TextMaxCount "(&B):") 
    WinEditor.AddCtrl("Edit_MaxCount", "Edit", "x360 y193 h26 w80")
    WinEditor.AddCtrl("Text_DefaultMode", "Text", "x30 y235 h26 w120", QZLang.TextDefaultMode "(&M):") 
    WinEditor.AddCtrl("DDL_DefalutMode", "DDL", "x115 y233 h26 w190 r5")
    WinEditor.AddCtrl("CB_Disable", "CheckBox",  "x330 y234 h26 w100", QZLang.TextCBDisable "(&D)")
    WinEditor.AddCtrl("GB_WinFunctions", "GroupBox", "x10 y285 h230 w450", QZLang.TextWinFunctions) 
    WinEditor.AddCtrl("Text_OnInit", "Text", "x30 y315 h26 w110", QZLang.TextOnInit "(&I):")
    WinEditor.AddCtrl("Edit_OnInit", "Edit", "x145 y313 h26 w300")
    WinEditor.AddCtrl("Text_OnChangeMode", "Text", "x30 y355 h26 w110", QZLang.TextOnChangeMode "(&J):")
    WinEditor.AddCtrl("Edit_OnChangeMode", "Edit", "x145 y353 h26 w300")
    WinEditor.AddCtrl("Text_OnActionBefore", "Text", "x30 y395 h26 w110", QZLang.TextOnActionBefore "(&K):")
    WinEditor.AddCtrl("Edit_OnActionBefore", "Edit", "x145 y393 h26 w300")
    WinEditor.AddCtrl("Text_OnActionAfter", "Text", "x30 y435 h26 w110", QZLang.TextOnActionAfter "(&L):")
    WinEditor.AddCtrl("Edit_OnActionAfter", "Edit", "x145 y433 h26 w300")
    WinEditor.AddCtrl("Text_OnShow", "Text", "x30 y475 h26 w110", QZLang.TextOnShow "(&F):")
    WinEditor.AddCtrl("Edit_OnShow", "Edit", "x145 y473 h26 w300")
    WinEditor.AddCtrl("Edit_Code", "Edit", "x470 y50 h510 w480")
    WinEditor.AddCtrl("Button_OK", "Button", "x260 y530 h26 w90 ", QZLang.ButtonOK)
    WinEditor.AddCtrl("Button_Close", "Button", "x370 y530 h26 w90 ", QZLang.ButtonClose)
    WinEditor.AddCtrl("Text_FoundWin", "Text", "x407 y93 w38 h38 border")
    WinEditor.AddCtrl("Pic_FoundWin", "PIC", "x410 y96 w32 h32 ", QZGlobal.CrossCUR)
    WinEditor.Show()
    ;WinEditor.Scroll := New ScrollGUI(WinEditor.hwnd, 800, 800, "", 2, 2)
    ;WinEditor.Scroll.Show(QZLang.ItemEditor, "ycenter xcenter")
    TBAdv  := Toolbar_Add(WinEditor.hwnd, "GUI_ItemEditor_Event", "Flat Tooltips Menu", "1S", "x470 y18 h26 w300")
    ;Toolbar_Insert(TBAdv, QZLang.ItemEditorShowAdv ", 1 ")
    Toolbar_Insert(TBAdv, ",1" )
    Toolbar_Insert(TBAdv, ",2" )
    Toolbar_Insert(TBAdv, ",3" )
    Toolbar_Insert(TBAdv, ",4" )
    Toolbar_Insert(TBAdv, ",5" )

    WinEditor.Pic_FoundWin.OnEvent("GUI_WinEditor_PicCross")
    WinEditor.Button_OK.SetIcon(QZGlobal.DefaultIcl, 30)
    WinEditor.Button_OK.OnEvent(Callback)
    If Strlen(CloseEvent)
    {
        WinEditor.Button_Close.OnEvent(CloseEvent)
        WinEditor.OnClose(CloseEvent)
    }
    Else
    {
        WinEditor.Button_Close.OnEvent("GUI_WinEditor_Destroy")
    }
}

GUI_WinEditor_Dump()
{
    Global WinEditor
    Return WinEditor
}

GUI_WinEditor_Destroy()
{
    Global WinEditor
    WinEditor.Destroy()
}

GUI_WinEditor_Save(ByRef aObjWin)
{
    Global WinEditor
    aObjWin.Name := WinEditor.Edit_WinName.GetText()
    aObjWin.WinClass := WinEditor.Edit_WinClass.GetText()
    aObjWin.WinExe := WinEditor.Edit_WinExe.GetText()
    aObjWin.Code := WinEditor.Edit_Code.GetText()
    aObjWin.Options := {}
    aObjWin.Options.TimeOut := WinEditor.Edit_TimeOut.GetText()
    aObjWin.Options.MaxCount := WinEditor.Edit_MaxCount.GetText()
    aObjWin.Options.DefaultMode := WinEditor.DDL_DefalutMode.GetText()
    aObjWin.Options.OnInit := WinEditor.Edit_OnInit.GetText()
    aObjWin.Options.OnChangeMode := WinEditor.Edit_OnChangeMode.GetText()
    aObjWin.Options.OnActionBefore := WinEditor.Edit_OnActionBefore.GetText()
    aObjWin.Options.OnActionAfter := WinEditor.Edit_OnActionAfter.GetText()
    aObjWin.Options.OnShow := WinEditor.Edit_OnShow.GetText()
    aObjWin.Options.Disable := WinEditor.CB_Disable.GetText()
}

GUI_WinEditor_LoadData(aObjWin)
{
    Global WinEditor
    WinEditor.IsModify := True
    WinEditor.Edit_WinName.SetText(aObjWin.Name)
    WinEditor.Edit_WinClass.SetText(aObjWin.WinClass)
    WinEditor.Edit_WinExe.SetText(aObjWin.WinExe)
    WinEditor.Edit_TimeOut.SetText(aObjWin.Options.TimeOut)
    WinEditor.Edit_MaxCount.SetText(aObjWin.Options.MaxCount)
    WinEditor.Edit_OnInit.SetText(aObjWin.Options.OnInit)
    WinEditor.Edit_OnChangeMode.SetText(aObjWin.Options.OnChangeMode)
    WinEditor.Edit_OnActionBefore.SetText(aObjWin.Options.OnActionBefore)
    WinEditor.Edit_OnActionAfter.SetText(aObjWin.Options.OnActionAfter)
    WinEditor.Edit_OnShow.SetText(aObjWin.Options.OnShow)
    WinEditor.Edit_Code.SetText(aObjWin.Code)
    If aObjWin.Options.Disable
        WinEditor.CB_Disable.SetText(True)
    Else
        WinEditor.CB_Disable.SetText(False)
    Modes := ""
    Loop % aObjWin.Modes.MaxIndex()
        Modes .= aObjWin.Modes[A_Index].Name "|"
    WinEditor.DDL_DefalutMode.SetText(Modes)
    WinEditor.DDL_DefalutMode.ChooseString(aObjWin.Options.DefaultMode)
}


GUI_WinEditor_SetTemplete(aName:="New")
{
    Global WinEditor
    aName := RegExReplace(aName, "\-", "_")
    WinEditor.Edit_TimeOut.SetText(800)
    WinEditor.Edit_MaxCount.SetText(99)
    WinEditor.DDL_DefalutMode.SetText(QZLang.TextNormalMode)
    WinEditor.DDL_DefalutMode.ChooseString(QZLang.TextNormalMode)
    WinEditor.Edit_OnInit.SetText(aName "_Init")
    WinEditor.Edit_OnChangeMode.SetText(aName "_ChangeMode")
    WinEditor.Edit_OnActionBefore.SetText(aName "_ActionBefore")
    WinEditor.Edit_OnActionAfter.SetText(aName "_ActionAfter")
    ;WinEditor.Edit_OnShow.SetText(aName "_Show")

Templeate=
(
/*
    功能：QuickZ在加载的时候执行此函数
*/
<Name>_Init()
{
    Global VimD
}

/*
    功能：每次切换模式的时候执行此函数
*/
<Name>_ChangeMode()
{
    Global VimD
}

/*
    功能：按下热键后，热键对应的功能执行前，会运行此函数
    * 默认返回False，功能正常执行。
    * 如果返回True，功能不会执行。
    可以利用这个函数设置自动判断模式
*/
<Name>_ActionBefore()
{
    Global VimD
}

/*
    功能：热键对应的功能执行后，会运行此函数。
    函数不需要返回值
    可以利用这个函数来做状态提醒
*/
<Name>_ActionAfter()
{
    Global VimD
}

/*
    功能：热键提醒，用于提示当前有效热键
    QuickZ会传递当前有效热键列表到此函数中。所以需要预留两个参数
    aTemp - 当前热键缓存
    aMore - 符合当前热键缓存的更多热键
*/
<Name>_Show(aTemp, aMore)
{
    Global VimD
}
)
    RTNTemp := ""
    Loop, Parse, Templeate, `n, `r
    {
        RTNTemp .= RegExReplace(A_LoopField, "<Name>", aName) "`n"
    }
    WinEditor.Edit_Code.SetText(RTNTemp)
}




GUI_WinEditor_PicCross()
{
    Global WinEditor, gQZConfig
    iCursor := DllCall("LoadCursorFromFile", Str, QZGlobal.CrossCUR)
    DllCall( "SetSystemCursor", Uint, iCursor, Int,32512 )
    WinEditor.Cursor := iCursor
    pToken := GDIP_StartUp()
    Gui, _987: -Caption +E0x80000 +hwndhID +LastFound +OwnDialogs +Owner +AlwaysOnTop
    Gui, _987: Show, NA
    hbm := CreateDIBSection(A_ScreenWidth, A_ScreenHeight)
    hdc := CreateCompatibleDC()
    obm := SelectObject(hdc, hbm)
    G := Gdip_GraphicsFromHDC(hdc)
    Gdip_SetSmoothingMode(G, 4)
    pPen := Gdip_CreatePen(0xFFFF0000,3)
    WinEditor.objCross := {"HWND":hID, "Token":pToken, "Pen":pPen
                             , "G":G, "HDC":HDC, "Ctrl":aCtrlName, "Text":WinEditor["Edit_" aCtrlName].GetText()}
    SetTimer, _FoundWinInfo, 200
    KeyWait,LButton
    SetTimer, _FoundWinInfo, Off
    Gdip_DeletePen(pPen)
    SelectObject(hdc, obm)
    DeleteObject(hbm)
    DeleteDC(hdc)
    Gdip_DeleteGraphics(G)
    Gdip_Shutdown(pToken)
    GUI, _987:Destroy
    ;还原鼠标指针
    DllCall( "SystemParametersInfo", UInt,0x57, UInt,0, UInt,0, UInt,0 )
    If !WinEditor.IsModify
    {
        newName := RegExReplace(newExe, "\.[^\.]*$")
        Loop % gQZConfig.VimD.MaxIndex()
        {
            OldName := RegExReplace(gQZConfig.VimD[A_Index].WinExe, "\.[^\.]*$")
            If InStr(oldName, newName)
                sameNameList .= oldName "`n"
            If (oldName = newName)
                sameName := oldName
        }
        If StrLen(sameName)
            InputBox, newName, Title, % sameName "`n" sameNameList
        GUI_WinEditor_SetTemplete(newName)
    }
    Return

    _FoundWinInfo:
        objGUI := GUI_WinEditor_Dump()
        MouseGetPos,,,id, FocusCtrl
        WinGetPos,x,y,w,h,ahk_id %id%
        WinGetTitle, newTitle, ahk_id %id%
        WinGetClass, newClass, ahk_id %id%
        WinGet, newExe, processName, ahk_Id %id%
        x < 0 ? x := 0 
        y < 0 ? y := 0
        w < 0 ? w := 3
        h < 0 ? h := 3
        Gdip_GraphicsClear(objGUI.objCross.G)
        Gdip_DrawRectangle(objGUI.objCross.G,objGUI.objCross.Pen,x+1,y+1,w-2,h-2)
        UpdateLayeredWindow(objGUI.objCross.hwnd, objGUI.objCross.HDC, 0, 0, A_ScreenWidth, A_ScreenHeight)
        ;objGUI.Edit_WinName.SetText(newTitle)
        objGUI.Edit_WinClass.SetText(newClass)
        objGUI.Edit_WinExe.SetText(newExe)
        /*
        If !StrLen(objGUI.Edit_OnInit.GetText())
         &&!StrLen(objGUI.Edit_OnChangeMode.GetText())
         &&!StrLen(objGUI.Edit_OnActionBefore.GetText())
         &&!StrLen(objGUI.Edit_OnActionAfter.GetText())
         &&!StrLen(objGUI.Edit_OnShow.GetText())
        {
            GUI_WinEditor_SetTemplete(RegExReplace(newExe, "\.[^\.]*$"))
        }
        */
    Return
}
