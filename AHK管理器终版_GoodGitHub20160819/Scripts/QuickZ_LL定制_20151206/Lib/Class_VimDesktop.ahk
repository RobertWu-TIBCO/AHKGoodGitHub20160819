/*
    Class: VimDesktop
        VIM化程序
*/

Class VimDesktop
{
    __new()
    {
        This.GlobalWin := new VimWin
        This.SuperKeys := {}
        This.GlobalWin.Name := "Global"
        This.KeyFunc := ""
        This.ActionFunc := ""
        This.TimeOutFunc := ""
        This.ShowFunc := ""
        This.OnKeyCacheVoid := True ; 热键缓存无效时响应方式
        This._Instance := {}
        This._InstanceClass := {}
        This._InstanceExe := {}
        This._ExcludeClass := {}
        This._ExcludeExe := {}
        This._VimList := {}
        This._VimModifier := {}
        This._VimModifierSend := {}
        This._AHKList := {}
        This._AhkModifier := {}
        This._HotkeyList()
    }
    
    /*
        Function: GetActiveWin
            获取当前VimWin对象
        
        Return: VimWin对象
    */
    GetActiveWin()
    {
        ActiveWin := WinExist("A")
        WinGetClass, ActiveClass, ahk_id %ActiveWin%
        WinGet, ActiveExe, ProcessName, ahk_id %ActiveWin%
        If !IsObject(objWin:=This._InstanceClass[ActiveClass])
        {
            If !IsObject(objWin := This._InstanceExe[ActiveExe])
                objWin := This.GlobalWin
        }
        Return objWin
    }

    /*
        Function: GetWin
            获取特定窗口名对应的VimWin对象
        
        Return: VimWin对象
    */
    GetWin(aName:="")
    {
        If Strlen(aName)
        {
            If !IsObject(objWin := This._Instance[aName])
                Throw Exception("Not Exist Win:" aName, -1)
        }
        Else
        {
            objWin := This.GlobalWin
        }
        Return objWin
    }
    
    /*
        Function: SetWin
            设置VimWin对象
        
        Return: 返回一个VimWin对象
    */
    SetWin(aName:="", aClass:="", aFile:="")
    {
        If IsObject(This._InstanceClass[aClass]) && Strlen(aClass)
            Return This._InstanceClass[aClass]
        If IsObject(This._InstanceExe[aFile]) && Strlen(aFile)
            Return This._InstanceExe[aFile]
        If !Strlen(aClass) && !Strlen(aFile)
            Return This.GlobalWin
        newWin := new VimWin
        newWin.Name := aName
        newWin.WinClass := aClass
        newWin.WinExe := aFile
        This._InstanceClass[aClass] := newWin
        This._InstanceExe[aFile] := newWin
        This._Instance[aName] := newWin
        Return newWin
    }
    
    /*
        Function: GetMode
            获取指定程序中的模式
        
        Parameters:
            aWin  - VimWin窗口对象
            aName - 模式名，如果为空，返回当前程序的默认模式
        
        Return:
            返回一个VimMode模式对象
    */
    GetMode(aWin, aName:="")
    {
        If !IsObject(aWin)
            aWin := This.GetWin(aWin)
        If !Strlen(aName)
            aName := aWin.ExistMode
        Return aWin.Modes[aName]
    }
    
    /*
        Function: SetMode(aName, aWin)
            新建模式，如果有当前，则直接返回
         
        Parameters:
            aName - 模式名
        
        Return:
            返回一个VimMode模式对象
    */
    SetMode(aName, aWin)
    {
        If !IsObject(aWin)
            aWin := This.GetWin(aWin)
        If !IsObject(newMode:=aWin.Modes[aName])
        {
            newMode := new VimMode
            newMode.Name := aName
            newMode.OwnerWin := aWin
            aWin.ExistMode := aName
            aWin.Modes[aName] := newMode
        }
        Return newMode
    }
    
    /*
        Function: ChangeMode
            切换模式，不会新建模式
         
        Parameters:
            aName - 模式名
            aWin - objWin对象
        
        Return:
            返回一个VimMode模式对象
    */
    ChangeMode(aName, aWin:="")
    {
        If !IsObject(aWin) && Strlen(aWin)
            aWin := This.GetWin(aWin)
        Else If !IsObject(aWin) && !Strlen(aWin)
            aWin := This.GetActiveWin()
        objMode := aWin.Modes[aName]
        If !IsObject(objMode)
            Throw Exception("Not Exist Mode:" aName, -1 , aWin.Name)
        If (aName <> aWin.ExistMode)
        {
            OldMode := aWin.Modes[aWin.ExistMode]
            aWin.ExistMode := aName
            aWin.Count := 0
            aWin.KeyTemp := ""
            NewMode := aWin.Modes[aName]
            For VimKey , Obj In OldMode.Maps
                This.MapCtrl(VimKey, OldMode, "Off")
            For VimKey , Obj In NewMode.Maps
                This.MapCtrl(VimKey, NewMode, "On")
            If IsFunc(F:=aWin.OnChangeMode)
                %F%()
        }
        Return objMode
    }

    Clear()
    {
        objWin := This.GetActiveWin()
        objWin.Count := 0
        objWin.KeyTemp := ""
        objWin.KeyTempCount := 0
    }
    
    /*
        Function: Map
            映射热键
        
        Parameters:
            aKey - 热键名
            aUUID - 配置中UUID对应的对象
            aMode - VimMode对象
    */
    Map(aKey, aUUID, aMode)
    {
        ahkclass := "ahk_class "
        ahkExe   := "ahk_exe "
        Try
        {
            objVK := This.GetKeyObject(aKey)
            objVK.UUID := aUUID
            If objVK.Super
            {
                This.SuperKeys[objVK.String] := objVK
            }
            Else
            {
                aMode.Maps[objVK.String] := objVK
                aMode.MapList := aMode.MapList . objVK.String "`n"
            }
            Loop % objVK.List.MaxIndex()
            {
                LoopKey := objVK.List[A_Index]
                If Strlen(aMode.OwnerWin.WinClass)
                {
                    xHotkey.IfWinActive(ahkclass aMode.OwnerWin.WinClass)
                    xHotkey(LoopKey, This.KeyFunc)
                }
                If Strlen(aMode.OwnerWin.WinExe)
                {
                    xHotkey.IfWinActive(ahkExe aMode.OwnerWin.WinExe)
                    xHotkey(LoopKey, This.KeyFunc)
                }
                If (!Strlen(aMode.OwnerWin.WinClass) && !Strlen(aMode.OwnerWin.WinExe)) || objVK.Super
                {
                    xHotkey.IfWinActive()
                    xHotkey(LoopKey, This.KeyFunc)
                }
            }
            xHotkey.IfWinActive()
        }
        Catch objError
            msgbox % "map" aKey "`nis" objError.extra " error"
    }

    MapCtrl(aKey, aMode, Event:="Off")
    {
        ahkclass := "ahk_class "
        ahkExe   := "ahk_exe "
        Try
        {
            objVK := This.GetKeyObject(aKey)
            If This.SuperKeys[objVK.String]
                Return
            Loop % objVK.List.MaxIndex()
            {
                LoopKey := objVK.List[A_Index]
                If Strlen(aMode.OwnerWin.WinClass)
                {
                    xHotkey.IfWinActive(ahkclass aMode.OwnerWin.WinClass)
                    xHotkey(LoopKey, Event)
                }
                If Strlen(aMode.OwnerWin.WinExe)
                {
                    xHotkey.IfWinActive(ahkExe aMode.OwnerWin.WinExe)
                    xHotkey(LoopKey, Event)
                }
                If !Strlen(aMode.OwnerWin.WinClass) && !Strlen(aMode.OwnerWin.WinExe)
                {
                    xHotkey.IfWinActive()
                    xHotkey(LoopKey, Event)
                }
            }
            xHotkey.IfWinActive()
        }
        Catch objError
            msgbox % "unmap " aKey "`nis " objError.extra " error"
    }
    
    /*
        Function: Key
            执行按键

        热键列表:
            <super>  - 超级热键
            <nowait> - 不受TimeOut限制
            <c-j>    - 表示 control & j 
            <a-j>    - 表示 alt & j 
            <s-j>    - 表示 alt & j
            <cs-j>   - 表示 control & shift & j
            <csa-j>  - 表示 control & shift & alt & j
            <esc>    - 表示特殊热键
            <>>      - 转义热键
        
        Exampel:
            (start code)
                j       
                <c-j>k 
                <super><esc>
            (End)
    */
    Key()
    {
        Try
        {
            objWin := This.GetActiveWin()
            _ActBefore := objWin.OnActionBefore
            _ActAfter  := objWin.OnActionAfter
            strTemp := objWin.AppendKeyTemp(VimKey:=This.CheckCapsLock(This.Convert2VIM(A_ThisHotkey)))
            This.DebugAdd(objWin.Name "|" VIMKey "|" A_ThisHotkey "`n")
            If IsObject(objKey := This.SuperKeys[VimKey])
            {
                _Func := This.ActionFunc
                %_Func%(ObjKey)
                Return
            }
            If Strlen(This._ExcludeClass[objWin.WinClass]) 
            || Strlen(This._ExcludeExe[objWin.WinExe])
            || ( %_ActBefore%() && IsFunc(_ActBefore))
            {
                SendInput % this.Convert2AHK(VimKey, ToSend:=True)
                %_ActAfter%()
                Return
            }
            objMode := This.GetMode(objWin)
            objKeyCache := objMode.Maps[strTemp]
            objKeyThis  := objMode.Maps[VimKey]
            _TO := This.TimeOutFunc
            _Tick := objWin.TimeOut
            If RegExMatch(objKeyThis.UUID, "^<(\d)>$", Match) && RegExMatch(strTemp, "^\d*$")
            {
                objWin.Count := objWin.Count * 10 + Match1
                If !objWin.MaxCount
                    objWin.MaxCount := 999
                If (objWin.Count > objWin.MaxCount)
                    objWin.Count := objWin.MaxCount
                strTemp := ""
                objWin.KeyTemp := ""
                objWin.KeyTempCount := 0
            }
            ; 是否有更多热键？
            Else If Strlen(strMore := this.GetMore(strTemp, objWin))
            {
                ; 有更多热键，是否用超时？
                If objWin.TimeOut && IsObject(objKeyCache) ;Strlen(strUUID)
                    SetTimer, %_TO%, %_Tick%
            }
            Else
            {
                ; 没有更多热键，是否执行功能？
                If IsObject(objKeyCache) ;Strlen(strUUID)
                {
                    SetTimer, %_TO%, Off
                    This.ActionDo(objKeyCache, objWin)
                    objWin.Clear()
                    strTemp := ""
                    strMore := ""
                }
                Else If Strlen(strMore := this.GetMore(VimKey, objWin))
                {
                    ; 如果无法执行，现有热键作为首个热键进行缓存。是否有更多热键
                    strTemp := VimKey
                    objWin.KeyTemp := VimKey
                }
                Else If IsObject(objKeyThis) && This.OnKeyCacheVoid
                {
                    ; 热键缓存无效时，再判断ThisHotkey对应的功能是否存在，如存在则执行。
                    This.ActionDo(objKeyThis, objWin)
                    objWin.Clear()
                    strTemp := ""
                    strMore := ""
                }
                Else
                {
                    ; 没有的话，按正常输出吧。
                    If (objWin.KeyTempCount = 1)
                        SendInput % this.Convert2AHK(VimKey, ToSend:=True)
                    objWin.Clear()
                    strTemp := ""
                    strMore := ""
                }
            }
            This.Show(strTemp, strMore, objWin)
            %_ActAfter%()
        }
        Catch objError
            msgbox % Json.Dump(objError, 2)
    }
    
    IsTimeOut()
    {
        _TO := This.TimeOutFunc
        SetTimer, %_TO%, Off
        objWin  := This.GetActiveWin()
        objMode := This.GetMode(objWin)
        objKeyCache := objMode.Maps[objWin.KeyTemp]
        This.ActionDo(objKeyCache, objWin)
        objWin.Clear()
    }
    
    ActionDo(aObjKey, aWin)
    {
        _Func := This.ActionFunc
        aObjKey.Count := aWin.Count
        %_Func%(aObjKey)
        This.Show("", "", aWin)
    }
    
    GetMore(aKey, aWin)
    {
        objMode := This.GetMode(aWin)
        Return objMode._GetMore(aKey)
    }
    
    Show(aTemp, aMore, aWin)
    {
        If IsFunc(_Func := aWin.OnShow)
        {
            %_Func%(aTemp "`n" aMore)
            Return
        }
        Else
        {
            _Func := This.ShowFunc
            %_Func%(aTemp, aMore, aWin)
        }
    }

    /* 
        Function: ShiftUpper
            把<s-v>这种形式的热键，转换为V（字母大写）

        Parameters:
            aString - 字符串

        Return
            返回替换完毕的字符串
    */

    ShiftUpper(aString)
    {
        Return RegExReplace(aString, "im)<s\-([a-zA-Z])>", "$U1")
    }
    
    /*
        Function: GetKeyObject
            列出Vim热键对应的AHK热键列表
        
        Parameters:
            aKey - VIM热键串
        
        Return:
            返回AHK对象
    */
    GetKeyObject(aKey)
    {
        aKey := RegExReplace(aKey, "i)<Nowait>", "", Nowait)
        aKey := RegExReplace(aKey, "i)<Super>",  "", Super)
        aKey := RegExReplace(aKey, "i)<NoMulti>",  "", NoMulti)
        objKey := {}
        objKey.Nowait  := Nowait
        objKey.Super   := Super
        objKey.NoMulti := NoMulti
        objKey.List    := []
        objKey.String  := ""
        objKey.UUID    := ""
        objKey.Count   := 0
        aKey := StrReplace(aKey, "<", "`n<")
        aKey := StrReplace(aKey, ">", ">`n")
        idx := 1
        Loop, Parse, aKey, `n
        {
            If !Strlen(Key := A_LoopField)
                Continue
            If RegExMatch(Key,"^([A-Z])$",m)
                Key := "<S-" m ">"
            If RegExMatch(Key, "^<.*>$")
            {
                objKey.List[idx] := This.Convert2AHK(Key)
                objKey.String .= Key
            }
            Else If (Strlen(Key) > 1)
            {
                Loop, Parse, Key
                {
                    If RegExMatch(A_LoopField, "^[A-Z]$")
                    {
                        objKey.List[idx] := This.Convert2AHK("<s-" A_LoopField ">")
                        objKey.String .= "<s-" A_LoopField ">"
                    }
                    Else
                    {
                        objKey.List[idx] := A_LoopField
                        objKey.String .= A_LoopField
                    }
                    idx++
                }
            }
            Else
            {
                objKey.List[idx] := Key
                objKey.String .= Key
            }
            idx++
        }
        return objKey
    }
    
    /*
        Function: Convert2VIM
            AHK热键转换为VIM式的热键

        Parameters:
            aKey - AHK热键格式

        Return:
            返回一个VIM化的字符串
    */
    Convert2VIM(aKey)
    {
        strVIM := ""
        If Strlen(this._AHKList[aKey])
            strVIM := This._AHKList[aKey]
        Else If RegExMatch(aKey, "(.*)\s&\s(.*)", objMatch)
            strVIM := "<" This._AhkModifier[objMatch1] "-" objMatch2 ">"
        Else 
            strVIM := aKey
        Return strVIM
    }

    /*
        Function: Convert2AHK
            VIM热键转换为AHK式热键
        
        Parameters:
            aKey - VIM热键格式
            ToSend - 转换的AHK式热键可直接用于Send/SendInput等命令
        
        Return:
            返回一个AHK化的字符串
    */
    Convert2AHK(aKey, ToSend:=False)
    {
        strAHK := ""
        If Strlen(this._VimList[aKey])
        {
            If ToSend
                strAHK := "{" this._VimList[aKey] "}"
            Else
                strAHK := this._VimList[aKey]
        }
        Else If RegExMatch(aKey, "i)^<([rl]?[sacwtle])-(.*)>$", objMatch)
        {
            If ToSend
            {
                If Strlen(this._AHKList[objMatch2])
                    Key2 := "{" objMatch2 "}"
                Else
                    Key2 := objMatch2
                strAHK := This._VimModifierSend[objMatch1] Key2
            }
            Else
            {
                strAHK := This._VimModifier[objMatch1] " & " objMatch2
            }
        }
        Else If RegExMatch(aKey, "i)^<(.*)>$", objMatch)
        {
            If ToSend
                strAHK := "{" objMatch1 "}"
            Else
                strAHK := objMatch1
        }
        Else If ToSend
        {
            strAHK := aKey
        }
        Else
        {
            Throw Exception("Convert VIM Key Error " aKey , -1)
        }
        return strAHK
    }
    
    /*
        Function: CheckCapsLock
            检测CapsLock热键。
        
        Parameters:
            aKey - VIM热键格式
        
        Return:
            返回对应的字符串
    */
    CheckCapsLock(aKey)
    {
        If GetKeyState("CapsLock","T")
        {
            If RegExMatch(aKey, "^[a-z]$")
                return "<S-" aKey ">"
            If RegExMatch(akey, "i)^<S\-([a-zA-Z])>", Match)
            {
                StringLower, aKey, Match1
                return aKey 
            }
        }
        If RegExMatch(aKey, "i)^<w\-(.*)>$", Match) && !GetKeyState("lWin", "P")
            Return Match1
        return akey
    }
    
    _HotkeyList()
    {
        This._VIMList := {"<LButton>":"LButton", "<RButton>":"RButton", "<MButton>":"MButton"
            ,"<XButton1>":"XButton1",   "<XButton2>":"XButton2"
            ,"<WheelDown>":"WheelDown", "<WheelUp>":"WheelUp"
            ,"<WheelLeft>":"WheelLeft", "<WheelRight>":"WheelRight"
            ; 键盘控制
            ,"<CapsLock>":"CapsLock", "<Space>":"Space", "<Tab>":"Tab"
            ,"<Enter>":"Enter", "<Esc>":"Escape", "<BS>":"Backspace"
            ; Fn
            ,"<F1>":"F1","<F2>":"F2","<F3>":"F3","<F4>":"F4","<F5>":"F5","<F6>":"F6"
            ,"<F7>":"F7","<F8>":"F8","<F9>":"F9","<F10>":"F10","<F11>":"F11","<F12>":"F12"
            ; 光标控制
            ,"<ScrollLock>":"ScrollLock", "<Del>":"Del", "<Ins>":"Ins"
            ,"<Home>":"Home", "<End>":"End", "<PgUp>":"PgUp", "<PgDn>":"PgDn"
            ,"<Up>":"Up", "<Down>":"Down", "<Left>":"Left", "<Right>":"Right"
            ; 修饰键
            ,"<Lwin>":"LWin", "<Rwin>":"RWin"
            ,"<control>":"control", "<Lcontrol>":"Lcontrol", "<Rcontrol>":"Rcontrol"
            ,"<Alt>":"Alt", "<LAlt>":"LAlt", "<RAlt>":"RAlt"
            ,"<Shift>":"Shift", "<LShift>":"LShift", "<RShift>":"RShift"
            ; 特殊按键
            ,"<Insert>":"Insert", "<Ins>":"Insert"
            ,"<AppsKey>":"AppsKey", "<LT>":"<", "<RT>":">"
            ,"<PrintScreen>":"PrintScreen"
            ,"<controlBreak>":"controlBrek"}
            ; 数字小键盘暂时不支持
            ; 功能键
        This._VimModifier := {"S":"shift", "LS":"lshift", "RS":"rshift &"
            ,"A":"alt", "LA":"lalt", "RA":"ralt"
            ,"C":"control", "LC":"lcontrol", "RC":"rcontrol"
            ,"W":"lwin", "LW":"lwin", "RW":"lwin"
            ,"T":"tab", "L":"CapsLock", "E":"Escape"}
        This._VimModifierSend := {"S":"+", "LS":"+", "RS":"+"
            ,"A":"!", "LA":"!", "RA":"!"
            ,"C":"^", "LC":"^", "RC":"^"
            ,"W":"#", "LW":"#", "RW":"#"}
        This._AHKList := {}
        For V, A In This._VIMList
            This._AHKList[A] := V
        This._AhkModifier := {}
        For V, A In This._VimModifier
            This._AhkModifier[A] := V
    }

    DebugAdd(aTxt)
    {
        This.TipTxt .= aTxt
    }
    DebugShow()
    {
        GUI,Debug: Destroy
        GUI,Debug: Default
        GUI,Debug: Add, ListView, w600 h400 , WIN|VIM|RAW
        LV_ModifyCol(1, 150)
        LV_ModifyCol(2, 150)
        Txt := This.TipTxt
        Loop, Parse, Txt, `n
        {
            StringSplit, newText, A_LoopField, |
            LV_Add("", newText1, newText2, newText3)
        }
        GUI,Debug: Show
    }
}

