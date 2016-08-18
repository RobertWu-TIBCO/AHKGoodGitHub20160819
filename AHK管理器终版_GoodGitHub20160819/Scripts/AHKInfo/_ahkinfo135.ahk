AHKInfo_Title=AHKInfo 1.3.5
Cross_CUR:="000002000100202002000F00100034010000160000002800000020000000400000000100010000000000800000000000000000000000020000000200000000000000FFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF83FFFFFE6CFFFFFD837FFFFBEFBFFFF783DFFFF7EFDFFFEAC6AFFFEABAAFFFE0280FFFEABAAFFFEAC6AFFFF7EFDFFFF783DFFFFBEFBFFFFD837FFFFE6CFFFFFF83FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF28000000"
Full_ico:="0000010001002020100000000000E8020000160000002800000020000000400000000100040000000000000200000000000000000000100000001000000000000000000080000080000000808000800000008000800080800000C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFF00000FFFFFFFFFFFF000FFFFFFFFFF00FF0FF00FFFFFFFFFF000FFFFFFFFF0FF00000FF0FFFFFFFFF000FFFFFFFF0FFFFF0FFFFF0FFFFFFFF000FFFFFFF0FFFF00000FFFF0FFFFFFF000FFFFFFF0FFFFFF0FFFFFF0FFFFFFF000FFFFFF0F0F0FF000FF0F0F0FFFFFF000FFFFFF0F0F0F0FFF0F0F0F0FFFFFF000FFFFFF0000000F0F0000000FFFFFF000FFFFFF0F0F0F0FFF0F0F0F0FFFFFF000FFFFFF0F0F0FF000FF0F0F0FFFFFF000FFFFFFF0FFFFFF0FFFFFF0FFFFFFF000FFFFFFF0FFFF00000FFFF0FFFFFFF000FFFFFFFF0FFFFF0FFFFF0FFFFFFFF000FFFFFFFFF0FF00000FF0FFFFFFFFF000FFFFFFFFFF00FF0FF00FFFFFFFFFF000FFFFFFFFFFFF00000FFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000007770CCCCCCCCCCCCCCCCCCCCC07770007070CCCCCCCCCCCCCCCCCCCCC07070007770CCCCCCCCCCCCCCCCCCCCC0777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF80000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000FFFFFFFFFFFFFFFFFFFFFFFF"
Null_ico:="0000010001002020100000000000E8020000160000002800000020000000400000000100040000000000000200000000000000000000100000001000000000000000000080000080000000808000800000008000800080800000C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000007770CCCCCCCCCCCCCCCCCCCCC07770007070CCCCCCCCCCCCCCCCCCCCC07070007770CCCCCCCCCCCCCCCCCCCCC0777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF80000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000FFFFFFFFFFFFFFFFFFFFFFFF"
Cross_CUR_File=%A_Temp%\Cross.CUR
Full_ico_File=%A_Temp%\Full.ico
Null_ico_File=%A_Temp%\Null.ico
OptionsMenu_Text1=总在最前`tWin+Shift+T
Menu, OptionsMenu, Add, %OptionsMenu_Text1% ,GuiMenu
_MenuIsCheck( "OptionsMenu", OptionsMenu_Text1, "AlwaysOnTop")
if (ErrorLevel=-1)
	Menu,OptionsMenu,Check, %OptionsMenu_Text1%
Hotkey,#+t,GuiOnTop
Menu, OptionsMenu, Add,
OptionsMenu_Text2=复制时带 ahk_***`tWin+Shift+C
Menu, OptionsMenu, Add, %OptionsMenu_Text2% ,GuiMenu
_MenuIsCheck( "OptionsMenu", OptionsMenu_Text2, "Copy.ahk_***")
Hotkey, #+C, Copy_ahk_T
Menu, OptionsMenu, Add,
OptionsMenu_Text3=自动捕捉`tWin+Shift+F
Menu, OptionsMenu, Add, %OptionsMenu_Text3% ,GuiMenu
_MenuIsCheck( "OptionsMenu", OptionsMenu_Text3, "AutoCapture")
Hotkey,#+f,AutoCapture
Menu, MyMenuBar, Add, 选项(&O), :OptionsMenu
Menu, aboutMenu, Add, 清除工具属性记录 ,GuiMenu
Menu, aboutMenu, Add
Menu, aboutMenu, Add, AHK中文论坛`t(&L) ,GuiMenu
Menu, aboutMenu, Add, AHK中文社区`t(&S) ,GuiMenu
Menu, aboutMenu, Add, AHK英文论坛`t(&E) ,GuiMenu
Menu, aboutMenu, Add, 关于`t(&A) ,GuiMenu
Menu, MyMenuBar, Add, 帮助(&H), :aboutMenu
Gui, 1:Menu, MyMenuBar
Gui, 1:Add, GroupBox, x5 y5 w232 h40 , 窗口信息
Gui, 1:Add, Text, x12 y22 w42 h22 , 标题:
Gui, 1:Add, Edit, x50 y19 w180 h19 ReadOnly -Wrap  vTitle
Gui, 1:Add, Picture, x243 y10 w32 h32 gSetico vPic
Gui, 1:Add, Tab2,+Theme -Background -Wrap AltSubmit gTab_Click x2 y50 w275 h358  vTab1,窗口|控件|V/A文本|样式表|操作|IE元素|IE操作
	Gui, 1:Tab, 1
	Gui, 1:Add, ListView,NoSort Grid NoSortHdr -Multi gListView_DoubleClick vListView1  x8 y75 w263 h306 , 属性|值
	ListView1_Text=窗口标题|窗口类|窗口ID|坐标|大小|窗口点击|样式|扩展样式|进程PID|进程名|进程路径|透明色|全局坐标|颜色 BGR|颜色 RGB
	StringSplit,ListView1_Text_A,ListView1_Text,|
	Loop,%ListView1_Text_A0%
		LV_Add("",ListView1_Text_A%A_index%)
	LV_ModifyCol(1)
	LV_ModifyCol(2, 190)
	Gui, 1:Add, Text,x8 y389 w75 VText_T,透明度:
	Gui, 1:Add, Slider, AltSubmit CEnter Range0-255 NoTicks ToolTip Line1 vSlider1 gSlider x85 y384 w185 h20,255
	GuiControl, Disable,Slider1
		Gui, 1:Tab, 2
		Gui, 1:Add, ListView,NoSort Grid NoSortHdr -Multi gListView_DoubleClick vListView2 x8 y75 w263 h158 , 属性|值
		ListView2_Text=类别名|文本|实例编号|句柄|坐标|大小|点击坐标|样式|扩展样式
		StringSplit,ListView2_Text_A,ListView2_Text,|
		Loop,%ListView2_Text_A0%
			LV_Add("",ListView2_Text_A%A_index%)
		LV_ModifyCol(1)
		LV_ModifyCol(2, 190)
		Gui, 1:Add, ListView,AltSubmit Checked Grid NoSort -Multi HwndLV4H gListView_DoubleClick vListView4 x8 y233 w263 h170 ,控件列表|ID|句柄|文本|
			Gui, 1:Tab, 3
			Gui, 1:Add, Edit,HScroll ReadOnly x8 y75 w263 h162 vVisible_text,这里将显示的是可见文本
			Gui, 1:Add, Edit,HScroll ReadOnly x8 y237 w263 h162 vHidden_text,这里将显示的是全部文本
				Gui, 1:Tab, 4
				Gui, 1:Add, ListView,HwndLV3H NoSort NoSortHdr AltSubmit Checked Grid -Multi gListView_DoubleClick vListView3 x8 y75 w263 h325 , 窗口样式|值|说明
				ListView3_Text=WS_BORDER,0x00800000,细边框|WS_POPUP,0x80000000,弹出式|WS_CAPTION,0x00C00000,标题栏|WS_DISABLED,0x08000000,不可用|WS_DLGFRAME,0x00400000,对话框边框|WS_MAXIMIZE,0x01000000,初始状态为最大化|WS_MAXIMIZEBOX,0x00010000,最大化按钮|WS_MINIMIZE,0x20000000,初始状态为最小化|WS_MINIMIZEBOX,0x00020000,最小化按钮|WS_OVERLAPPED,0x00000000,层叠|WS_SIZEBOX,0x00040000,可调整边框|WS_SYSMenu,0x00080000,标题菜单|WS_VSCROLL,0x00200000,垂直滚动条|WS_HSCROLL,0x00100000,水平滚动条|WS_VISIBLE,0x10000000,可见|WS_EX_TOPMOST,0x00000008,置顶状态|WS_EX_TOOLWINDOW,0x00000080,工具窗口|WS_EX_WINDOWEDGE,0x00000100,凸起边框
				StringSplit,ListView3_Text_A,ListView3_Text,|
				Loop,%ListView3_Text_A0% {
					StringSplit,ListView3_Text_A_L,ListView3_Text_A%A_index%,`,
					LV_Add("",ListView3_Text_A_L1,ListView3_Text_A_L2,ListView3_Text_A_L3)
				}
				LV_ModifyCol()
					Gui, 1:Tab, 5
					Gui, Add, Text, x8 y77,窗口识别条件:
					Gui, Add, Checkbox,Checked x90 y73 h18 w45  vCheckbox1,标题
					Gui, Add, Checkbox,Checked x140 y73 h18 vCheckbox2,类
					Gui, Add, Checkbox, x180 y73 w57 h18 vCheckbox3,进程名
					Gui, Add, Button,x236 y73 w35 h20 gButton1,生成
					Gui, 1:Add, Edit, HScroll ReadOnly x8 y95 w263 h305 vGenerate_text
						Gui, 1:Tab, 6
						Gui, 1:Add, ListView,AltSubmit NoSort NoSortHdr Grid -Multi HwndLV5H gListView_DoubleClick vListView5  x8 y75 w263 h238 , 元素属性|属性值
						ListView5_Text=document.title|document.url|statustext|tagname|type|name|id|classname|value|title|outertext|innertext|src|href|target
						StringSplit,ListView5_Text_A,ListView5_Text,|
						Loop,%ListView5_Text_A0%
							LV_Add("",ListView5_Text_A%A_index%)
						LV_ModifyCol()
						Gui, Add, Radio, x8 y313 gRadio vRadio1,innerhtml
						Gui, Add, Radio,Checked x100 y313 gRadio vRadio2,outerhtml
						Gui, 1:Add, Edit,ReadOnly x8 y326 w263 h75 vEdit1
						Radio1Text:=
						Radio2Text:=
							Gui, 1:Tab, 7
							Gui, Add, Radio,Checked x10 y75 h20 gRadio vRadio3, 简单代码
							Gui, Add, Radio, x100 y75 h20 gRadio vRadio4, 比较准确
							Gui, 1:Add, Edit, HScroll ReadOnly x8 y95 w263 h305 vIeGenerate_text
							global Radio3_Text:=
							global Radio4_Text:=
							Gui, 1:+HwndAHKID +OwnDialogs
							X:=_RegR("X")="" ? 0:_RegR("X")
							Y:=_RegR("Y")="" ? 0:_RegR("Y")
							Gui, 1:Show,x %X% y %Y% w279 h410, %AHKInfo_Title%
							Gui, 2:Color,FF0000
							Gui, 2:-Caption +ToolWindow +Border +AlwaysOnTop +LastFound
							WinSet, TransColor,FF0000 250
							FileDelete,%A_Temp%\Cross.CUR
							FileDelete,%A_Temp%\Full.ico
							FileDelete,%A_Temp%\Null.ico
							IfNotExist,%Full_ico_File%
								BYTE_TO_FILE(StrToBin(Full_ico),Full_ico_File)
							GuiControl,,Pic,%Full_ico_File%
							CoordMode,Mouse,Screen
							CoordMode,Pixel,Screen
							IsCheck:=IsMenuItemChecked( 0, 0, AHKID )
							if (IsCheck=1)
								WinSet,AlwaysOnTop,On,ahk_id %AHKID%
							IsCheck:=IsMenuItemChecked( 0, 4, AHKID )
							if (IsCheck=0) {
								SetTimer,GetPos,Off
							}else{
								SetTimer,GetPos,On
								WinSetTitle,ahk_id %AHKID%,,(自动)%AHKInfo_Title%
							}
							global wb
							global ele
							Hotkey,~MButton,GetPos
							Hotkey,~#ctrl,GetPos
							Hotkey,~^LWin,GetPos
							Hotkey,IfWinActive,ahk_id %AHKID%
							Hotkey,Esc,GuiClose
							return
