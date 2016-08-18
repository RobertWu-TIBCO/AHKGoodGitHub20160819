/*
Title=MenuZ智能菜单
Function=MenuZALL|MenuZWin
MenuZALL=显示常规菜单
MenuZWin=仅显示窗口菜单
Author=Array
Version=0.1
*/

/* 
    Title:  菜单插件
*/

QZ_MenuZ()
{
    Global gQZConfig, gMenuZ
    gMenuZ := {} ; 保存菜单功能的相关数据
    gMenuZ.Data := {} ; 保存获取到的数据内容
    gMenuZ.FilterResult := {} ; 保存筛选器判断的结果
    gMenuZ.Plugin := {} ; 保存动态菜单插件数据
    gMenuZ.MenuIDs := {}
    gMenuZ.EditMenu := {} ; 保存当前编辑的菜单对象
    gMenuZ.EditItem := {} ; 保存当前编辑的菜单项对象
    gMenuZ.RunItem := {} ; 保存点击的菜单项对象
    gMenuZ.PUMParam := {"SelMethod" : "Fill"            ;item selection method, may be frame,fill
        ;,"selTColor"   : -1         ;selection text color
        ;,"selBGColor"  : -1         ;selection background color, -1 means invert current color
        ,"oninit"      : "MenuZ_Do"   ;function which will be called when any menu going to be opened
        ,"onuninit"    : "MenuZ_Do"   ;function which will be called when any menu going to be closing
        ,"onselect"    : "MenuZ_Do"   ;;function which will be called when any item selected with mouse (hovered)
        ,"onrbutton"   : "MenuZ_Do"   ;function which will be called when any item right clicked
        ,"onmbutton"   : "MenuZ_Do"   ;function which will be called when any item clicked with middle mouse button
        ,"onrun"       : "MenuZ_Do"   ;function which will be called when any item clicked with left mouse button
        ,"onshow"      : "MenuZ_Do"   ;function which will be called before any menu shown using Show method
        ,"onclose"     : "MenuZ_Do"   ;function called just before quitting from Show metho
        ,"pumfont"     : ""
        ;,"mnemonicCMD" : "select"
        ;,"tcolor"      : ""   ;RGB text color of the items in the menu
        ;,"bgcolor"	    : ""   ;RGB background color of the menu
        ,"nocolors"   : 0    ;if 1, will be used default color for menu's background and item's text color
        ,"noicons"    : 0    ;if 1, icons will not be shown in the menu
        ,"notext"     : 0    ;if 1, text will not be shown for the item, should not be used with "noicons"
        ,"iconssize"  : 16   ;icon size for items
        ,"textoffset" : 5    ;between icon and item's text in pixels
        ,"maxheight"  : 0    ;height of the menu, scroll will be added if menu is bigger
        ,"xmargin"    : 3    ;margin for the left and right of item boundary
        ,"ymargin"    : 3    ;margin for the top and bottom of item boundary
        ,"textMargin" : 5 }  ;pixels amount which will be added after the text to make menu look pretty
    If IsObject(gQZConfig.Setting.MenuZ.PUMParam)
    {
        For Key , Value In gQZConfig.Setting.MenuZ.PUMParam
            gMenuZ.PUMParam[Key] := Value
    }
    gMenuZ.PUM := new PUM(gMenuZ.PUMParam)
}

MenuZAll()
{
    Global gQZConfig, gMenuZ, objData
    gMenuZ.FilterResult := {} ; 重新初始化筛选器对象
    gMenuZ.Data := QZ_GetData()
    QZ_GetKeyword(A_ThisHotkey, gMenuZ.Data)
    QZ_GetWinInfo(gMenuZ.Data)
    QZ_GetClip(gMenuZ.Data)
    objData := gMenuZ.Data
    PumMenu := gMenuZ.PUM.CreateMenu(gMenuZ.PUMParam)
    MenuZ_AddItem(PumMenu, gQZConfig.MenuZ)
    PumMenu.Show(gMenuZ.Data.x, gMenuZ.Data.y)
}

