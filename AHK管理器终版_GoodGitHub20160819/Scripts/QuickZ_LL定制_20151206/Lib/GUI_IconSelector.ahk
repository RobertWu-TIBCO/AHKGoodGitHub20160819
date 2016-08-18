
/*
    ;请看例子
    GUI_IconSelector_Load("test")
    BookMarkList =
    (LTrim
    `%A_WinDir`%\System32\Shell32.dll
    `%A_WinDir`%\System32\imageres.dll
    `%A_WinDir`%\System32\mmcndmgr.dll
    )
    GUI_IconSelector_SetBookMark(BookMarkList)
    test()
    {
        obj := GUI_IconSelector_Dump()
        for i , k in obj
            a .= i " : "  k "`n"
        msgbox % a
        GUI_IconSelector_Destory()
    }
*/

/*
    Function: GUI_IconSelector_Load(aHandle)
        用于生成选择图标的GUI界面。
    Parameters: 
        aHandle - 用于设置界面关闭后执行某个回调函数。如"test"，代表运行 Test() 函数

    Returns: 
        返回GUI对象，可用于更多功能。

    Remarks: 
        选择好图标，使用GUI_IconSelector_Dump() 来获取选择的Icon路径
        可以使用GUI_IconSelector_Destory() 强制关闭界面。
        可以使用GUI_IconSelector_Clear() 清空图标
        可以使用GUI_IconSelector_SetBookMark(aBookMarkList) 设置收藏夹列表
        可以使用GUI_IconSelector_GetBookMark() 获取收藏夹列表
*/
GUI_IconSelector_Load(aHandle)
{
    Global gIconSelector
    IconSel := New GUI2("IconSelect", "+Lastfound +Theme +Resize -DPIScale")
    IconSel.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    IconSel.AddCtrl("TextSearchTip", "Text", "x10 y15 h26", QZLang.TextIconSearchTip)
    IconSel.AddCtrl("SearchPath", "Edit", "x10 y45 h26 w480")
    IconSel.AddCtrl("SearchDo", "Button", "x410 y78 h26 w80 default", QZLang.ButtonSearch)
    IconSel.AddCtrl("View", "Text", "x10 y82 h26", QZLang.TextView)
    IconSel.AddCtrl("NormalIcons", "Radio", "x50 y82 Checked", QZLang.TextViewNormal)
    IconSel.AddCtrl("ListIcons", "Radio", "x150 y82", QZLang.TextViewList)
    ;IconSel.AddCtrl("SmallIcons", "Radio", "x220 y82", QZLang.TextViewSmallIcons)
    IconSel.AddCtrl("BigIcons", "Radio", "x250 y82", QZLang.TextViewBigIcons)
    IconSel.AddCtrl("ListViewIcons", "ListView", "x10 y110 r12 w480", QZLang.IconListView)
    IconSel.AddCtrl("TextDoubleClick", "Text", "x10 y425 h26", QZLang.TextIconDoubleClick)
    IconSel.AddCtrl("BTNClear", "Button", "x210 y422 h26 w100", QZLang.ButtonClear)
    IconSel.AddCtrl("BTNOK", "Button", "x320 y422 h26 w80", QZLang.ButtonSelect)
    IconSel.AddCtrl("BTNClose", "Button", "x410 y422 h26 w80", QZLang.ButtonClose)
    IconSel.Show("w500 h456" , QZLang.IconSelector)
    ; 修改ListView控件
    LV_ModifyCol(1,60)
    LV_ModifyCol(2,500)
    ; 创建 IconList 给Toolbar使用
    TBCtrlIconList := IL_Create(2, 2, 0)
    IL_Add(TBCtrlIconList, A_WinDir "\System32\imageres.dll", 204)
    IL_Add(TBCtrlIconList, A_WinDir "\System32\imageres.dll", 68)
    IL_Add(TBCtrlIconList, A_WinDir "\System32\imageres.dll", 231)
    ; 设置Toolbar相关
    TBCtrl := Toolbar_Add(IconSel.hwnd, "GUI_IconSelector_TBEvent", "Flat Tooltips menu", TBCtrlIconList, "x264 y12 h36 w240")
    Toolbar_Insert(TBCtrl, QZLang.bookmark ", 1, ,SHOWTEXT")
    Toolbar_Insert(TBCtrl, QZLang.browseFile ", 2, ,")
    Toolbar_Insert(TBCtrl, QZLang.browseFolder ", 3, ,")
    Toolbar_SetButtonSize(TBCtrl, 24)
    IconSel.ListViewIcons.SetDefault()
    ; 为控件绑定对应的事件
    IconSel.ListViewIcons.OnEvent("GUI_IconSelector_Event")
    IconSel.SearchDo.OnEvent("GUI_IconSelector_Search")
    IconSel.BTNOK.OnEvent("GUI_IconSelector_OK")
    IconSel.BTNClose.OnEvent("GUI_IconSelector_Close")
    IconSel.BTNClear.OnEvent("GUI_IconSelector_Clear")
    ; 视图相关的事件
    IconSel.NormalIcons.OnEvent("GUI_IconSelector_Normal")
    IconSel.ListIcons.OnEvent("GUI_IconSelector_List")
    IconSel.SmallIcons.OnEvent("GUI_IconSelector_Small")
    IconSel.BigIcons.OnEvent("GUI_IconSelector_Big")
    IconSel.OnClose(aHandle)
    IconSel["Toolbar"] := TBCtrl ; 保存到全局变量，方便调用
    IconSel["Stop"] := False ; 在搜索目录内的图标时，由于图标文件数量多，可能非常耗时，这个可以控制搜索中止。
    ; 其它操作
    gIconSelector := IconSel
    Return IconSel
}