GuiClose:
	WinGetPos,X,Y,,,ahk_id %AHKID%
	_RegW("X",X)
	_RegW("Y",Y)
	FileDelete,%A_Temp%\Cross.CUR
	FileDelete,%A_Temp%\Full.ico
	FileDelete,%A_Temp%\Null.ico
	ExitApp
Slider:
	IfWinExist,ahk_id %OutWin3%
	{
		GuiControl,,Text_T,透明度(%Slider1%):
		if Slider1!=
			WinSet,Transparent,%Slider1%,ahk_id %OutWin3%
	}
return
GuiMenu:
	Gui +OwnDialogs
	ThisMenuItemPos:=A_ThisMenuItemPos-1
	ItemPos=%A_ThisMenu%%ThisMenuItemPos%
	if (ItemPos = "aboutMenu0") {
		MsgBox, 4132, 询问, 是否要清除AHKInfo的属性记录并退出?
		IfMsgBox,Yes
		{
			RegDelete,HKCU,Software\AutoHotkey\AHKInfo
			ExitApp
		}
	}else if (ItemPos = "aboutMenu2") {
		Run,http://ahk.5d6d.com/?fromuid=4531
	}else if (ItemPos = "aboutMenu3") {
		Run,http://cn.autoHotkey.com/
	}else if (ItemPos = "aboutMenu4") {
		Run,http://www.autoHotkey.com/
	}else if (ItemPos = "aboutMenu5") {
		MsgBox, 262208, 关于 %AHKInfo_Title%, 作者:	星雨朝霞`nQQ:	458926486
	}else if (ItemPos = "OptionsMenu0"){
		Menu,%A_ThisMenu%,ToggleCheck,%A_ThisMenuItem%
		IsCheck:=IsMenuItemChecked( 0, 0, AHKID )
		_RegW("AlwaysOnTop",IsCheck)
		if (IsCheck=1)
			WinSet,AlwaysOnTop,On,ahk_id %AHKID%
		else
			WinSet,AlwaysOnTop,Off,ahk_id %AHKID%
	}else if (ItemPos = "OptionsMenu2"){
		Menu,%A_ThisMenu%,ToggleCheck,%A_ThisMenuItem%
		IsCheck:=IsMenuItemChecked( 0, 2, AHKID )
		_RegW("Copy.ahk_***",IsCheck)
	}else if (ItemPos = "OptionsMenu4"){
		Menu,%A_ThisMenu%,ToggleCheck,%A_ThisMenuItem%
		IsCheck:=IsMenuItemChecked( 0, 4, AHKID )
		if (IsCheck=0) {
			SetTimer,GetPos,Off
			WinSetTitle,ahk_id %AHKID%,,%AHKInfo_Title%
		}else{
			SetTimer,GetPos,On
			WinSetTitle,ahk_id %AHKID%,,(自动)%AHKInfo_Title%
		}
		_RegW("AutoCapture",IsCheck)
	}else
		MsgBox,%ItemPos%
return
GuiOnTop:
	WinMenuSelectItem,ahk_id %AHKID%,,1&,1&
return
Copy_ahk_T:
	WinMenuSelectItem,ahk_id %AHKID%,,1&,3&
return
AutoCapture:
	WinMenuSelectItem,ahk_id %AHKID%,,1&,5&
return
Tab_Click:
	GuiControlGet,var,,tab1
return
ListView_DoubleClick:
	Gui, 1:ListView,%A_GuiControl%
	if (A_GuiControlEvent="DoubleClick"){
		if (A_GuiControl="ListView1" or A_GuiControl="ListView2" or A_GuiControl="ListView3" or A_GuiControl="ListView5") and (A_EventInfo!=0){
			LV_GetText(LV_Text,A_EventInfo ,2)
			if LV_Text !=
			{
				ahk_x=
				IsCheck:=IsMenuItemChecked( 0, 2, AHKID )
				if (IsCheck=1){
					if (A_GuiControl="ListView1"){
						if (A_EventInfo=2)
							ahk_x:="ahk_class "
						if (A_EventInfo=3)
							ahk_x:="ahk_id "
						if (A_EventInfo=9)
							ahk_x:="ahk_pid "
						if (A_EventInfo=10)
							ahk_x:="ahk_exe "
					}
					if (A_GuiControl="ListView5")
						ahk_x:="." _LV_GetText(A_EventInfo) ":="
				}
				Clipboard=%ahk_x%%LV_Text%
				_ToolTip( "Clipboard= " Clipboard)
			}
		}
		if (A_GuiControl="ListView4" and A_EventInfo!=0){
			LV_GetText(ListView4_T1,A_EventInfo,1)
			LV_GetText(ListView4_T2,A_EventInfo,4)
			LV_GetText(ListView4_T3,A_EventInfo,2)
			LV_GetText(ListView4_T4,A_EventInfo,3)
			ControlGetPos,lvx,lvy,lvw,lvh,%ListView4_T1%,ahk_id %OutWin3%
			ListView4_T5=%lvx%,%lvy%
			ListView4_T6=%lvw%,%lvh%
			ListView4_T7=
			ControlGet,ListView4_T8,Style,,%ListView4_T1%,ahk_id %OutWin3%
			ControlGet,ListView4_T9,ExStyle,,%ListView4_T1%,ahk_id %OutWin3%
			Gui, 1:ListView,ListView2
			Loop,9
				LV_Modify(A_Index,"Col2",ListView4_T%A_Index%)
			LV_ModifyCol()
		}
	}
	MouseGetPos,,,,LV,2
	if (LV=LV4H and A_GuiControl="ListView4" and A_GuiControlEvent="I" and A_EventInfo!=0){
		IfWinExist,ahk_id %OutWin3%
		{
			LV_GetText(LV_Text,A_EventInfo,1)
			if % InStr(ErrorLevel, "C", true)
				Control,Show,,%LV_Text%,ahk_id %OutWin3%
			else if % InStr(ErrorLevel, "c", true)
				Control,Hide,,%LV_Text%,ahk_id %OutWin3%
		}
	}
	if (LV=LV5H and A_GuiControl="ListView5" and A_GuiControlEvent="I" and A_EventInfo!=0 and IsObject(wb) and IsObject(ele)){
		if _LV_GetText(A_EventInfo)="Checked" {
			if InStr(ErrorLevel, "C", true)
				ele.Checked:=true
			if InStr(ErrorLevel, "c", true)
				ele.Checked:=false
		}}
		if (A_GuiControlEvent="R") {
			if  (A_GuiControl="ListView5" and IsObject(wb) and IsObject(ele)){
				LV_GetText(LV_Text1,A_EventInfo,1)
				LV_GetText(LV_Text2,A_EventInfo,2)
				WV=title,url,value,outertext,innertext
				if InStr(WV,LV_Text1) {
					InputBox,LV_TextOut,元素属性值,输入元素属性值`n%LV_Text1% =,,,150,,,,,%LV_Text2%
					if !ErrorLevel  {
						LV_Modify(A_EventInfo,"Col2",LV_TextOut)
						if _LV_GetText(A_EventInfo)="title"
							wb.document.title:=LV_TextOut
						if _LV_GetText(A_EventInfo)="url"
							wb.Navigate(LV_TextOut)
						if _LV_GetText(A_EventInfo)="value"
							ele.value:=LV_TextOut
						if _LV_GetText(A_EventInfo)="innertext"
							ele.innertext:=LV_TextOut
						if _LV_GetText(A_EventInfo)="outertext"
							ele.outertext:=LV_TextOut
					}
				}}}
				if (LV=LV3H and A_GuiControl="ListView3" and A_GuiControlEvent="I" and A_EventInfo!=0 and OutWin3!=AHKID){
					DetectHiddenWindows, on
					IfWinExist,ahk_id %OutWin3%
					{
						LV_GetText(LV_Text1,A_EventInfo,1)
						LV_GetText(LV_Text,A_EventInfo,2)
						if % InStr(ErrorLevel, "C", true)
							if % InStr(LV_Text1,"EX")
								WinSet,ExStyle,+%LV_Text%,ahk_id %OutWin3%
							else
								WinSet,Style,+%LV_Text%,ahk_id %OutWin3%
						else if % InStr(ErrorLevel, "c", true)
							if % InStr(LV_Text1,"EX")
								WinSet,ExStyle,-%LV_Text%,ahk_id %OutWin3%
							else
								WinSet,Style,-%LV_Text%,ahk_id %OutWin3%
					}
					DetectHiddenWindows, Off
				}
				return