MenuZWin()
{
    Global gQZConfig, gMenuZ, objData
    gMenuZ.FilterResult := {} ; 重新初始化筛选器对象
    gMenuZ.Data := QZ_GetData()
    QZ_GetKeyword(A_ThisHotkey, gMenuZ.Data)
    QZ_GetWinInfo(gMenuZ.Data)
    objData := gMenuZ.Data
    PumMenu := gMenuZ.PUM.CreateMenu(gMenuZ.PUMParam)
    MenuZ_AddItem(PumMenu, gQZConfig.MenuZ)
    PumMenu.Show(gMenuZ.Data.x, gMenuZ.Data.y)
}

MenuZDyn()
{
    Global gQZConfig, gMenuZ, objData
    gMenuZ.FilterResult := {} ; 重新初始化筛选器对象
    gMenuZ.Data := QZ_GetData()
    QZ_GetKeyword(A_ThisHotkey, gMenuZ.Data)
    QZ_GetWinInfo(gMenuZ.Data)
    PumMenu := gMenuZ.PUM.CreateMenu(gMenuZ.PUMParam)
    MenuZ_AddItem(PumMenu, gQZConfig.MenuZ)
    PumMenu.Show(gMenuZ.Data.x, gMenuZ.Data.y)
    QZ_GetClip(gMenuZ.Data)
    objData := gMenuZ.Data
    MenuZ_AddItem(PumMenu, gQZConfig.MenuZ)
}

/*
    Function: MenuZ_AddItem(aMenu, aObj)
        添加菜单项

    Parameters:
        aMenu - 需要生成菜单项的Menu对象(PUM_Menu)
        aObj  - 存放菜单项的对象（数组）。一般为gQZConfig.MenuZ
*/

MenuZ_AddItem(aParentMenu, aObj)
{
    Global gQZConfig, gMenuZ
    Static PUMIconList := {} ; 图标保存对象，减少图标加载，提速！
    Loop % aObj.MaxIndex()
    {
        objMenu := aObj[A_Index]
        If MenuZ_Filter(objMenu) || objMenu.Options.Hide
            Continue
        objItem := gQZConfig.Items[objMenu.UUID]
        Param := {}
        If objMenu.UUID
        {
            Param["Name"] := objItem.Name
            Param["UID"] := objMenu.UUID
            gMenuZ.MenuIDs[objMenu.UUID] := objMenu.ID
            Param["Bold"] := objMenu.Options.Bold
            Param["Disabled"] := objMenu.Options.Disable
        }
        Else
        {
            aParentMenu.Add()
            Continue
        }
        Param["tcolor"]  := objMenu.Options.ColorFore
        Param["bgcolor"] := objMenu.Options.ColorBack
        
        If PUMIconList[objMenu.Options.IconFile A_Tab objMenu.Options.IconNumber]
        {
            Param["iconUseHandle"] := True
            Param["Icon"] := PUMIconList[objMenu.Options.IconFile A_Tab objMenu.Options.IconNumber]
        }
        Else
        {
            If Strlen(objMenu.Options.IconFile)
                Param["Icon"] := QZ_ReplaceEnv(objMenu.Options.IconFile)
            If objMenu.Options.IconNumber
                Param["Icon"] .= ":" . objMenu.Options.IconNumber-1
        }
        PI := aParentMenu.Add(Param)
        gMenuZ.EditItem := PI ; 保存当前编辑的菜单项
        gMenuZ.EditMenu := aParentMenu ; 保存当前编辑的菜单对象
        If IsFunc(_Fun:=objItem.Command) && !objItem.Options.CodeMode
        {
            If RegExMatch(_Fun, "i)^dm_")
            {
                gMenuZ.Plugin[objMenu.UUID] := _Fun
                PI.SetParams({"SubMenu":%_Fun%(objItem.Param)})
            }
        }
        Else If IsObject(objMenu.SubItem[1]) && objMenu.Options.Type
        {
            ;PM := gMenuZ.PUM.CreateMenu(gMenuZ.PUMParam)
            If (objMenu.Options.Type = 1)
            {
                PM := MenuZ_GetSub(gMenuZ.PUMParam)
                PI.SetParams({"SubMenu":MenuZ_AddItem(PM, objMenu.SubItem)})
            }
            Else
            {
                PM := MenuZ_GetSibling()
                MenuZ_AddItem(PM, objMenu.SubItem)
            }
        }
        If PI.hIcon
            PUMIconList[objMenu.Options.IconFile A_Tab objMenu.Options.IconNumber] := PI.hIcon
    }
    Return aParentMenu
}