GUI_IconSelector_Dump()
{
    Global gIconSelector
    Return gIconSelector 
}

GUI_IconSelector_Clear()
{
    Global gIconSelector
    gIconSelector.Data := {Event:"Clear", IconFile:"", IconNumber:""}
    gIconSelector.Close()
}

GUI_IconSelector_Close()
{
    Global gIconSelector
    gIconSelector.Close()
}

;GUI_IconSelector_Save(aIcon, aNum)
GUI_IconSelector_Save(aStr)
{
    Global gIconSelector
    iPos := RegexMatch(aStr, ":\d*$")
    If iPos
    {
        iFile := SubStr(aStr, 1, iPos-1)
        iNum := SubStr(aStr, iPos+1)
    }
    Else
    {
        iFile := aStr
        iNum := 0
    }
    gIconSelector.Data := {Event:"Select", IconFile:iFile, IconNumber:iNum}
    gIconSelector.Close()
}

GUI_IconSelector_SetBookMark(aBookMarkList)
{
    Global gIconSelector
    gIconSelector["BookMark"] := aBookMarkList
}

GUI_IconSelector_GetBookMark()
{
    Global gIconSelector
    Return gIconSelector["BookMark"]
}

; ===========================
; 以下为内部函数，不需要理会。
; ===========================

GUI_IconSelector_AddBookMark(aBookMark)
{
    Global gIconSelector
    BookMarkList := gIconSelector["BookMark"]
    Loop, Parse, BookMarkList, `n, `r
    {
        If (aBookMark = A_LoopField)
            Return
    }
    If Strlen(BookMarkList)
        gIconSelector["BookMark"] := BookMarkList "`n" aBookMark
    Else
        gIconSelector["BookMark"] := aBookMark
    gIconSelector["BookMarkGUI"].Editor.SetText(gIconSelector["BookMark"])
}


GUI_IconSelector_ManageBookMark()
{
    Global gIconSelector
    BookMarkGUI := New GUI2("BookMark", "+Lastfound +Theme +Resize -DPIScale")
    BookMarkGUI.SetFont("S10", "Microsoft YaHei")
    BookMarkGUI.AddCtrl("Editor", "Edit", "x5 y5 w500 r18", GUI_IconSelector_GetBookMark())
    BookMarkGUI.AddCtrl("ButtonOK", "Button", "x325 y360 w80 h26 Default", QZLang.ButtonOK)
    BookMarkGUI.AddCtrl("ButtonClose", "Button", "x425 y360 h26 w80 ", QZLang.ButtonClose)
    BookMarkGUI.Show("w510", QZLang.bookmark)
    BookMarkGUI.ButtonOK.OnEvent("GUI_IconSelector_ManageBookMark_OK")
    BookMarkGUI.ButtonClose.OnEvent("GUI_IconSelector_ManageBookMark_Close")
    gIconSelector["BookMarkGUI"] := BookMarkGUI
}

GUI_IconSelector_ManageBookMark_OK()
{
    Global gIconSelector
    GUI_IconSelector_SetBookMark(gIconSelector["BookMarkGUI"].Editor.GetText())
    GUI_IconSelector_ManageBookMark_Close()
}

GUI_IconSelector_ManageBookMark_Close()
{
    Global gIconSelector
    gIconSelector["BookMarkGUI"].Destroy()
}