Setico:
	IfNotExist,%Cross_CUR_File%
		BYTE_TO_FILE(StrToBin(Cross_CUR),Cross_CUR_File)
	IfNotExist,%Null_ico_File%
		BYTE_TO_FILE(StrToBin(Null_ico),Null_ico_File)
	GuiControl,,Pic,%Null_ico_File%
	CursorHandle := DllCall( "LoadCursorFromFile", Str,Cross_CUR_File )
	DllCall( "SetSystemCursor", Uint,CursorHandle, Int,32512 )
	SetTimer,GetPos,500
	GuiControl,,ieGenerate_text,等待...
	SetText("等待...")
	KeyWait,LButton
	Gui, 2:Hide
	SetTimer,GetPos,Off
	DllCall( "SystemParametersInfo", UInt,0x57, UInt,0, UInt,0, UInt,0 )
	IfNotExist,%Full_ico_File%
		BYTE_TO_FILE(StrToBin(Full_ico),Full_ico_File)
	GuiControl,,Pic,%Full_ico_File%
return
Generate(){
Gui, 1:ListView,ListView1
GuiControlGet,Checkbox1_C,,Checkbox1
GuiControlGet,Checkbox2_C,,Checkbox2
GuiControlGet,Checkbox3_C,,Checkbox3
GuiControlGet,ALL_text,,Hidden_text
StringSplit,ALL_text,ALL_text,`n
LV_GetText(text1,1,2)
LV_GetText(text2,2,2)
LV_GetText(text3,10,2)
LV_GetText(text4,6,2)
Gui, 1:ListView,ListView2
LV_GetText(text5,1,2)
LV_GetText(text6,7,2)
Loop,%ALL_text0%
{
	Index:=ALL_text0-A_Index+1
	Text_index:=ALL_text%Index%
	WinText:=Text_index!="" ? SubStr(Text_index,1,10):
	if Text_index!=
		break
}
WinTitle:=
if (Checkbox1_C=1)
	WinTitle=%text1%
if (Checkbox2_C=1)
	WinTitle=%WinTitle% ahk_class %text2%
if (Checkbox3_C=1)
	WinTitle=%WinTitle% ahk_exe %text3%
SetText("",0)
if (WinTitle!="" and WinTitle!="ahk_class"){
	text=
	(
		;等待指定标题窗口出现
		WinWait, %WinTitle%, %WinText%

	)
	SetText(text)
	text=
	(
		;点击窗口内指定坐标
		ControlClick, %text4%, %WinTitle%, %WinText%

	)
	SetText(text)
	if text5!=
	{
		text=
		(
			;点击控件
			ControlClick, %text5%, %WinTitle%, %WinText%

		)
		SetText(text)
		if text6!=
		{
			text=
			(
				;左键点击控件内指定坐标1次
				ControlClick, %text5%, %WinTitle%, %WinText%, LEFT, 1, %text6%

			)
			SetText(text)
		}
		if % InStr(text5,"Button")
		{
			text=
			(
				;控件选中(如果此控件为选择框或单选框) Check替换为Uncheck即取消选中
				Control, Check, , %text5%, %WinTitle%, %WinText%

			)
			SetText(text)
		}
		text=
		(
			;向控件发送空格键
			ControlSend, %text5%,{Space}, %WinTitle%, %WinText%

		)
		SetText(text)
	}}
	Gui, 1:Tab, 7
		iUrl:=GetV("document.url",2)
		itagname:=GetV("tagname",2)
		itype:=GetV("type",2)
		iID:=GetV("id",2)
		iValue:=GetV("Value",2)!="" ? GetV("Value",2):"设置新属性值"
		Index:=1
		iCode=
		(
			;脚本由 ahkinfo 生成
ComObjError(false) ;关闭对象错误提示
for window in ComObjCreate("Shell.Application").Windows {
	if InStr(window.document.url,"%iUrl%") { ;网页地址子字符串
		ie:=window
		break
}} ;连接符合条件的IE窗口,其它窗口上的IE控件请用 IEAttach() 帖子: http://ahk.5d6d.net/viewthread.php?tid=5501
if IsObject(ie)=0 {
			;Exit ;如果连接IE对象失败就退出当前线程,(貌似跳过后面的代码了)
	ie:=ComObjCreate("InternetExplorer.Application") ;如果连接IE对象失败就创建一个IE窗口
	ie.visible :=true ;浏览器窗口可见
	ie.Navigate("%iUrl%") ;如果先加载空白页面 about:blank ,这样IE窗口应该响应得快一点点
}

Loop { ;等待网页加载完成!
	Sleep,200
	if (ie.readyState="complete" or ie.readyState=4 or A_LastError!=0)
		break
} ;****************************************************************`n`n
		)
		iCode2:=GetV("tagname",2)!="" ? ("if (" itagname ".item(A_Index-1).tagname=`"`"" itagname "`"`" " ):
		iCode2.=GetV("id",2)!="" ? ("and " itagname ".item(A_Index-1).id=`"`"" GetV("id",2) "`"`" " ):
		iCode2.=GetV("src",2)!="" ? ("and " itagname ".item(A_Index-1).src=`"`"" GetV("src",2) "`"`" " ):
		iCode2.=GetV("name",2)!="" ? ("and " itagname ".item(A_Index-1).name=`"`"" GetV("name",2) "`"`" " ):
		iCode2.=GetV("classname",2)!="" ? ("and " itagname ".item(A_Index-1).classname=`"`"" GetV("classname",2) "`"`" " ):
		iCode2.=GetV("href",2)!="" ? ("and " itagname ".item(A_Index-1).href=`"`"" GetV("href",2) "`"`" " ):
		iCode2.=GetV("target",2)!="" ? ("and " itagname ".item(A_Index-1).target=`"`"" GetV("target",2) "`"`" " ):
		Gui, 1:ListView,ListView5
		Radio4_Text_value=
		(
%itagname%:=ie.document.GetElementsByTagName("%itagname%")
Loop `% %itagname%.length {
%iCode2%) {
	%itagname%.item(A_Index-1).value:="%iValue%"
	break ;找到一个符合条件的元素进行操作后,就退出循环,后面的元素就不比较了,可以提高一点点效率
}}
		)
		Radio4_Text_Click=
		(
%itagname%:=ie.document.GetElementsByTagName("%itagname%")
Loop `% %itagname%.length {
%iCode2%) {
	%itagname%.item(A_Index-1).Click()
	break ;找到一个符合条件的元素进行操作后,就退出循环,后面的元素就不比较了,可以提高一点点效率
}}
		)
		Radio4_Text_Check=
		(
%itagname%:=ie.document.GetElementsByTagName("%itagname%")
Loop `% %itagname%.length {
%iCode2%) {
			;选择单选`/复选框并激活onChange/OnClick事件;设置为 false 即取消选择
	%itagname%.item(A_Index-1).Checked:=true
	%itagname%.item(A_Index-1).fireEvent("onChange")
	%itagname%.item(A_Index-1).fireEvent("OnClick")
	break ;找到一个符合条件的元素进行操作后,就退出循环,后面的元素就不比较了,可以提高一点点效率
}}
		)
		if (itagname="Input") {
			if (itype="text" or itype="password")
				if (iID=""){
					Radio3_Text=;设置新属性值`nie.document.GetElementsByTagName("%itagname%").item(%TagIndex%).value:="%iValue%"`n`n
					Radio4_Text:=Radio4_Text_value
				}else{
					Radio3_Text=;设置新属性值`nie.document.getElementById("%iID%").value:="%iValue%"`n`n
					Radio4_Text:=Radio4_Text_value
				}
			if (itype="submit" or itype="button" or itype="image")
				if (iID=""){
					Radio3_Text=;点击元素`nie.document.GetElementsByTagName("%itagname%").item(%TagIndex%).Click()
					Radio4_Text:=Radio4_Text_Click
				}else{
					Radio3_Text=;点击元素`nie.document.getElementById("%iID%").Click()
					Radio4_Text:=Radio4_Text_Click
				}
			if (itype="radio" or itype="checkbox")
				if (iID=""){
					Radio3_Text=;选择单选`/复选框并激活onChange/OnClick事件;设置为 false 即取消选择`nie.document.GetElementsByTagName("%itagname%").item(%TagIndex%).Checked:=true`nie.document.GetElementsByTagName("%itagname%").item(%TagIndex%).fireEvent("onChange")`nie.document.GetElementsByTagName("%itagname%").item(%TagIndex%).fireEvent("OnClick")
					Radio4_Text:=Radio4_Text_Check
				}else{
					Radio3_Text=;选择单选`/复选框并激活onChange/OnClick事件;设置为 false 即取消选择`nie.document.getElementById("%iID%").Checked:=true`nie.document.getElementById("%iID%").fireEvent("onChange")`nie.document.getElementById("%iID%").fireEvent("OnClick")
					Radio4_Text:=Radio4_Text_Check
			}}else if (itagname="button" or itagname="a" or itagname="img" or itagname="span" or itagname="area" or itagname="Input_image" `
				or itagname="input_button" or itagname="input_submit" or itagname="input_radio" or itagname="input_reset" `
				or itagname="li" or itagname="td" or itagname="table"){
				if (iID=""){
					Radio3_Text=;点击元素`nie.document.GetElementsByTagName("%itagname%").item(%TagIndex%).Click()
					Radio4_Text:=Radio4_Text_Click
				}else{
					Radio3_Text=;点击元素`nie.document.getElementById("%iID%").Click()
					Radio4_Text:=Radio4_Text_Click
				}
		}else if (itagname="textarea"){
			if (iID="")
				Radio3_Text=;设置新属性值`nie.document.GetElementsByTagName("%itagname%").item(%TagIndex%).value:="设置新属性值"`n`n
			else
				Radio3_Text=;设置新属性值`nie.document.getElementById("%iID%").value:="设置新属性值"`n`n
		}else{
			Radio3_Text=MsgBox,0,`% ".item(%TagIndex%).outerhtml",`% ie.document.GetElementsByTagName("%itagname%").item(%TagIndex%).outerhtml
			Radio4_Text=
			(
%itagname%:=ie.document.GetElementsByTagName("%itagname%")
Loop `% %itagname%.length {
%iCode2%) {
	MsgBox,0,`% ".item(" A_Index-1 ").outerhtml",`% %itagname%.item(A_Index-1).outerhtml
}}
			)
		}
		if InStr(Radio4_Text,itagname ".item(A_Index-1).tagname=`"`"" itagname "`"`" and")
			StringReplace,Radio4_Text,Radio4_Text,% itagname ".item(A_Index-1).tagname=`"`"" itagname "`"`" and"
		else
			Radio4_Text:=Radio3_Text
		global Radio3_TextS:=iCode Radio3_Text "`n"
		global Radio4_TextS:=iCode Radio4_Text "`n"
		GuiControlGet,Check_C,,Radio3
		if Check_C=1
			GuiControl,,ieGenerate_text,%Radio3_TextS%
		else
			GuiControl,,ieGenerate_text,%Radio4_TextS%
}
GetV(VV,Col=1) {
Gui, 1:ListView,ListView5
Loop,% LV_GetCount() {
	LV_GetText(outvar,A_Index)
	if (outvar=VV) {
		return _LV_GetText(A_Index,Col)
	}}
}
SetText(iText,o=1){
StringReplace,iText,iText,%A_Tab% ,,All
if (o=1){
	GuiControlGet,ControlText,,Generate_text
	if ControlText=`n
		StringReplace,ControlText,ControlText,`n,,All
	GuiControl,,Generate_text,%ControlText%%iText%`n
}else
	GuiControl,,Generate_text,%iText%`n
}
Radio:
	GuiControlGet,sRadio1,,Radio1
	if sRadio1=1
		GuiControl,,Edit1,%Radio1Text%
	else
		GuiControl,,Edit1,%Radio2Text%
	GuiControlGet,sRadio1,,Radio3
	if sRadio1=1
		GuiControl,,IeGenerate_text,%Radio3_TextS%
	else
		GuiControl,,IeGenerate_text,%Radio4_TextS%
return
GetPos:
	MouseGetPos,OutX,OutY,OutWin3,OutCtrl1
	WinGetPos,WinX,WinY,WinW,WinH,ahk_id %OutWin3%
	WinGetTitle,OutWin1,ahk_id %OutWin3%
	WinGetClass,OutWin2,ahk_id %OutWin3%
	ControlGetPos,OutCtrlX,OutCtrlY,OutCtrlW,OutCtrlH,%OutCtrl1%,ahk_id %OutWin3%
	GuiControlGet,TABVar,,TAB1
	if (OutWin3=AHKID) {
		GuiControl,,Title,
		Gui, 1:ListView,ListView1
		Loop,%ListView1_Text_A0%
			LV_Modify(A_Index,"Col2","")
		LV_ModifyCol()
		Gui, 1:ListView,ListView2
		Loop,%ListView2_Text_A0%
			LV_Modify(A_Index,"Col2","")
		LV_ModifyCol()
		Gui, 1:ListView,ListView3
		Loop,%ListView3_Text_A0%
			LV_Modify(A_Index,"-Check")
		Gui, 1:ListView,ListView4
		LV_Delete()
		LV_ModifyCol(1,"80","控件列表")
		LV_ModifyCol(2,50)
		LV_ModifyCol(3,50)
		LV_ModifyCol(4,50)
		GuiControl,,Hidden_text,
		GuiControl,,Visible_text,
		GuiControl,,Edit1,
	}
	if InStr(OutCtrl1,"Internet Explorer_Server") {
		ControlGet,CtrlHwnd,Hwnd,,%OutCtrl1%,ahk_id %OutWin3%
		global wb:=_IEObjGetFromHwnd(CtrlHwnd)
		if IsObject(wb) {
			Gui, 1:ListView,ListView5
			LV_ModifyCol(2,"","属性值 (等待)" )
			GuiControl,,Title,% wb.document.title
			global ele:=wb.document.elementFromPoint(OutX-(WinX+OutCtrlX),OutY-(WinY+OutCtrlY))
			Loop,% LV_GetCount() {
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="document.title" 	? wb.document.title:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="statustext" 	? wb.statustext:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="target" 		? ele.target:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="name" 			? ele.name:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="href" 			? ele.href:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="id" 			? ele.id:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="classname" 	? ele.classname:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="src" 			? ele.src:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="outertext" 	? ele.outertext:)|
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="innertext" 	? ele.innertext:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="type" 			? ele.type:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="title" 			? ele.title:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="tagname" 		? ele.tagname:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="id" 			? ele.id:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="value" 			? ele.value:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="name" 			? ele.name:)
				LV_Modify(A_Index,"Col2",_LV_GetText(A_Index)="document.url" 	? wb.document.url:)
			}
			LV_ModifyCol()
			Radio1Text:=ele.innerhtml
			Radio2Text:=ele.outerhtml
			gosub,Radio
		}
	}
	if (OutWin3!=AHKID){
		global OutWin3
		Gui, 1:ListView,ListView1
		GuiControl,,Title,%OutWin1%
		OutWin4=%WinX%,%WinY%
		OutWin5=%WinW%,%WinH%
		OutWin6_X:=OutX-WinX
		OutWin6_Y:=OutY-WinY
		OutWin6=x%OutWin6_X% y%OutWin6_Y%
		WinGet,OutWin7, Style,ahk_id %OutWin3%
		WinGet,OutWin8, ExStyle,ahk_id %OutWin3%
		WinGet,OutWin9,PID,ahk_id %OutWin3%
		WinGet,OutWin10,ProcessName,ahk_id %OutWin3%
		WinGet,OutWin11,ProcessPath,ahk_id %OutWin3%
		WinGet,OutWin12,TransColor,ahk_id %OutWin3%
		OutWin13=%OutX% , %OutY%
		PixelGetColor,OutWin14,%OutX%,%OutY%,Slow RGB
		PixelGetColor,OutWin15,%OutX%,%OutY%,Slow
		WinGet,OutWin17,Transparent,ahk_id %OutWin3%
		if OutWin16=
			OutWin16=255
		GuiControl, Enable,Slider1
		GuiControl, ,Slider1,%OutWin16%
		GuiControl,,Text_t,透明度(%OutWin16%):
		Loop,%ListView1_Text_A0%
			LV_Modify(A_Index,"Col2",OutWin%A_Index%)
		LV_ModifyCol()
		Gui, 1:ListView,ListView2
		if (OutCtrl1!=""){
			ControlGetText,OutCtrl2,%OutCtrl1%,ahk_id %OutWin3%
			ControlGet,OutCtrl4,Hwnd,,%OutCtrl1%,ahk_id %OutWin3%
			OutCtrl3 := DllCall("GetDlgCtrlID", uint, OutCtrl4)
			if (OutCtrl3<=0)
				OutCtrl3=
			if (OutCtrlX!="") {
				OutCtrl5=%OutCtrlX%,%OutCtrlY%
				OutCtrl6=%OutCtrlW%,%OutCtrlH%
				if (TABVar<6)
					Gui2Show(WinX+OutCtrlX,WinY+OutCtrlY,OutCtrlW,OutCtrlH)
			}else{
				OutCtrl5=
				OutCtrl6=
			}
			if (OutCtrl6!="") {
				if (OutX-(WinX+OutCtrlX)>=0) {
					OutCtrl7_X:=OutX-(WinX+OutCtrlX)
					OutCtrl7_Y:=OutY-(WinY+OutCtrlY)
					OutCtrl7=x%OutCtrl7_X% y%OutCtrl7_Y%
				}else{
					OutCtrl7=
				}
			}else{
				OutCtrl7=
			}
			ControlGet,OutCtrl8,Style,,%OutCtrl1%,ahk_id %OutWin3%
			ControlGet,OutCtrl9,ExStyle,,%OutCtrl1%,ahk_id %OutWin3%
			Loop,%ListView2_Text_A0%
				LV_Modify(A_Index,"Col2",OutCtrl%A_Index%)
			LV_ModifyCol()
		}else{
			Loop,%ListView2_Text_A0%
				LV_Modify(A_Index,"Col2","")
		}
		Gui, 1:ListView,ListView3
		Loop,%ListView3_Text_A0% {
			LV_GetText(LV_TEXT,A_Index,2)
			if (OutWin7 & LV_TEXT or OutWin8 & LV_TEXT)
				LV_Modify(A_Index,"Check")
			else
				LV_Modify(A_Index,"-Check")
		}
		LV_ModifyCol()
		DetectHiddenText,Off
		WinGetText,OutWinText_Visible,ahk_id %OutWin3%
		GuiControl,,Visible_text,%OutWinText_Visible%
		DetectHiddenText,On
		WinGetText,OutWinText_Hidden,ahk_id %OutWin3%
		GuiControl,,Hidden_text,%OutWinText_Hidden%
		Gui, 1:ListView,ListView4
		WinGet,CtrList,ControlList,ahk_id %OutWin3%
		LV_Delete()
		Loop, Parse,CtrList,`n
		{
			ControlGet,CtrlHwnd,Hwnd,,%A_LoopField%,ahk_id %OutWin3%
			CtrlID:= DllCall("GetDlgCtrlID", uint, CtrlHwnd)
			if (CtrlID<=0)
				CtrlID=
			ControlGetText,CtrlText,%A_LoopField%,ahk_id %OutWin3%
			ControlGet,Visible,Visible,,%A_LoopField%,ahk_id %OutWin3%
			if (Visible=1)
				Visible=Check
			else if (Visible=0)
				Visible=-Check
			LV_Add(Visible,A_LoopField,CtrlID,CtrlHwnd,CtrlText)
			LV_ModifyCol(1,"","类别名[列表](" A_Index ")")
		}
		LV_ModifyCol()
	}
	eletag:=wb.document.GetElementsByTagName(ele.tagname)
	Loop % eletag.length
		if (eletag.item(A_Index-1).id=ele.id and eletag.item(A_Index-1).classname=ele.classname and eletag.item(A_Index-1).name=ele.name  `
			and eletag.item(A_Index-1).innertext=ele.innertext  and eletag.item(A_Index-1).outerhtml=ele.outerhtml `
			and eletag.item(A_Index-1).target=ele.target and eletag.item(A_Index-1).title=ele.title and eletag.item(A_Index-1).outertext=ele.outertext){
			global TagIndex:=A_Index-1
	break
	}
Gui, 1:ListView,ListView5
LV_ModifyCol(2,"","属性值 (" eletag.length-1 "/" TagIndex ")" )
Generate()
return
_LV_GetText(Index,Col=1) {
LV_GetText(sText,Index,Col)
return sText
}
Button1:
	Generate()
return
_MenuIsCheck( ThisMenu, ThisMenuItem, ValueName) {
RegRead,ThisCheck,HKCU,Software\AutoHotkey\AHKInfo,%ValueName%
if (ThisCheck=1) {
	Menu,%ThisMenu%,Check,%ThisMenuItem%
	errorLevel=1
}else if (ThisCheck=0) {
	Menu,%ThisMenu%,UnCheck,%ThisMenuItem%
	errorLevel=0
}else
	errorLevel=-1
}
_RegW( ValueName, value ) {
RegWrite,REG_DWORD ,HKCU,Software\AutoHotkey\AHKInfo,%ValueName%,%value%
}
_RegR( ValueName) {
RegRead,Outvalue,HKCU,Software\AutoHotkey\AHKInfo,%ValueName%
return %Outvalue%
}
IsMenuItemChecked( MenuPos, SubMenuPos, hWnd ) {
hMenu :=DllCall("GetMenu", UInt,hWnd )
hSubMenu := DllCall("GetSubMenu", UInt,hMenu, Int,MenuPos )
VarSetCapacity(mii, 48, 0), NumPut(48, mii, 0), NumPut(1, mii, 4)
DllCall( "GetMenuItemInfo", UInt,hSubMenu, UInt,SubMenuPos, Int, 1, UInt,&mii )
return ( NumGet(mii, 12) & 0x8 ) ? 1 : 0
}
EmptyMem(PID="AHK Rocks"){
pid:=(pid="AHK Rocks") ? DllCall("GetCurrentProcessId") : pid
h:=DllCall("OpenProcess", "UInt", 0x001F0FFF, "Int", 0, "Int", pid)
DllCall("SetProcessWorkingSetSize", "UInt", h, "Int", -1, "Int", -1)
DllCall("CloseHandle", "Int", h)
}
_ToolTip(Text,OutTime=3000) {
ToolTip,%Text%
SetTimer, RemoveToolTip, %OutTime%
}
RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
return
Gui2Show(x,y,w,h){
Gui, 2:Show,NA x%x% y%y% w%w% h%h%
Sleep,300
Gui, 2:Hide
}
StrToBin(Str) {
XMLDOM:=ComObjCreate("Microsoft.XMLDOM")
xmlver:="<?xml version=`"`"1.0`"`"?>"
XMLDOM.loadXML(xmlver)
Pic:=XMLDOM.createElement("pic")
Pic.dataType:="bin.hex"
pic.nodeTypedValue := Str
StrToByte := pic.nodeTypedValue
return StrToByte
}
BYTE_TO_FILE(body, filePath){
Stream := ComObjCreate("Adodb.Stream")
Stream.Type := 1
Stream.Open()
Stream.Write(body)
Stream.SaveToFile(filePath,2)
Stream.Close()
}
_IEObjGetFromHwnd(h_IECtrl)
{
	static Msg := DllCall("RegisterWindowMessage", "str", "WM_HTML_GETOBJECT")
	SendMessage, Msg, 0, 0, , ahk_id %h_IECtrl%
	if (ErrorLevel = "FAIL")
		return
	lResult := ErrorLevel
	VarSetCapacity(GuiD, 16, 0)
	GuiD := IID_IHTMLDocument2
	sGuiD := "{332C4425-26CB-11D0-B483-00C04FD90119}"
	CLSID := DllCall("ole32\CLSIDFromString", "wstr", sGuiD, "ptr", &GuiD) >= 0 ? &GuiD : ""
	DllCall("oleacc\ObjectFromLresult", "ptr", lResult, "ptr", CLSID, "ptr", 0, "ptr*", pDoc)
	static IID_IWebBrowserApp := "{0002DF05-0000-0000-C000-000000000046}"
	static SID_SWebBrowserApp := IID_IWebBrowserApp
	ComObjError(false)
	pWeb := ComObjQuery(pDoc, SID_SWebBrowserApp, IID_IWebBrowserApp)
	ObjRelease(pDoc)
	static VT_DISPATCH := 9, F_OWNVALUE := 1
	oIE := ComObjParameter(VT_DISPATCH, pWeb, F_OWNVALUE)
	return, oIE
}