/*
    Function: MenuZ_GetSub(aParam:="")
        获取一个 *子菜单* 对象，用于插件编写

    Parameters:
        aParam - 生成子菜单的参数，默认为空

    Return:
        objMenu - 返回个菜单对象
*/
MenuZ_GetSub(aParam:="")
{
    Global gMenuZ
    Return gMenuZ.PUM.CreateMenu(aParam)
}

/*
    Function: MenuZ_GetSub(aParam:="")
        获取一个 *同级菜单* 对象，用于插件编写.

    Return:
        objMenu - 返回个菜单对象
*/
MenuZ_GetSibling()
{
    Global gMenuZ
    gMenuZ.EditItem.Destroy()
    Return gMenuZ.EditMenu
}

/*
    无效返回True
*/

MenuZ_Filter(aObj)
{
    Global gQZConfig, gMenuZ
    boldResult := False ; False表示不筛选当前菜单项
    /*
        筛选器支持的条件中，有些是精确匹配的。
        例如FileExt条件，所有的后缀名都必须完全满足，如：
            > 后缀: txt
            > 条件: txt;exe ，后缀必须满足条件中的某个后缀即可，而且必须完全满足。
        而TextRegex条件，由于判断的内容往往是大段文本，反而无法使用精确匹配，而是使用模糊匹配。如
            > 文本: some text in edit contrl
            > 条件: some;var 只需要匹配其中某个文本就行，而不需要完全匹配。
        对于FileMulti 这种类型更加特殊，匹配双方都是数组。
            > 多文件类型: txt;exe
            > 条件: txt;exe;ini 多文件的所有类型，必须都包括在条件中。
    */
    strTrans := {"TextRegex":"Text"
        ,"FileName":"FileName"
        ,"FileDir":"FileDir"
        ,"WinTitle":"WinTitle"}
    objSpecial := {FileExt:1
        , TextRegex:1 
        , FileMulti:1
        , FileName:1
        , FileDir:1}
    If gMenuZ.Data["SepMode"] && !aObj.Filter.MaxIndex()
        Return True
    Loop % aObj.Filter.MaxIndex()
    {
        strUUID := aObj.Filter[A_Index] ; 获取 UUID
        If !IsObject(gMenuZ.FilterResult[strUUID])
        {
            If gMenuZ.Data["SepMode"] && If !strlen(gQZConfig.Filters[strUUID].Keyword)
                Return True
            SubResult := True ; 筛选器默认匹配
            For Judeg, objCheck In gQZConfig.Filters[strUUID]
            {
                ; 如果仅keyword的话，符合关键字，或者无过滤的有效
                ; 如果keyword+sepmode 的话，仅符合关键字才有效。
                If (Judeg = "Keyword") 
                {
                    If StrLen(objCheck) && Strlen(gMenuZ.Data["Keyword"]) && !QZ_MatchStr(objCheck, gMenuZ.Data["Keyword"])
                    {
                        SubResult := False
                        Break
                    }
                }
                If (Judeg = "Function")
                {
                    If IsFunc(objCheck) 
                        If !%objCheck%()
                        {
                            SubResult := False
                            Break
                        }
                }
                If gQZConfig.Filters[strUUID].Special
                {
                    If (gQZConfig.Filters[strUUID].Special = 1) && !Strlen(gMenuZ.Data.Files)
                        || (gQZConfig.Filters[strUUID].Special = 2) && !Strlen(gMenuZ.Data.Text)
                        || (gQZConfig.Filters[strUUID].Special = 3) && !InStr(gMenuZ.Data.Files, "`n")
                    {
                        SubResult := False
                        Break
                    }
                    If objSpecial[Judeg]
                        Continue
                }
                If !objCheck.Method ; 0 不判断
                    Continue
                If (Judeg = "FileMulti") ; 判断多文件
                {
                    If (objCheck.Method = 1) && !QZ_MatchFileMulti(objCheck.Match, gMenuZ.Data[Judeg])
                        || (objCheck.Method = 2) && QZ_MatchFileMulti(objCheck.Match, gMenuZ.Data[Judeg])
                        || (objCheck.Method = 3) && !QZ_RegExFileMulti(gMenuZ.Data[Judeg], objCheck.Match)
                        {
                            SubResult := False
                            Break
                        }
                    Continue
                }
                If Strlen(strTrans[Judeg]) ; 特殊判断条件，只能采用范围性的模糊匹配
                {
                    Judeg := strTrans[Judeg] ; 替换为QZData中的 Text 
                    If (objCheck.Method = 1) && !QZ_MatchTextRegex(objCheck.Match, gMenuZ.Data[Judeg])
                    || (objCheck.Method = 2) && QZ_MatchTextRegex(objCheck.Match, gMenuZ.Data[Judeg])
                    || (objCheck.Method = 3) && !RegExMatch(gMenuZ.Data[Judeg], objCheck.Match)
                        {
                            SubResult := False
                            Break
                        }
                }
                Else If (objCheck.Method = 1) && !QZ_MatchStr(objCheck.Match, gMenuZ.Data[Judeg])
                    || (objCheck.Method = 2) && QZ_MatchStr(objCheck.Match, gMenuZ.Data[Judeg])
                    || (objCheck.Method = 3) && !RegExMatch(gMenuZ.Data[Judeg], objCheck.Match)
                    {
                        SubResult := False
                        Break
                    }
            }
            gMenuZ.FilterResult[strUUID] := {"Result":SubResult} ; 保存筛选器对应的结果
            ;msgbox % gQZConfig.Filters[strUUID].Name "`n" SubResult
        }
        If aObj.Options.FilterLogic ; 或操作
        {
            If gMenuZ.FilterResult[strUUID].Result
                Return False
            Else
                boldResult := True
        }
        Else ; 与操作
        {
            If gMenuZ.FilterResult[strUUID].Result
                boldResult := False
            Else
                Return True
        }
    }
    Return boldResult
}