GUI_IconSelector_TBEvent(aCtrl, aEvent, aTxt, aPos)
{
    Global gIconSelector
    If (aEvent = "Menu")
    {
        If (aPos = 1)
        {
            GUI_IconSelector_Menu()
        }
        If (aPos = 2)
        {
            Title := QZLang.FileSelectIcon
            Filter := QZLang.FileSelectIconFilter
            FileSelectFile,	file, 3,  , %Title% ,%Filter%
            If FileExist(file)
            {
                gIconSelector.SearchPath.SetText(file)
                GUI_IconSelector_Search()
            }
        }
        If (aPos = 3)
        {
            Title := QZLang.FolderSelectIcon
            DefaultPath := QZLang.FolderSelectIconFolder
            FileSelectFolder, folder, %DefaultPath%, 0, %Title%
            If FileExist(Folder)
            {
                gIconSelector.SearchPath.SetText(Folder)
                GUI_IconSelector_Search()
            }
        }
    }
}

GUI_IconSelector_Menu()
{
    Global gIconSelector
    IconSelHwnd := gIconSelector.hwnd
    CoordMode, Menu, Screen
    WinGetPos, GuiX, GuiY, , ,  ahk_id %IconSelHwnd%
    ControlGetPos, TBX, TBY, , , ToolbarWindow321, ahk_id %IconSelHwnd%
    TBH := Toolbar_GetRect(gIconSelector.Toolbar, "1", "h")
    PosX := GuiX + TBX
    PosY := GuiY + TBY + TBH
    Menu, _GUI_IconSelector, Add
    Menu, _GUI_IconSelector, DeleteAll
    Menu, _GUI_IconSelector, Add, % QZLang.MenuIconBookmarkAdd,    _GUI_IconSelector_Menu_Add
    Menu, _GUI_IconSelector, Add, % QZLang.MenuIconBookmarkManage, _GUI_IconSelector_Menu_Manage
    Menu, _GUI_IconSelector, Add

    _BMList =
    (LTrim
    `%A_WinDir`%\System32\Shell32.dll
    `%A_WinDir`%\System32\imageres.dll
    `%A_WinDir`%\System32\mmcndmgr.dll
    -break
    )
    
    BookMarkList := QZGlobal.DefaultIcons . "`n" . _BMList . "`n" . gIconSelector["BookMark"]

    Loop, Parse, BookMarkList ,`n ,`r
    {
        If !Strlen(A_LoopField)
            Continue
        If (A_LoopField = "-") 
        {
            Menu, _GUI_IconSelector, Add
        }
        Else If (A_LoopField = "-Break") 
        {
            Menu, _GUI_IconSelector, Add, % QZLang.IconBookMarkBreak, _GUI_IconSelector_Menu_Do
            Menu, _GUI_IconSelector, Disable, % QZLang.IconBookMarkBreak
        }
        Else
        {
            Menu, _GUI_IconSelector, Add, %A_LoopField%, _GUI_IconSelector_Menu_Do
        }
    }


    Menu, _GUI_IconSelector, Show, %PosX%, %PosY%
    Return
    _GUI_IconSelector_Menu_Do:
        gIconSelector.SearchPath.SetText(A_ThisMenuItem)
        GUI_IconSelector_Search()
    Return
    _GUI_IconSelector_Menu_Add:
        GUI_IconSelector_AddBookMark(gIconSelector.SearchPath.GetText())
    Return
    _GUI_IconSelector_Menu_Manage:
        GUI_IconSelector_ManageBookMark()
    Return
}

GUI_IconSelector_Event()
{
    Global gIconSelector
    If (A_GuiEvent = "DoubleClick")
    {
        If !A_EventInfo
            return
        gIconSelector.ListViewIcons.SetDefault()
        ;LV_GetText(SelectNum, A_EventInfo, 1)
        ;LV_GetText(SelectIcon, A_EventInfo, 2)
        ;GUI_IconSelector_Save(SelectIcon, SelectNum)
        LV_GetText(StrIcon, A_EventInfo, 2)
        GUI_IconSelector_Save(StrIcon)
    }
}

GUI_IconSelector_OK()
{
    Global gIconSelector
    gIconSelector.ListViewIcons.SetDefault()
    ;LV_GetText(SelectNum, LV_GetNext(0, "F"), 1)
    ;LV_GetText(SelectIcon, LV_GetNext(0, "F"), 2)
    ;GUI_IconSelector_Save(SelectIcon, SelectNum)
    LV_GetText(strIcon, LV_GetNext(0, "F"), 2)
    GUI_IconSelector_Save(StrIcon)
}




; ==========================
; 搜索图标过程，不需要调用。
; ==========================

