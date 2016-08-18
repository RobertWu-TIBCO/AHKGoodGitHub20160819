/* 
    Title:  Class_GUI2 
        将GUI编写对象化
        作者: Array
*/

/*
    Class: GUI2
*/

Class GUI2
{
    __New(pName, pOptions="", pTitle="")
    {
        Gui, %pName%: New, %pOptions%, %pTitle%
        This.GUIName := pName
        This._ObjCtrlList := {}
        This._ObjCtrlConfig := {}
        This.SetOptions(pOptions)
        GUI2._Instance[pName] := This
        GUI2._InstanceHwnd[This.hwnd] := This
        This._CtrlTip := New GuiControlTips(this.Hwnd)
    }

    Import(pINI)
    {
        IniRead, FontOpt, %pINI%, Font, Option
        IniRead, FontName, %pINI%, Font, Name
        This.Font(FontOpt, FontName)
        Iniread, Sections, %pINI%
        Loop, Parse, Sections, `n
        {
            If not Strlen(A_LoopField)
                Continue
            If (A_LoopField = "Font")
                Continue
            Iniread, iType, %pINI%, %A_LoopField%, Type
            Iniread, iOptions, %pINI%, %A_LoopField%, Options
            Iniread, iText, %pINI%, %A_LoopField%, Text
            This.AddCtrl(A_LoopField, iType, iOptions, iText)
        }
    }

    Export(pINI)
    {
        For CtrlName, Obj In This._ObjCtrlConfig
        {
            iType := Obj.Type
            iOptions := Obj.Options
            iText := Obj.Text
            IniWrite, %iType% , %pINI%, %CtrlName%, Type
            IniWrite, %iOptions% , %pINI%, %CtrlName%, Options
            IniWrite, %iText% , %pINI%, %CtrlName%, Text
        }
        FontOpt := This._FontOption
        FontName := This._FontName
        IniWrite, %FontOpt%, %pINI%, Font, Option
        IniWrite, %FontName%, %pINI%, Font, Name
    }


    AddCtrl(pCtrlName, pType, pOptions="", pText="")
    {
        If RegExMatch(pCtrlName, "i)(guiname|hwnd|(^_.*))")
        {
            msgbox Error control name : %pCtrlName%
            Return
        }
        This._ObjCtrlConfig[pCtrlName] := {Type:pType, Options:pOptions, Text:pText}
        pName := This.GUIName
        Gui, %pName%: Add, %pType%, %pOptions% HwndhCtrl, %pText%
        If (pType = "ListView")
            This[pCtrlName] := new cListView(This.GUIName, hCtrl)
        Else If (pType = "TreeView")
            This[pCtrlName] := new cTreeView(This.GUIName, hCtrl)
        Else If (pType = "ComboBox")
            This[pCtrlName] := new cComboBox(This.GUIName, hCtrl)
        Else If (pType = "Button")
            This[pCtrlName] := new cButton(This.GUIName, hCtrl)
        Else If (pType = "ListBox")
            This[pCtrlName] := new cListBox(This.GUIName, hCtrl)
        Else If (pType = "Edit")
            This[pCtrlName] := new cEdit(This.GUIName, hCtrl)
        Else If (pType = "Pic") || (pType = "Picture")
            This[pCtrlName] := new cPic(This.GUIName, hCtrl)
        Else If (pType = "DDL") || (pType = "DropDownList")
            This[pCtrlName] := new cDropDownList(This.GUIName, hCtrl)
        Else
            This[pCtrlName] := new ControlBase(This.GUIName, hCtrl)
        Return This[pCtrlName]
    }

    Show(pOptions="", pTitle="")
    {
        pName := This.GUIName
        Gui, %pName%: Show, %pOptions%, %pTitle%
    }

    Cancel()
    {
        msgbox c
        pName := This.GUIName
        Gui, %pName%: Cancel
    }

    Destroy()
    {
        pName := This.GUIName
        Gui, %pName%: Destroy
    }

    Hotkey(aKeyName, aLabel, aOptions:="ON")
    {
        iHwnd := this.Hwnd
        Hotkey, IfWinActive, ahk_id %iHwnd%
        Hotkey, %aKeyName%, %aLabel%, %aOptions%
        Return ErrorLevel
    }

    SetFont(pFontOpt, pFontName="")
    {
        pName := This.GUIName
        This._FontOption := pFontOpt
        This._FontName := pFontName
        Gui, %pName%: Font, %pFontOpt%, %pFontName%
    }

    SetColor(WinBKColor, CtrlBKColor="")
    {
        pName := This.GUIName
        Gui, %pName%: Color, %WinBKColor%, %CtrlBKColor%
    }

    SetMargin(pX, pY)
    {
        pName := This.GUIName
        Gui, %pName%: Margin, %pX%, %pY%
    }

    SetOptions(pOpt)
    {
        pName := This.GUIName
        pOpt .= " +hwndhWin +Label_GUI2"
        Gui, %pName%: %pOpt%
        This.hwnd := hWin
    }

    SetMenu(pMenuName)
    {
        pName := This.GUIName
        Gui, %pName%: Menu, %pMenuName%
    }

    Min()
    {
        pName := This.GUIName
        Gui, %pName%: Minimize
    }

    Max()
    {
        pName := This.GUIName
        Gui, %pName%: Maximize
    }

    Restore()
    {
        pName := This.GUIName
        Gui, %pName%: Hide
    }

    Hide()
    {
        pName := This.GUIName
        Gui, %pName%: Hide
    }

    Default()
    {
        pName := This.GUIName
        Gui, %pName%: Default
    }

    GetFocus()
    {
        This.Default()
        GuiControlGet, _FC, Focus
        Return _FC
    }
    
    GetFocusHwnd()
    {
        This.Default()
        GuiControlGet, _FC, Focus
        GuiControlGet, _Hwnd, Hwnd, %_FC%
        Return _Hwnd
    }

    Close()
    {
        pLabel := This._OnClose
        If IsLabel(pLabel)
            GoSub, %pLabel%
        Else If IsFunc(pLabel)
            %pLabel%()
        This.Destroy()
    }

    Disable()
    {
        _hwnd := this.hwnd
        WinSet, Disable, , ahk_id %_hwnd%
    }

    Enable()
    {
        _hwnd := this.hwnd
        WinSet, Enable, , ahk_id %_hwnd%
    }

    Redraw()
    {
        _hwnd := this.hwnd
        WinSet, Redraw, , ahk_id %_hwnd%
    }

    OnClose(pLabel)
    {
        This._OnClose := pLabel
    }

    OnEscape(pLabel)
    {
        This._OnEscape := pLabel
    }
    OnSize(pLabel)
    {
        This._OnSize := pLabel
    }
    OnContextMenu(pLabel)
    {
        This._OnContextMenu := pLabel
    }
    OnDropFiles(pLabel)
    {
        This._OnDropFiles := pLabel
    }
    Move(xn, yn, wn, hn)
    {
        iHwnd := this.hwnd
        WinMove, ahk_id %iHwnd%, , %xn% , %yn% , %wn% , %hn%
    }
}


Class cPic Extends ControlBase
{
    SetIcon(aFile, aNum, aOpt:="*w16 *h-1")
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControl, , %ctrlHwnd%, *icon%aNum% %aOpt% %aFile%
    }
}

Class cEdit Extends ControlBase
{
    Append(aText)
    {
        oldText := this.GetText()
        this.SetText(oldText aText)
        ctrlHwnd := This.hwnd
        ControlSend, , {End}, ahk_id %ctrlHwnd%
    }

    InsertText(aText)
    {
        ctrlHwnd := This.hwnd
        ControlSendRaw, , %aText%, ahk_id %ctrlHwnd%
    }
}

Class cButton Extends ControlBase
{

    ; Version 1.1
    ;
    ; Function to Assign an Icon to a Gui Button
    ;
    ;------------------------------------------------
    ;
    ; Method:
    ;   GuiButtonIcon(Handle, File, Index, Size, Margin)
    ;
    ;   Parameters:
    ;   1) {Handle}     HWND handle of Gui button
    ;   2) {File}       File containing icon image
    ;   3) {Index}      Index of icon in file
    ;                       Optional: Default = 1
    ;   4) {Size}       Size of icon, generally the size of the button
    ;                       Optional: Default = 22
    ;   5) {Margin}     Margin between image and button edge
    ;                       Optional: Default = 6
    ;   6) {Align}      Alignment of icon (0 = left, 1 = right, 2 = top, 3 = bottom, 4 = center)
    ;                       Optional: Default = 4
    ;
    ; Return:
    ;   1 = icon found, 0 = icon not found
    ;
    ; Example:
    ; Gui, Add, Button, w38 h38 hwndIcon
    ; GuiButtonIcon(Icon, "imageres.dll", 46, 38, 1)

    SetIcon(File, Index := 1, Size := 22, Margin := 6, Align := 0)
    {
        This.GuiButtonIcon(This.hwnd, File, Index, Size, Margin, Align)
    }

    GuiButtonIcon(Handle, File, Index, Size, Margin, Align)
    {
        Size -= Margin
        Psz := A_PtrSize = "" ? 4 : A_PtrSize, DW := "UInt", Ptr := A_PtrSize = "" ? DW : "Ptr"
        VarSetCapacity( button_il, 20 + Psz, 0 )
        NumPut( normal_il := DllCall( "ImageList_Create", DW, Size, DW, Size, DW, 0x21, DW, 1, DW, 1 ), button_il, 0, Ptr )
        NumPut( Align, button_il, 16 + Psz, DW )
        SendMessage, BCM_SETIMAGELIST := 5634, 0, &button_il,, AHK_ID %Handle%
        Return IL_Add( normal_il, File, Index )
    }
}

Class cListBox Extends ControlBase
{
    Choose(pN)
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControl, Choose, %ctrlHwnd%, %pN%
    }

    Choosestring(pString)
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControl, ChooseString, %ctrlHwnd%, %pString%
    }

    GetChoose()
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControlGet, Num, ,%ctrlHwnd%
        Return Num
    }
}

Class cDropDownList Extends ControlBase
{
    Choose(pN)
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControl, Choose, %ctrlHwnd%, %pN%
    }

    Choosestring(pString)
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControl, ChooseString, %ctrlHwnd%, %pString%
    }
}

Class cComboBox Extends ControlBase
{
    Choose(pN)
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControl, Choose, %ctrlHwnd%, %pN%
    }

    ChooseString(pString)
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControl, ChooseString, %ctrlHwnd%, %pString%
    }
}


class cListView Extends ControlBase
{
    SetDefault()
    {
        Parent := This._ParentGUI
        ctrlHwnd := This.hwnd
        Gui, %Parent%: Default
        GUi, %Parent%: ListView, %ctrlHwnd%
    }
}

class cTreeView Extends ControlBase
{
    SetDefault()
    {
        Parent := This._ParentGUI
        ctrlHwnd := This.hwnd
        Gui, %Parent%: Default
        GUi, %Parent%: TreeView, %ctrlHwnd%
    }
    SetImageList(pListID, pMode)
    {
        This.SetDefault()
        This.ImgList := TV_SetImageList(pListID, pMode)
        Return This.ImgList
    }

}

Class ControlBase
{
    Static _x := 0, _y := 0, _w := 0, _h := 0
    Static hwnd := 0, _Class := 0
    Static _ParentGUI := ""

    __new(pParent, pHwnd)
    {
        This._ParentGUI := pParent
        This.hwnd := pHwnd
    }

    SetDefault()
    {
        Parent := This._ParentGUI
        Gui, %Parent%: Default
    }

    Tips(aText, aCenter=False)
    {
        objGUI := GUI2_GetGUIFromName(This._ParentGUI)
        objGUI._CtrlTip.Attach(This.hwnd, aText, aCenter)
    }

    GetText()
    {
        This.SetDefault()
        GUIControlGet, rVar, , % This.hwnd
        Return rVar
    }

    SetText(pString)
    {
        This.SetDefault()
        GuiControl, , % This.hwnd, %pString%
    }

    OnEvent(pLabel)
    {
        This.SetDefault()
        This.SubLabel := pLabel
        GuiControl, +G%pLabel%, % This.hwnd
    }
    
    Move(pOptions)
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControl, Move, %ctrlHwnd%, %pOptions%
    }

    Show()
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControl, Show, %ctrlHwnd%
    }

    Hide()
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControl, Hide, %ctrlHwnd%
    }

    Focus()
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControl, Focus, %ctrlHwnd%
    }

    Enable()
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControl, Enable, %ctrlHwnd%
    }

    Disable()
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControl, Disable, %ctrlHwnd%
    }

    SetFont(pFontOpt, pFontName="")
    {
        Parent := This._ParentGUI
        ctrlHwnd := This.hwnd
        This._FontOptions := pFontOpt
        This._FontName := pFontName
        Gui, %Parent%: Default
        Gui, %Parent%: Font, %pFontOpt%, %pFontName%
        GuiControl, Font, %ctrlHwnd%
    }

    SetOptions(pOptions)
    {
        This.SetDefault()
        ctrlHwnd := This.hwnd
        GuiControl, %pOptions%, %ctrlHwnd%
    }
}

GUI2_GetGUI()
{
    Return GUI2._Instance[A_Gui]
}

GUI2_GetGUIFromHwnd(pHwnd)
{
    Return GUI2._InstanceHwnd[pHwnd]
}

GUI2_GetGUIFromName(pName)
{
    Return GUI2._Instance[pName]
}

GUI2_Handler()
{
    _GUI2Close:
        ObjGUI := GUI2_GetGUI()
        If StrLen(Event := ObjGUI._OnClose)
            GUI2_HandlerSub(Event)
        Else
            ObjGUI.Destroy()
    Return
    _GUI2Escape:
        ObjGUI := GUI2_GetGUI()
        If StrLen(Event := ObjGUI._OnEscape)
            GUI2_HandlerSub(Event)
    Return
    _GUI2Size:
        ObjGUI := GUI2_GetGUI()
        If StrLen(Event := ObjGUI._OnSize)
            GUI2_HandlerSub(Event)
    Return
    _GUI2ContextMenu:
        ObjGUI := GUI2_GetGUI()
        If StrLen(Event := ObjGUI._OnContextMenu)
            GUI2_HandlerSub(Event)
    Return
    _GUI2DropFiles:
        ObjGUI := GUI2_GetGUI()
        If StrLen(Event := ObjGUI._OnDropFiles)
            GUI2_HandlerSub(Event)
    Return
}

GUI2_HandlerSub(pLabel)
{
    If IsFunc(pLabel)
        %pLabel%()
    Else If IsLabel(pLabel)
        GoSub, %pLabel%
}


; ======================================================================================================================
; Namespace:      GuiControlTips
; AHK version:    AHK 1.1.14.03
; Function:       Helper object to simply assign ToolTips for GUI controls
; Tested on:      Win 7 (x64)
; Change history: 
;                 1.1.00.00/2014-03-06/just me - Added SetDelayTimes()
;                 1.0.01.00/2012-07-29/just me
; ======================================================================================================================
; CLASS GuiControlTips
;
; The class provides four public methods to register (Attach), unregister (Detach), update (Update), and
; disable/enable (Suspend) common ToolTips for GUI controls.
;
; Usage:
; To assign ToolTips to GUI controls you have to create a new instance of GuiControlTips per GUI with
;     MyToolTipObject := New GuiControlTips(HGUI)
; passing the HWND of the GUI.
;
; After this you may assign ToolTips to your GUI controls by calling
;     MyToolTipObject.Attach(HCTRL, "ToolTip text")
; passing the HWND of the control and the ToolTip's text. Pass True/1 for the optional third parameter if you
; want the ToolTip to be shown centered below the control.
;
; To remove a ToolTip call
;     MyToolTipObject.Detach(HCTRL)
; passing the HWND of the control.
;
; To update the ToolTip's text call
;     MyToolTipObject.Update(HCTRL, "New text!")
; passing the HWND of the control and the new text.
;
; To deactivate the ToolTips call
;     MyToolTipObject.Suspend(True),
; to activate them again afterwards call
;     MyToolTipObject.Suspend(False).
;
; To adjust the ToolTips delay times call
;     MyToolTipObject.SetDelayTimesd(),
; specifying the delay times in milliseconds.
;
; That's all you can / have to do!
; ======================================================================================================================
Class GuiControlTips {
   ; ===================================================================================================================
   ; INSTANCE variables
   ; ===================================================================================================================
   HTIP := 0
   HGUI := 0
   CTRL := {}
   ; ===================================================================================================================
   ; CONSTRUCTOR           __New()
   ; ===================================================================================================================
   __New(HGUI) {
      Static CLASS_TOOLTIP      := "tooltips_class32"
      Static CW_USEDEFAULT      := 0x80000000
      Static TTM_SETMAXTIPWIDTH := 0x0418
      Static TTM_SETMARGIN      := 0x041A
      Static WS_STYLES          := 0x80000002 ; WS_POPUP | TTS_NOPREFIX
      ; Create a Tooltip control ...
      HTIP := DllCall("User32.dll\CreateWindowEx", "UInt", WS_EX_TOPMOST, "Str", CLASS_TOOLTIP, "Ptr", 0
                    , "UInt", WS_STYLES
                    , "Int", CW_USEDEFAULT, "Int", CW_USEDEFAULT, "Int", CW_USEDEFAULT, "Int", CW_USEDEFAULT
                    , "Ptr", HGUI, "Ptr", 0, "Ptr", 0, "Ptr", 0, "Ptr")
      If ((ErrorLevel) || !(HTIP))
         Return False
      ; ... prepare it to display multiple lines if required
      DllCall("User32.dll\SendMessage", "Ptr", HTIP, "Int", TTM_SETMAXTIPWIDTH, "Ptr", 0, "Ptr", 0)
      ; ... set the instance variables
      This.HTIP := HTIP
      This.HGUI := HGUI
      If (DllCall("Kernel32.dll\GetVersion", "UInt") & 0xFF) < 6 ; to avoid some XP issues ...
         This.Attach(HGUI, "") ; ... register the GUI with an empty tiptext
   }
   ; ===================================================================================================================
   ; DESTRUCTOR            __Delete()
   ; ===================================================================================================================
   __Delete() {
      If (This.HTIP) {
         DllCall("User32.dll\DestroyWindow", "Ptr", This.HTIP)
      }
   }
   ; ===================================================================================================================
   ; PRIVATE METHOD        SetToolInfo - Create and fill a TOOLINFO structure
   ; ===================================================================================================================
   SetToolInfo(ByRef TOOLINFO, HCTRL, TipTextAddr, CenterTip = 0) {
      Static TTF_IDISHWND  := 0x0001
      Static TTF_CENTERTIP := 0x0002
      Static TTF_SUBCLASS  := 0x0010
      Static OffsetSize  := 0
      Static OffsetFlags := 4
      Static OffsetHwnd  := 8
      Static OffsetID    := OffsetHwnd + A_PtrSize
      Static OffsetRect  := OffsetID + A_PtrSize
      Static OffsetInst  := OffsetRect + 16
      Static OffsetText  := OffsetInst + A_PtrSize
      Static StructSize  := (4 * 6) + (A_PtrSize * 6)
      Flags := TTF_IDISHWND | TTF_SUBCLASS
      If (CenterTip)
         Flags |= TTF_CENTERTIP
      VarSetCapacity(TOOLINFO, StructSize, 0)
      NumPut(StructSize, TOOLINFO, OffsetSize, "UInt")
      NumPut(Flags, TOOLINFO, OffsetFlags, "UInt")
      NumPut(This.HGUI, TOOLINFO, OffsetHwnd, "Ptr")
      NumPut(HCTRL, TOOLINFO, OffsetID, "Ptr")
      NumPut(TipTextAddr, TOOLINFO, OffsetText, "Ptr")
      Return True
   }
   ; ===================================================================================================================
   ; PUBLIC METHOD         Attach         -  Assign a ToolTip to a certain control
   ; Parameters:           HWND           -  Control's HWND
   ;                       TipText        -  ToolTip's text
   ;                       Optional:      ------------------------------------------------------------------------------
   ;                       CenterTip      -  Centers the tooltip window below the control
   ;                                         Values:  True/False
   ;                                         Default: False
   ; Return values:        On success: True
   ;                       On failure: False
   ; ===================================================================================================================
   Attach(HCTRL, TipText, CenterTip = False) {
      Static TTM_ADDTOOL  := A_IsUnicode ? 0x0432 : 0x0404 ; TTM_ADDTOOLW : TTM_ADDTOOLA
      If !(This.HTIP) {
         Return False
      }
      If This.CTRL.HasKey(HCTRL)
         Return False
      TOOLINFO := ""
      This.SetToolInfo(TOOLINFO, HCTRL, &TipText, CenterTip)
      If DllCall("User32.dll\SendMessage", "Ptr", This.HTIP, "Int", TTM_ADDTOOL, "Ptr", 0, "Ptr", &TOOLINFO) {
         This.CTRL[HCTRL] := 1
         Return True
      } Else {
        Return False
      }
   }
   ; ===================================================================================================================
   ; PUBLIC METHOD         Detach         -  Remove the ToolTip for a certain control
   ; Parameters:           HWND           -  Control's HWND
   ; Return values:        On success: True
   ;                       On failure: False
   ; ===================================================================================================================
   Detach(HCTRL) {
      Static TTM_DELTOOL  := A_IsUnicode ? 0x0433 : 0x0405 ; TTM_DELTOOLW : TTM_DELTOOLA
      If !This.CTRL.HasKey(HCTRL)
         Return False
      TOOLINFO := ""
      This.SetToolInfo(TOOLINFO, HCTRL, 0)
      DllCall("User32.dll\SendMessage", "Ptr", This.HTIP, "Int", TTM_DELTOOL, "Ptr", 0, "Ptr", &TOOLINFO)
      This.CTRL.Remove(HCTRL, "")
      Return True
   }
   ; ===================================================================================================================
   ; PUBLIC METHOD         Update         -  Update the ToolTip's text for a certain control
   ; Parameters:           HWND           -  Control's HWND
   ;                       TipText        -  New text                                                      
   ; Return values:        On success: True
   ;                       On failure: False
   ; ===================================================================================================================
   Update(HCTRL, TipText) {
      Static TTM_UPDATETIPTEXT  := A_IsUnicode ? 0x0439 : 0x040C ; TTM_UPDATETIPTEXTW : TTM_UPDATETIPTEXTA
      If !This.CTRL.HasKey(HCTRL)
         Return False
      TOOLINFO := ""
      This.SetToolInfo(TOOLINFO, HCTRL, &TipText)
      DllCall("SendMessage", "Ptr", This.HTIP, "Int", TTM_UPDATETIPTEXT, "Ptr", 0, "Ptr", &TOOLINFO)
      Return True
   }
   ; ===================================================================================================================
   ; PUBLIC METHOD         Suspend        -  Disable/enable the ToolTip control (don't show / show ToolTips)
   ; Parameters:           Mode           -  True/False (1/0)
   ;                                         Default: True/1
   ; Return values:        On success: True
   ;                       On failure: False
   ; Remarks:              ToolTips are enabled automatically on creation.
   ; ===================================================================================================================
   Suspend(Mode = True) {
      Static TTM_ACTIVATE := 0x0401
      If !(This.HTIP)
         Return False
      DllCall("SendMessage", "Ptr", This.HTIP, "Int", TTM_ACTIVATE, "Ptr", !Mode, "Ptr", 0)
      Return True
   }
   ; ===================================================================================================================
   ; PUBLIC METHOD         SetDelayTimes  -  Set the initial, pop-up, and reshow durations for a tooltip control.
   ; Parameters:           Init           -  Amount of time, in milliseconds, a pointer must remain stationary within
   ;                                         a tool's bounding rectangle before the tooltip window appears.
   ;                                         Default: -1 (system default time)
   ;                       PopUp          -  Amount of time, in milliseconds, a tooltip window remains visible if the
   ;                                         pointer is stationary within a tool's bounding rectangle.
   ;                                         Default: -1 (system default time)
   ;                       ReShow         -  Amount of time, in milliseconds, it takes for subsequent tooltip windows
   ;                                         to appear as the pointer moves from one tool to another.
   ;                                         Default: -1 (system default time)
   ; Return values:        On success: True
   ;                       On failure: False
   ; Remarks:              Times are set per ToolTip control and applied to all added tools.
   ; ===================================================================================================================
   SetDelayTimes(Init = -1, PopUp = -1, ReShow = -1) {
      Static TTM_SETDELAYTIME   := 0x0403
      Static TTDT_RESHOW   := 1
      Static TTDT_AUTOPOP  := 2
      Static TTDT_INITIAL  := 3
      DllCall("SendMessage", "Ptr", This.HTIP, "Int", TTM_SETDELAYTIME, "Ptr", TTDT_INITIAL, "Ptr", Init)
      DllCall("SendMessage", "Ptr", This.HTIP, "Int", TTM_SETDELAYTIME, "Ptr", TTDT_AUTOPOP, "Ptr", PopUp)
      DllCall("SendMessage", "Ptr", This.HTIP, "Int", TTM_SETDELAYTIME, "Ptr", TTDT_RESHOW , "Ptr", ReShow)
   }
}