MenuZ_Do(aMsg, aObj)
{
    Global gQZConfig, gMenuZ
    WinActive("ahk_id " QZData("Hwnd"))
    If Strlen(_Func := gMenuZ.Plugin[aObj.menu.owner.uid])
    {
        _Handle := _Func . "_Handle"
        If IsFunc(_Handle)
        {
            %_Handle%(aMsg, aObj)
            Return
        }
    }
    If IsObject(aObj.UID)
    {
        _Handle := aObj.UID.Handle
        If IsFunc(_Handle)
        {
            %_Handle%(aMsg, aObj)
            Return
        }
        /*
        If (aMsg = "OnRun")
        {
            _Handle := aObj.UID.Handle
            If IsFunc(_Handle)
            {
                %_Handle%(aMsg, aObj)
                Return
            }
        }
        */
    }
    If (aMsg = "OnRun")
    {
        objItem := gQZConfig.Items[aObj.UID]
        If objItem.Options.CodeMode
        {
            GoSub, % aObj.UID
        }
        Else
        {
            gMenuZ.RunItem := objItem
            Settimer, __Menu_Do, -1
        }
        Return
        __Menu_Do:
            objItem := MenuZ_GetRunItem()
            QZ_Engine(objItem.Command, objItem.Param, objItem.WorkingDir, objItem.RunState)
            gMenuZ.Data := ""
        Return
    }
    If (aMsg = "OnRButton") 
    {
        If GetKeyState("Shift", "P")
            Send_WM_CopyData("-f " gMenuZ.MenuIDs[aObj.UID], IsGUI:=True)
        Else
            Send_WM_CopyData("-m " gMenuZ.MenuIDs[aObj.UID], IsGUI:=True)
    }
}

MenuZ_GetRunItem()
{
    Global gMenuZ
    Return gMenuZ.RunItem
}