GUI_IconSelector_Search()
{
    Global gIconSelector
    IconLibReal := Trim(RegExReplace(gIconSelector.SearchPath.GetText(), "((\\""?$)|"")")) ; 预先做判断，保证读取正常
    IconLib := QZ_ReplaceEnv(IconLibReal) ; 过一次变量 
    gIconSelector.ListViewIcons.SetDefault() 
    LV_Delete()

    gIconSelector.SearchDo.OnEvent("GUI_IconSelector_Search_Stop") ; 绑定Stop事件到"搜索"按钮
    gIconSelector.SearchDo.SetText(QZLang.ButtonSearchStop)

    IconListSmall := IL_Create(10, 10, 0)
    IconListLarge := IL_Create(10, 10, 1)
    
    PrevIconList := LV_SetImageList(IconListSmall, 1) ; 设置新图标列表，并返回原先的图标列表
    If PrevIconList ; 这个一定要做，把原先绑定的图标列表清除掉，释放空间
        IL_Destroy(PrevIconList)
    
    PrevIconList := LV_SetImageList(IconListLarge, 0)
    If PrevIconList
        IL_Destroy(PrevIconList)
    
    If StrLen(Attrib := FileExist(Trim(IconLib)))
    {
        If InStr(Attrib, "D")
        {
            IconNum := 1
            Loop, %IconLib%\*.*, 0, 1
            {
                If gIconSelector["Stop"]
                    Break
                IconNum := GUI_IconSelector_Search_Sub(A_LoopFileFullPath, IconLibReal . "\" . A_LoopFileName, IconListSmall, IconListLarge, IconNum)
            }
        }
        Else
        {
            GUI_IconSelector_Search_Sub(IconLib, IconLibReal, IconListSmall, IconListLarge)
        }
    }
    gIconSelector.SearchDo.OnEvent("GUI_IconSelector_Search") ; 绑定Search事件到"搜索"按钮
    gIconSelector.SearchDo.SetText(QZLang.ButtonSearch)
    gIconSelector["Stop"] := False
}

GUI_IconSelector_Search_Stop()
{
    Global gIconSelector
    gIconSelector["Stop"] := True
}

GUI_IconSelector_Search_Sub(aIconLib, aIconLibReal, aIconListSmall, aIconListLarge, aIconNum=1)
{
    Global gIconSelector
    Num := 0
    Loop, 9999
    {
        If gIconSelector["Stop"]
            Break
        If GUI_IconSelector_GetIcon(aIconLib, A_Index)
        {
            IconID := IL_Add(aIconListSmall, aIconLib, A_Index) ; 小图标增加
            IL_Add(aIconListLarge, aIconLib, A_Index) ; 大图标也增加
            LV_Add("Icon" IconID, aIconNum , aIconLibReal ":" A_Index )
            aIconNum++
            Num++
        }
        Else
        {
            Break
        }
    }
    SplitPath, aIconLibReal, , , strExt
    If !Num && GUI_IconSelector_GetIcon(aIconLib, 0) ; 当前为独立的图标文件，如.png 
    {
        IconID := IL_Add(aIconListSmall, aIconLib, 1)
        IL_Add(aIconListLarge, aIconLib) 
        LV_Add("Icon" IconID, aIconNum, aIconLibReal)
        aIconNum++
    }
    Return aIconNum
}

; =================================
; 以下控制ListView的视图，不做修改。
; =================================

GUI_IconSelector_Normal()
{
    Global gIconSelector
    gIconSelector.ListViewIcons.SetOptions("+Report")
}

GUI_IconSelector_List()
{
    Global gIconSelector
    gIconSelector.ListViewIcons.SetOptions("+List")
}

GUI_IconSelector_Small() ; 暂时不使用这个视图
{
    Global gIconSelector
    gIconSelector.ListViewIcons.SetOptions("-Redraw")
    gIconSelector.ListViewIcons.SetOptions("+Icon")
    gIconSelector.ListViewIcons.SetOptions("+Iconsmall")
    gIconSelector.ListViewIcons.SetOptions("+Redraw")
}

GUI_IconSelector_Big()
{
    Global gIconSelector
    gIconSelector.ListViewIcons.SetOptions("+Icon")
}

/*
QZ_ReplaceEnv(aEnv)
{
    Transform, newEnv, Deref, %aEnv%
    Return newEnv
}

#include Class_GUI2.ahk
#Include Toolbar.ahk
#Include Class_QZLang.ahk
*/


GUI_IconSelector_GetIcon(File:="",Icon_:=1){
  global _ICONINFO,_SHFILEINFO
  static hIcon:={},AW:=A_IsUnicode?"W":"A",pToken:=0
   ,temp1:=DllCall( "LoadLibrary", "Str","gdiplus","PTR"),temp2:=VarSetCapacity(si, 16, 0) (si := Chr(1)) DllCall("gdiplus\GdiplusStartup", "PTR*",pToken, "PTR",&si, "PTR",0)
	;~ static _ICONINFO:="fIcon,xHotspot,yHotSpot,HBITMAP hbmMask,HBITMAP hbmColor"
	;~ static _SHFILEINFO:="HICON hIcon,iIcon,DWORD dwAttributes,TCHAR szDisplayName[260],TCHAR szTypeName[80]"
	static sfi:=Struct(_SHFILEINFO),sfi_size:=sizeof(_SHFILEINFO),SmallIconSize:=DllCall("GetSystemMetrics","Int",49)
	If !File {
    for file,obj in hIcon
      If IsObject(obj){
        for icon,handle in obj
          DllCall("DestroyIcon","PTR",handle)
      } else 
        DllCall("DestroyIcon","PTR",handle)
    ; DllCall("gdiplus\GdiplusShutdown", "PTR",pToken) ; not done anymore since it is loaded before script starts
    Return
  }
	If (CR:=InStr(File,"`r") || LF:=InStr(File,"`n"))
		File:=SubStr(file,1,CR<LF?CR-1:LF-1) ; this is a local parameter so we can change the memory 
  If (hIcon[File,Icon_])
    Return hIcon[file,Icon_] 
  else if (hIcon[File] && !IsObject(hIcon[File]))
    return hIcon[File]
  SplitPath,File,,,Ext
  if (hIcon[Ext] && !IsObject(hIcon[Ext]))
    return hIcon[Ext]
  else If (ext = "cur")
    Return hIcon[file,Icon_]:=DllCall("LoadImageW", "PTR", 0, "str", File, "uint", ext="cur"?2:1, "int", 0, "int", 0, "uint", 0x10,"PTR")
  else if InStr(",EXE,ICO,DLL,LNK,ICL,","," Ext ","){
    If (ext="LNK"){
       FileGetShortcut,%File%,Fileto,,,,FileIcon,FileIcon_
       File:=!FileIcon ? FileTo : FileIcon
    }
    SplitPath,File,,,Ext
    DllCall("PrivateExtractIcons", "Str", File, "Int", Icon_-1, "Int", SmallIconSize, "Int", SmallIconSize, "PTR*", Icon, "PTR*", 0, "UInt", 1, "UInt", 0, "Int")
    Return hIcon[File,Icon_]:=Icon
  } else if (Icon_=""){
    If !FileExist(File){ 
      if RegExMatch(File,"^[0-9A-Fa-f]+$") ;assume Hex string
      {
        nSize := StrLen(File)//2
        VarSetCapacity( Buffer,nSize ) 
        Loop % nSize 
          NumPut( "0x" . SubStr(File,2*A_Index-1,2), Buffer, A_Index-1, "Char" )
      } else Return
    } else {
      FileGetSize,nSize,%file%
      FileRead,Buffer,*c %file%
    }
    hData := DllCall("GlobalAlloc", "UInt",2, "UInt", nSize,"PTR")
    ,pData := DllCall("GlobalLock", "PTR",hData,"PTR")
    ,DllCall( "RtlMoveMemory", "PTR",pData, "PTR",&Buffer, "UInt",nSize )
    ,DllCall( "GlobalUnlock", "PTR",hData )
    ,DllCall( "ole32\CreateStreamOnHGlobal", "PTR",hData, "Int",True, "PTR*",pStream )
    ,DllCall( "gdiplus\GdipCreateBitmapFromStream", "UInt",pStream, "PTR*",pBitmap )
    ,DllCall( "gdiplus\GdipCreateHBITMAPFromBitmap", "PTR",pBitmap, "PTR*",hBitmap, "UInt",0 )
    ,DllCall( "gdiplus\GdipDisposeImage", "PTR",pBitmap )
    ,ii:=Struct(_ICONINFO)
    ,ii.ficon:=1,ii.hbmMask:=hBitmap,ii.hbmColor:=hBitmap
    return hIcon[File]:=DllCall("CreateIconIndirect","PTR",ii[],"PTR")
  } else If DllCall("Shell32\SHGetFileInfo" AW, "str", File, "uint", 0, "PTR", sfi[], "uint", sfi_size, "uint", 0x101,"PTR")
      Return hIcon[Ext] := sfi.hIcon
}