/*
    Class: VimWin
        程序对象
*/
Class VimWin
{
    __New()
    {
        This.Name := ""
        This.WinClass := ""
        This.WinExe := ""
        This.ExistMode := ""
        This.Count := 0
        This.KeyTemp := ""
        This.KeyTempCount := 0
        ;This.GlobalMode := new VimMode
        This.OnChangeMode := ""
        This.OnActionBefore := ""
        This.OnActionAfter := ""
        This.OnShow := ""
        This.OnInit := ""
        This.MaxCount := 0
        This.TimeOut := 0
        This.Modes := {}
    }

    AppendKeyTemp(aKey)
    {
        This.KeyTemp := This.KeyTemp aKey
        This.KeyTempCount := This.KeyTempCount + 1
        Return This.KeyTemp
    }

    Clear()
    {
        This.Count := 0
        This.KeyTemp := ""
        This.KeyTempCount := 0
    }
}

/*
    Class: VimMode
        模式对象
*/
Class VimMode
{
    __New()
    {
        This.Name := ""
        This.OwnerWin := ""
        This.IconFile := ""
        This.IconNumber := ""
        This.MapList := ""
        This.Maps := {}
    }

    _GetMore(aKey)
    {
        idx := 0, strMore := ""
        strMapList := This.MapList
        strMatch := "i)^" ToMatch(aKey) ".+"
        Loop, Parse, strMapList, `n
        {
            If !Strlen(strKey := A_LoopField)
                Continue
            If RegExMatch(strKey, strMatch)
                strMore .= strKey "`n"
        }
        Return strMore
    }
}
