Return
012C8AC3-2AAB-47A6-B33A-C28D1251373B:
;激活/最小化 TotalCMD
DetectHiddenWindows, on
IfWinNotExist ahk_class TTOTAL_CMD
	Run "\QuickZ\Apps\其它便携软件\TotalCMD\TOTALCMD.EXE"
Else
	IfWinNotActive ahk_class TTOTAL_CMD
	{			
		WinActivate
	}
Else
	{
		WinMinimize
		WinHide
	}
Return
Return
0175CD48-D8E6-47EC-95A0-26770F3D97FE:
;当前目录转到命令行 (&C)
TempWinClass= % gMenuZ.Data.winclass ;将获取的class名赋值给用户变量
if TempWinClass=
	WinGetClass, TempWinClass, A
if % TempWinClass="ExploreWClass" or TempWinClass="CabinetWClass" ;如果当前激活窗口为资源管理器
{
	ControlGetText, AddressBarText, ToolbarWindow322,ahk_class %TempWinClass% ;通过地址栏获取路径
	stringreplace, AddressBarText, AddressBarText, 地址:%A_space%, , All
	if AddressBarText =
		ControlGetText, AddressBarText, Edit1,ahk_class %TempWinClass%
	if AddressBarText=桌面
		AddressBarText=%A_Desktop%
	if AddressBarText=库\文档
		AddressBarText=%A_MyDocuments%
	if AddressBarText=库\图片
		AddressBarText=%A_MyDocuments%\..\Pictures
	if AddressBarText=库\音乐
		AddressBarText=%A_MyDocuments%\..\Music
	if AddressBarText=库\视频
		AddressBarText=%A_MyDocuments%\..\Videos
	if AddressBarText=库\下载
		AddressBarText=%A_MyDocuments%\..\Downloads
	if AddressBarText=库\图片
		AddressBarText=%A_MyDocuments%\..\Pictures
	;~ if AddressBarText=计算机
		;~ AddressBarText:="::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
	;~ if AddressBarText=回收站
		;~ AddressBarText:="::{645FF040-5081-101B-9F08-00AA002F954E}"
	;~ if AddressBarText=网络
		;~ AddressBarText:="::{208D2C60-3AEA-1069-A2D7-08002B30309D}"
}
if % TempWinClass="WorkerW" or TempWinClass="Progman" ;如果当前激活窗口为桌面
{
	AddressBarText=%A_Desktop%
}
if % TempWinClass="Shell_TrayWnd" ;如果当前激活窗口为任务栏
{
	MsgBox 该操作不适用于任务栏
	Exit
}

if % TempWinClass="TTOTAL_CMD" ;如果当前激活窗口为TC
{
    ClipSaved := ClipboardAll   ; 把剪贴板的所有内容保存到您选择的变量中.
    ; ... 这里临时使用剪贴板, 例如使用 Transform Unicode 粘贴 Unicode 文本 ...
    PostMessage,1075,332,0,,ahk_class TTOTAL_CMD ;把焦点移到来源窗口的地址栏
    PostMessage,1075,2029,0,,ahk_class TTOTAL_CMD ;获取路径
    sleep 80
    AddressBarText= % Clipboard
    Clipboard := ClipSaved   ; 恢复剪贴板为原来的内容. 注意这里使用 Clipboard (不是 ClipboardAll).
    ClipSaved =   ; 在原来的剪贴板含大量内容时释放内存.
    if AddressBarText=\\我的文档
        AddressBarText=%A_MyDocuments%
    if AddressBarText=\\桌面
        AddressBarText=%A_Desktop%
    if AddressBarText=\\回收站
    {
        MsgBox 该操作不适用于回收站
        Exit
    }
}

if InStr(FileExist(AddressBarText), "D")
    Run cmd.exe /k chdir /d "%AddressBarText%"
else
    msgbox 路径错误
TempWinClass=
Return
Return
0FC0EBD7-D938-4D2C-98A3-9FDEDEFAA8C9:
;显示所选内容>>(&S)
WinActivate % "ahk_class " gMenuZ.Data.winclass
WinWaitActive % "ahk_class " gMenuZ.Data.winclass
WinGetTitle, t, A
msgbox % "---信息概览---`n`n所选文件为：`n" gMenuZ.Data.files "`n`n" "所选文本为：`n" gMenuZ.Data.text "`n`n" "坐标为：`n" "x " gMenuZ.Data.x ", y " gMenuZ.Data.y "`n`n" "前台程序为：`n" gMenuZ.Data.winExe "`n`n" "窗口Class：`n" gMenuZ.Data.winclass "`n`n" "控件：`n" gMenuZ.Data.control "`n`n" "窗口标题：`n" t
return
Return
1762132B-CBCB-4CFF-B3A9-181E115A4B40:
;测试 (&1)
SourceText:=QZData("text")
SourceText:=CustomFunction_TextEscaping(SourceText)
;StringReplace, SourceText, SourceText, `n, ``n, All
;StringReplace, SourceText, SourceText, `r, ``r, All
SourceText=ToolTip %SourceText%
SourceText=%SourceText%`nsleep 3000`nexitapp
CustomFunction_PipeRun(SourceText)
Return
194490FE-77D0-44D8-9F12-E3AA269AE863:
;当前目录转到 TotalCMD 中浏览 Ctrl+T
FileManager:=QZData("%TC%")
FileManagerClass=TTOTAL_CMD
;===========
;以下内容不必改动
;===========
TempWinClass=
TempWinClass= % QZData("winclass") ;将获取的class名赋值给用户变量
if TempWinClass=
	WinGetClass, TempWinClass, A
if % TempWinClass="ExploreWClass" or TempWinClass="CabinetWClass" ;如果当前激活窗口为资源管理器
{
	ControlGetText, AddressBarText, ToolbarWindow322,ahk_class %TempWinClass% ;通过地址栏获取路径
	stringreplace, AddressBarText, AddressBarText, 地址:%A_space%, , All
	if AddressBarText =
		ControlGetText, AddressBarText, Edit1,ahk_class %TempWinClass%
	if AddressBarText=桌面
		AddressBarText=%A_Desktop%
	if AddressBarText=库\文档
		AddressBarText=%A_MyDocuments%
	if AddressBarText=库\图片
		AddressBarText=%A_MyDocuments%\..\Pictures
	if AddressBarText=库\音乐
		AddressBarText=%A_MyDocuments%\..\Music
	if AddressBarText=库\视频
		AddressBarText=%A_MyDocuments%\..\Videos
	if AddressBarText=库\下载
		AddressBarText=%A_MyDocuments%\..\Downloads
	if AddressBarText=库\图片
		AddressBarText=%A_MyDocuments%\..\Pictures
	if AddressBarText=计算机
		AddressBarText:="::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
	if AddressBarText=回收站
		AddressBarText:="::{645FF040-5081-101B-9F08-00AA002F954E}"
	if AddressBarText=网络
		AddressBarText:="::{208D2C60-3AEA-1069-A2D7-08002B30309D}"
}
if % TempWinClass="WorkerW" or TempWinClass="Progman" ;如果当前激活窗口为桌面
	AddressBarText=%A_Desktop%
if % TempWinClass="Shell_TrayWnd" ;如果当前激活窗口为任务栏
    Exit

Run "%FileManager%" "%AddressBarText%"
PreClipboard := ClipboardAll   ; 把剪贴板的所有内容保存到您选择的变量中.
; ... 这里临时使用剪贴板, 例如使用 Transform Unicode 粘贴 Unicode 文本 ...
Counter=3
Loop %Counter%
{
    Counter--
    WinWaitActive,ahk_class %FileManagerClass%
    PostMessage,1075,4001,0,,ahk_class %FileManagerClass% ;把焦点移到左侧窗口的地址栏
    sleep 80
    PostMessage,1075,2029,0,,ahk_class %FileManagerClass% ;获取路径
    sleep 80
    if % Clipboard=AddressBarText
        break
    else
        Run "%FileManager%" "%AddressBarText%"
}
Clipboard := PreClipboard   ; 恢复剪贴板为原来的内容. 注意这里使用 Clipboard (不是 ClipboardAll).
if % Counter<>0 and TempWinClass<>"WorkerW" and TempWinClass<>"Progman"
    WinClose, ahk_class %TempWinClass%
Return
Return
23EDE350-BDB9-4490-9E11-D1F81E173DF7:
;计算校验码 via HashMyFiles (&H)
If % A_Is64bitOS
    OSBit=64
else
    OSBit=32

FileList := RegExReplace(gMenuZ.Data.files, "\r\n", """ """)
Run, "\QuickZ\Apps\其它便携软件\NirSoft\HashMyFiles\HashMyFiles_%OSBit%.exe" /files /folder "%FileList%"
return
Return
297F4357-848C-4E44-AF98-32B67078CBC9:
;运行 via AutoHotkey1>>(&R)
FileFullPathList := RegExReplace(gMenuZ.Data.files, "\r\n", """ """) ; "%FileFullPathList%" （含双引号）是被选中文件的列表。
Run "%A_AhkPath%" "%FileFullPathList%"
Return
Return
2B58E7F7-CBAE-4801-9464-F73CA00776BB:
;浏览被编辑的文件所在目录 via TotalCMD (&T)
ExePath:=QZData("%TC%")
dPath:=CustomFunction_getDocumentPath()
Run % ExePath " /A /O " dPath
return
Return
2BD23F3A-8C65-4C08-A26A-C9543A532F0F:
;查询 (&!)

Return
3164513F-22FC-428F-8DFC-5625E97A432E:
;浏览被编辑的文件所在目录 via 资源管理器 (&D)
dPath:=CustomFunction_getDocumentPath()
Run, explorer.exe /select`,"%dPath%"
Return
Return
39EF0D81-E2E5-42E8-9F44-61508C8F877B:
;转到 Scite4AutoHotkey 中编辑 (&4)
Editor= ;执行前清空变量
Editor:=QZData("%Scite%") ;在本行指定要使用的编辑器变量
;===========
;以下内容无需改动
;===========
dPath=
dPath:=CustomFunction_getDocumentPath()
WinActivate % "ahk_class" QZData("winclass")
WinWaitActive % "ahk_class" QZData("winclass")
dTitle=
WinGetTitle, dTitle,  A
;~ ;===========
;~ ;通过Pipe运行代码
;~ ;===========
ScriptContent:=% "SetTitleMatchMode, 3`nGroupAdd, GroupName, " dTitle "`nWinClose, ahk_group GroupName`nWinWaitClose, ahk_group GroupName`nRun, """ Editor """ """ dPath """`nreturn"
CustomFunction_PipeRun(ScriptContent)
Return

Return
3A880D85-5738-496B-97AE-0D9AD053A96B:
;TotalCMD_来源窗口_缩略图
PostMessage,1075,269,0,,ahk_class TTOTAL_CMD
Return
52FBA000-1BB2-4860-98FB-3E6D34F598C2:
;&PPT 97 - 2003 演示文稿 (&P)
TemplateFileName=演示文稿1 ;模板文件名
ExtName=ppt ;模板后缀名
NewFileName=新建演示文稿 ;新建文件名
ShellNew:=QZData("%ShellNew%")

CustomWinClass= % GMenuZ.data.winclass ;将获取的class名赋值给用户变量
if % CustomWinClass="ExploreWClass" or CustomWinClass="CabinetWClass" ;如果当前激活窗口为任务栏 ;如果当前激活窗口为资源管理器
{
	ControlGetText, DstDir, ToolbarWindow322,ahk_class %CustomWinClass% ;通过地址栏获取路径
	stringreplace, DstDir, DstDir, 地址:%A_space%, , All
	if DstDir =
		ControlGetText, DstDir, Edit1,ahk_class %CustomWinClass%
	if DstDir=桌面
		DstDir=%A_Desktop%
	if DstDir=库\文档
		DstDir=%A_MyDocuments%
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=库\音乐
		DstDir=%A_MyDocuments%\..\Music
	if DstDir=库\视频
		DstDir=%A_MyDocuments%\..\Videos
	if DstDir=库\下载
		DstDir=%A_MyDocuments%\..\Downloads
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}
if % CustomWinClass="WorkerW" or CustomWinClass="Progman" ;如果当前激活窗口桌面
	DstDir=%A_Desktop%
if % CustomWinClass="Shell_TrayWnd" ;如果当前激活窗口为任务栏
{
	MsgBox 无法从任务栏新建文件
	Exit
}
if % CustomWinClass="TTOTAL_CMD" ;如果当前激活窗口为TC
{
	ClipSaved := ClipboardAll   ; 把剪贴板的所有内容保存到您选择的变量中.
	; ... 这里临时使用剪贴板, 例如使用 Transform Unicode 粘贴 Unicode 文本 ...
	PostMessage,1075,332,0,,ahk_class TTOTAL_CMD ;把焦点移到来源窗口的地址栏
	PostMessage,1075,2029,0,,ahk_class TTOTAL_CMD ;获取路径
	sleep 80
	DstDir= % Clipboard
	Clipboard := ClipSaved   ; 恢复剪贴板为原来的内容. 注意这里使用 Clipboard (不是 ClipboardAll).
	ClipSaved =   ; 在原来的剪贴板含大量内容时释放内存.
	if DstDir=\\我的文档
		DstDir=%A_MyDocuments%
	if DstDir=\\桌面
		DstDir=%A_Desktop%
	if DstDir=\\回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}

if DstDir=
{
	msgbox 无法从当前窗口新建文件
	Exit
}
if InStr(FileExist(DstDir), "D")
{
	File=%DstDir%\%NewFileName%.%ExtName%
	IfExist, %File%
	{
		Loop
		{
			File=%DstDir%\%NewFileName%_(%A_Index%).%ExtName%
			If !FileExist( File )
			{
				break
			}
		}
	}
	FileCopy, %ShellNew%\%TemplateFileName%.%ExtName%, %File%, 0
}
else
	msgbox 无法从当前窗口新建文件
	PostMessage,1075,540,0,,ahk_class TTOTAL_CMD ;刷新TC来源窗口
Return

Return
53C129FC-D751-40C3-A5DB-617597DFDB17:
;左键事件监控>>(&L)
Run "%A_AhkPath%"  "\QuickZ\Apps\AutoHotkey\AHK_Script_Manager\scripts\!左键事件监控\左键事件监控.ahk"
Return
564BD061-9A7B-433C-8557-73723512A2CE:
;RunD (&D)
FileSelectFile, ExePath, 1, %A_WorkingDir%\Apps\, 请指定你的应用程序, 可执行文件 (*.exe; *.bat; *.vbs; *.js; *.cmd; *.com)
InputBox, WinTitle, 请输入应用程序的标题, 示例：`n`n无标题 - 记事本`nahk_class Notepad`nahk_exe notepad.exe`nahk_id 0x2a0604, , , 235, , , , , 请输入应用程序的标题
WinActivate % "ahk_class" gMenuZ.Data.winclass
WinWaitActive % "ahk_class" gMenuZ.Data.winclass
SendInput,ExePath=%ExePath%`n;指定程序路径，可自行修改为相对路径`nWinTitle=%WinTitle%`n;打开程序后的默认标题`nCustomFunction_RunD(ExePath,WinTitle,x=0,y=0,WaitDuration=0)`n;格式为CustomFunction_RunD(应用程序,应用程序的标题,x,y,等待时间)
Return
Return
59A909AD-5B75-4942-A99C-AF6320B023F1:
;浏览程序目录 via TotalCMD (&P)
ExePath:=QZData("%TC%")
WinActivate,% "ahk_class " QZData("winclass")
WinWaitActive,% "ahk_class " QZData("winclass")
WinGet,ProcessPath,ProcessPath,A
Run, "%ExePath%" /A /O "%ProcessPath%"
return
Return
5D61487F-B00F-4C5F-A0DD-A839063C9053:
;AccViewer>>(&A)
Run "%A_AhkPath%" "\QuickZ\Apps\AutoHotkey\AHK_Script_Manager\scripts\!AccViewer Source\AccViewer Source.ahk"
Return
66F7AB27-18BB-4AAB-A114-7FE75F634E0B:
;文本文档 UTF-8 (&T)
TemplateFileName=新建文本文档
ExtName=txt
NewFileName=新建文本文档
TextEditor:=QZData("%Scite%")
ShellNew:=QZData("%ShellNew%")

CustomWinClass= % gMenuZ.Data.winclass ;将获取的class名赋值给用户变量
if % CustomWinClass="ExploreWClass" or CustomWinClass="CabinetWClass" ;如果当前激活窗口为任务栏 ;如果当前激活窗口为资源管理器
{
	ControlGetText, DstDir, ToolbarWindow322,ahk_class %CustomWinClass% ;通过地址栏获取路径
	stringreplace, DstDir, DstDir, 地址:%A_space%, , All
	if DstDir =
		ControlGetText, DstDir, Edit1,ahk_class %CustomWinClass%
	if DstDir=桌面
		DstDir=%A_Desktop%
	if DstDir=库\文档
		DstDir=%A_MyDocuments%
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=库\音乐
		DstDir=%A_MyDocuments%\..\Music
	if DstDir=库\视频
		DstDir=%A_MyDocuments%\..\Videos
	if DstDir=库\下载
		DstDir=%A_MyDocuments%\..\Downloads
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}
if % CustomWinClass="WorkerW" or CustomWinClass="Progman" ;如果当前激活窗口桌面
	DstDir=%A_Desktop%
if % CustomWinClass="Shell_TrayWnd" ;如果当前激活窗口为任务栏
{
	MsgBox 无法从任务栏新建文件
	Exit
}
if % CustomWinClass="TTOTAL_CMD" ;如果当前激活窗口为TC
{
	ClipSaved := ClipboardAll   ; 把剪贴板的所有内容保存到您选择的变量中.
	; ... 这里临时使用剪贴板, 例如使用 Transform Unicode 粘贴 Unicode 文本 ...
	PostMessage,1075,332,0,,ahk_class TTOTAL_CMD ;把焦点移到来源窗口的地址栏
	PostMessage,1075,2029,0,,ahk_class TTOTAL_CMD ;获取路径
	sleep 80
	DstDir= % Clipboard
	Clipboard := ClipSaved   ; 恢复剪贴板为原来的内容. 注意这里使用 Clipboard (不是 ClipboardAll).
	ClipSaved =   ; 在原来的剪贴板含大量内容时释放内存.
	if DstDir=\\我的文档
		DstDir=%A_MyDocuments%
	if DstDir=\\桌面
		DstDir=%A_Desktop%
	if DstDir=\\回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}

if DstDir=
{
	msgbox 无法从当前窗口新建文件
	Exit
}
if InStr(FileExist(DstDir), "D")
{
	File=%DstDir%\%NewFileName%.%ExtName%
	IfExist, %File%
	{
		Loop
		{
			File=%DstDir%\%NewFileName%_(%A_Index%).%ExtName%
			If !FileExist( File )
			{
				break
			}
		}
	}
	FileCopy, %ShellNew%\%TemplateFileName%.%ExtName%, %File%, 0
	;Run, "%TextEditor%" "%File%"
}
else
	msgbox 无法从当前窗口新建文件
	PostMessage,1075,540,0,,ahk_class TTOTAL_CMD ;刷新TC来源窗口
Return
Return
68172365-8930-4F4C-96A7-A7648C5BD688:
;TotalCMD_选中文件并下移一行
sendinput {Ins}
Return
6AA2722C-8C2F-4263-BEE3-D781434E7FCF:
;Word 文档
TemplateFileName=doc1 ;模板文件名
ExtName=docx ;模板后缀名
NewFileName=新建文档 ;新建文件名
ShellNew:=QZData("%ShellNew%")

CustomWinClass= % GMenuZ.data.winclass ;将获取的class名赋值给用户变量
if % CustomWinClass="ExploreWClass" or CustomWinClass="CabinetWClass" ;如果当前激活窗口为任务栏 ;如果当前激活窗口为资源管理器
{
	ControlGetText, DstDir, ToolbarWindow322,ahk_class %CustomWinClass% ;通过地址栏获取路径
	stringreplace, DstDir, DstDir, 地址:%A_space%, , All
	if DstDir =
		ControlGetText, DstDir, Edit1,ahk_class %CustomWinClass%
	if DstDir=桌面
		DstDir=%A_Desktop%
	if DstDir=库\文档
		DstDir=%A_MyDocuments%
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=库\音乐
		DstDir=%A_MyDocuments%\..\Music
	if DstDir=库\视频
		DstDir=%A_MyDocuments%\..\Videos
	if DstDir=库\下载
		DstDir=%A_MyDocuments%\..\Downloads
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}
if % CustomWinClass="WorkerW" or CustomWinClass="Progman" ;如果当前激活窗口桌面
	DstDir=%A_Desktop%
if % CustomWinClass="Shell_TrayWnd" ;如果当前激活窗口为任务栏
{
	MsgBox 无法从任务栏新建文件
	Exit
}
if % CustomWinClass="TTOTAL_CMD" ;如果当前激活窗口为TC
{
	ClipSaved := ClipboardAll   ; 把剪贴板的所有内容保存到您选择的变量中.
	; ... 这里临时使用剪贴板, 例如使用 Transform Unicode 粘贴 Unicode 文本 ...
	PostMessage,1075,332,0,,ahk_class TTOTAL_CMD ;把焦点移到来源窗口的地址栏
	PostMessage,1075,2029,0,,ahk_class TTOTAL_CMD ;获取路径
	sleep 80
	DstDir= % Clipboard
	Clipboard := ClipSaved   ; 恢复剪贴板为原来的内容. 注意这里使用 Clipboard (不是 ClipboardAll).
	ClipSaved =   ; 在原来的剪贴板含大量内容时释放内存.
	if DstDir=\\我的文档
		DstDir=%A_MyDocuments%
	if DstDir=\\桌面
		DstDir=%A_Desktop%
	if DstDir=\\回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}

if DstDir=
{
	msgbox 无法从当前窗口新建文件
	Exit
}
if InStr(FileExist(DstDir), "D")
{
	File=%DstDir%\%NewFileName%.%ExtName%
	IfExist, %File%
	{
		Loop
		{
			File=%DstDir%\%NewFileName%_(%A_Index%).%ExtName%
			If !FileExist( File )
			{
				break
			}
		}
	}
	FileCopy, %ShellNew%\%TemplateFileName%.%ExtName%, %File%, 0
}
else
	msgbox 无法从当前窗口新建文件
	PostMessage,1075,540,0,,ahk_class TTOTAL_CMD ;刷新TC来源窗口
Return

Return
6D33BB2C-0A4A-4352-97EB-29FA74A2B699:
;普通正则式表达式转成Send形式
;给正则式中特殊的字符自动加上花括号，以便可用于SendInput等指令中，应用于SendRaw不方便的情况。
WinActivate % "ahk_class " QZData("winclass")
WinWaitActive % "ahk_class " QZData("winclass")
SendInput % TransRegEx(QZData("text"))
return

TransRegEx(RegExText) {
	Loop 2
	{
		RegExText := RegExReplace(RegExText, "{", "{{}")
		RegExText := RegExReplace(RegExText, "(?<=[^{{])\}", "{}}")
		Arr=^,!,+,#
		Loop, Parse, Arr, `,
			RegExText := RegExReplace(RegExText, "((?<=[^{])\" A_loopfield "(?=[^}]))|^\" A_loopfield "|\" A_loopfield "$", "{" A_loopfield "}")
	}
	return RegExText
}
Return
6F883526-6C90-4FD9-8F0C-076333E36E7B:
;Keyremap_Down
sendinput {Blind}{Down}
Return
733E6957-DE6D-4541-9732-A92998C8CE5A:
;测试这段 AHK 代码 via PipeRun (&R)
CustomFunction_PipeRun(gMenuZ.Data.text)
return
Return
74A6D17B-75F0-45A6-9429-7E2056E2C698:
;打开 via Notepad 2-mod (&2)
FileList:=QZData("files")
Loop,Parse,FileList,`n,`r
{
Notepad2:=QZData("%Notepad2%")
Run "%Notepad2%" "%A_LoopField%"
sleep 100 ;此停顿是留给便携版的，安装版可注释掉
}
Return
Return
74FC385E-9692-4CB0-92AB-E0F67D52690F:
;Keyremap_Right
sendinput {Blind}{Right}
Return
7C33E51E-41E8-46EC-810E-5258A6453461:
;批量重命名 via Ant Renamer (&R)
ExePath:=QZData("%AntRenamer%")
;指定程序路径
WinTitle=ahk_exe Renamer.exe
;打开程序后的默认标题
CustomFunction_RunD(ExePath,WinTitle,x=0,y=0,WaitDuration=0)
Return

Return
831411CC-6EF6-4D5F-81B5-53AA9EB26B54:
;运行所有常驻程序及脚本>>(&A)
Run "%A_AhkPath%" "\QuickZ\Apps\AutoHotkey\AHK_Script_Manager\小工具及AHK脚本管理器.ahk"
Return
848A494D-B681-4AB9-9F0F-B1D5A98044C5:
;转换为AHK原义文本
WinActivate % "ahk_class " QZData("winclass")
WinWaitActive % "ahk_class " QZData("winclass")
SendInput % CustomFunction_TextEscaping(QZData("text"))
return
Return
87BDB765-3AEE-4FAC-A968-0271209077E5:
;在 AHK 帮助中搜索 (&?)
AhkChmPath="\QuickZ\Apps\AutoHotkey\AutoHotKey\AutoHotKey.chm"
;指定帮助文件的路径
AhkChmTitle=AutoHotkey Help
;指定帮助文件的标题
;===========
;以下内容无需改动
;===========
CustomFunction_AhkChm(QZData("text"),AhkChmPath,AhkChmTitle)
Return
Return
8AD632DC-F6F6-41EC-8FDA-A47F164FB70B:
;快速解压 via BandiZip (&Q)
BandiZip:=QZData("%BandiZip%")
FileFullPathList =% gMenuZ.Data.files ; "%FileFullPathList%" （含双引号）是被选中文件的列表。
RegExMatch(gMenuZ.Data.files, "((?!(\\|\n)).+(?=\\[^\\]+\n?$))", ParentDirPath) ;%ParentDirPath% 为被选中文件的父目录路径
Loop, Parse, FileFullPathList, `n, `r
{
 IfWinExist, ahk_exe BandiZipPortable.exe
  WinWaitClose, ahk_exe BandiZipPortable.exe
 Run "%BandiZip%" /extract_autodest  "%ParentDirPath%" "%A_LoopField%"
}
Return
Return
929B29F6-FF4A-4457-A1AB-DAFB567CCE2F:
;侦测系统位数>>(&O)
if % A_Is64bitOS=True
	msgbox 64
else
	msgbox 32
*/
/*
ThisProcess := DllCall("GetCurrentProcess") ;用DllCall方法判断系统位数
    ; 当找不到 IsWow64Process() 时，
    ; 即假定并非64位系统。
    ; Otherwise, use the value returned in IsWow64Process.
    if !DllCall("IsWow64Process", "uint", ThisProcess, "int*", IsWow64Process)
        IsWow64Process := false
    ;MsgBox % IsWow64Process ? "win64" : "win32"
    if  %IsWow64Process%=0
        msgbox 32
    else
        msgbox 64
*/
Return
Return
9341E2C5-77CB-4ADF-A3F6-20D89E8D27A9:
;搜索 via FileLocator Pro (&F)
Delimiter=;
FileList=% gMenuZ.Data.files
if FileList= ;如果未获得文件列表
    QuotedFileList:=CustomFunction_getFileManagerAddressBarText() ;获取当前所在目录
;~ { ;这段代码复制选中的文件路径到剪贴板
    ;~ PreClipboard:=ClipboardAll
    ;~ SendInput, ^c
    ;~ sleep 200
    ;~ if DllCall( "IsClipboardFormatAvailable", "UInt", iFmt:=15)
    ;~ {
        ;~ FileList=% Clipboard
        ;~ Clipboard:=PreClipboard
    ;~ }
    ;~ else
    ;~ {
        ;~ Clipboard:=PreClipboard
        ;~ Return
    ;~ }
;~ }    
else
{
    QuotedFileList= ;使用前先清空
    Loop, Parse, FileList , `n, `r
    {
        ;~ msgbox % A_LoopField
        if % StrLen(A_LoopField)<=3 ;如果路径为根目录
            QuotedFileList:=QuotedFileList """" A_LoopField "\""" Delimiter
        else
            QuotedFileList:=QuotedFileList """" A_LoopField """" Delimiter
    }
}
;msgbox % QuotedFileList
Run % """" QZData("%FileLocator%") """ -d " QuotedFileList " -f """" -c """""
Return
Return
9D3A004C-DF20-43FC-B202-31098B0812EF:
;ChangeMode_普通模式
vimd.changeMode("普通模式")
SplashImage Off
SplashImage, % "",W100 B fs10 CTFFFFFF CW000000,% "普通模式", , 切换模式提示
WinSet, Transparent, 180, ahk_class AutoHotkey2
sleep 1300
SplashImage Off
return
Return
A00FA273-20C2-41F8-AF71-B37FE693AE85:
;查询手机号>>(&P)
API_Doc = 
(%
<html>
<iframe id="api_iframe_51240" name="api_iframe_51240" src="" width="800" height="320" scrolling="no" frameborder="0"></iframe>
<script type="text/javascript">
//接口生成：http://www.51240.com/api/
document.getElementById("api_iframe_51240").src = "http://www.51240.com/apiiframe/?api_from=51240&api_url=http://shouji.51240.com/&api_width=98%&api_backgroundcolor=FFFFFF";
</script>
</html>
)
API_Html := A_Temp "\51240.html"
FileDelete, %API_Html%
FileAppend, %API_Doc%, %API_Html%
Gui, API: Destroy
Gui, API: Add, ActiveX, w840 h350 vWB, Shell.Explorer  ; 最后一个参数是ActiveX组件的名称。
WB.Navigate(API_Html)
Gui, API: Show
Return
A2EAA141-8702-4F7E-9D8C-27CD77F2582D:
;Keyremap_Left
sendinput {Blind}{Left}
Return
A64AEA54-E211-45FF-B13E-ED219E53C131:
;运行 via AutoHotkey (&R)
FileFullPathList=
FileFullPathList:=QZData("files")
Loop, Parse, FileFullPathList, `n, `r
    Run "%A_AhkPath%" "%A_LoopField%"
return
Return
AA816957-9162-4689-9714-DEDD0E31B39B:
;在线五笔输入法86版
API_Doc = 
(%
<html>
<iframe id="api_iframe_51240" name="api_iframe_51240" src="" width="800" height="800" scrolling="no" frameborder="0"></iframe>
<script type="text/javascript">
//接口生成：http://www.51240.com/api/
document.getElementById("api_iframe_51240").src = "http://www.51240.com/apiiframe/?api_from=51240&api_url=http://zaixianwubishuru.51240.com/&api_width=98%&api_backgroundcolor=FFFFFF";
</script>
</html>
)
API_Html := A_Temp "\51240.html"
FileDelete, %API_Html%
FileAppend, %API_Doc%, %API_Html%
Gui, API: Destroy
Gui, API: Add, ActiveX, w840 h350 vWB, Shell.Explorer  ; 最后一个参数是ActiveX组件的名称。
WB.Navigate(API_Html)
Gui, API: Show
Return
B0DE5D78-BB17-4A59-B9E8-57595B8E6D92:
;AHK 脚本 UTF-8 (&S)
TemplateFileName=新AHK脚本
ExtName=ahk
NewFileName=新AHK脚本
TextEditor:=QZData("%Scite%")
ShellNew:=QZData("%ShellNew%")

CustomWinClass= % gMenuZ.Data.winclass ;将获取的class名赋值给用户变量
if % CustomWinClass="ExploreWClass" or CustomWinClass="CabinetWClass" ;如果当前激活窗口为任务栏 ;如果当前激活窗口为资源管理器
{
	ControlGetText, DstDir, ToolbarWindow322,ahk_class %CustomWinClass% ;通过地址栏获取路径
	stringreplace, DstDir, DstDir, 地址:%A_space%, , All
	if DstDir =
		ControlGetText, DstDir, Edit1,ahk_class %CustomWinClass%
	if DstDir=桌面
		DstDir=%A_Desktop%
	if DstDir=库\文档
		DstDir=%A_MyDocuments%
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=库\音乐
		DstDir=%A_MyDocuments%\..\Music
	if DstDir=库\视频
		DstDir=%A_MyDocuments%\..\Videos
	if DstDir=库\下载
		DstDir=%A_MyDocuments%\..\Downloads
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}
if % CustomWinClass="WorkerW" or CustomWinClass="Progman" ;如果当前激活窗口桌面
	DstDir=%A_Desktop%
if % CustomWinClass="Shell_TrayWnd" ;如果当前激活窗口为任务栏
{
	MsgBox 无法从任务栏新建文件
	Exit
}
if % CustomWinClass="TTOTAL_CMD" ;如果当前激活窗口为TC
{
	ClipSaved := ClipboardAll   ; 把剪贴板的所有内容保存到您选择的变量中.
	; ... 这里临时使用剪贴板, 例如使用 Transform Unicode 粘贴 Unicode 文本 ...
	PostMessage,1075,332,0,,ahk_class TTOTAL_CMD ;把焦点移到来源窗口的地址栏
	PostMessage,1075,2029,0,,ahk_class TTOTAL_CMD ;获取路径
	sleep 80
	DstDir= % Clipboard
	Clipboard := ClipSaved   ; 恢复剪贴板为原来的内容. 注意这里使用 Clipboard (不是 ClipboardAll).
	ClipSaved =   ; 在原来的剪贴板含大量内容时释放内存.
	if DstDir=\\我的文档
		DstDir=%A_MyDocuments%
	if DstDir=\\桌面
		DstDir=%A_Desktop%
	if DstDir=\\回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}

if DstDir=
{
	msgbox 无法从当前窗口新建文件
	Exit
}
if InStr(FileExist(DstDir), "D")
{
	File=%DstDir%\%NewFileName%.%ExtName%
	IfExist, %File%
	{
		Loop
		{
			File=%DstDir%\%NewFileName%_(%A_Index%).%ExtName%
			If !FileExist( File )
			{
				break
			}
		}
	}
	FileCopy, %ShellNew%\%TemplateFileName%.%ExtName%, %File%, 0
	Run, "%TextEditor%" "%File%"
}
else
	msgbox 无法从当前窗口新建文件
	PostMessage,1075,540,0,,ahk_class TTOTAL_CMD ;刷新TC来源窗口
Return
Return
B3C2F809-3CC9-4D21-8620-7829301E2462:
;Excel 工作表
TemplateFileName=book1 ;模板文件名
ExtName=xlsx ;模板后缀名
NewFileName=新建工作表 ;新建文件名
ShellNew:=QZData("%ShellNew%")

CustomWinClass= % GMenuZ.data.winclass ;将获取的class名赋值给用户变量
if % CustomWinClass="ExploreWClass" or CustomWinClass="CabinetWClass" ;如果当前激活窗口为任务栏 ;如果当前激活窗口为资源管理器
{
	ControlGetText, DstDir, ToolbarWindow322,ahk_class %CustomWinClass% ;通过地址栏获取路径
	stringreplace, DstDir, DstDir, 地址:%A_space%, , All
	if DstDir =
		ControlGetText, DstDir, Edit1,ahk_class %CustomWinClass%
	if DstDir=桌面
		DstDir=%A_Desktop%
	if DstDir=库\文档
		DstDir=%A_MyDocuments%
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=库\音乐
		DstDir=%A_MyDocuments%\..\Music
	if DstDir=库\视频
		DstDir=%A_MyDocuments%\..\Videos
	if DstDir=库\下载
		DstDir=%A_MyDocuments%\..\Downloads
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}
if % CustomWinClass="WorkerW" or CustomWinClass="Progman" ;如果当前激活窗口桌面
	DstDir=%A_Desktop%
if % CustomWinClass="Shell_TrayWnd" ;如果当前激活窗口为任务栏
{
	MsgBox 无法从任务栏新建文件
	Exit
}
if % CustomWinClass="TTOTAL_CMD" ;如果当前激活窗口为TC
{
	ClipSaved := ClipboardAll   ; 把剪贴板的所有内容保存到您选择的变量中.
	; ... 这里临时使用剪贴板, 例如使用 Transform Unicode 粘贴 Unicode 文本 ...
	PostMessage,1075,332,0,,ahk_class TTOTAL_CMD ;把焦点移到来源窗口的地址栏
	PostMessage,1075,2029,0,,ahk_class TTOTAL_CMD ;获取路径
	sleep 80
	DstDir= % Clipboard
	Clipboard := ClipSaved   ; 恢复剪贴板为原来的内容. 注意这里使用 Clipboard (不是 ClipboardAll).
	ClipSaved =   ; 在原来的剪贴板含大量内容时释放内存.
	if DstDir=\\我的文档
		DstDir=%A_MyDocuments%
	if DstDir=\\桌面
		DstDir=%A_Desktop%
	if DstDir=\\回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}

if DstDir=
{
	msgbox 无法从当前窗口新建文件
	Exit
}
if InStr(FileExist(DstDir), "D")
{
	File=%DstDir%\%NewFileName%.%ExtName%
	IfExist, %File%
	{
		Loop
		{
			File=%DstDir%\%NewFileName%_(%A_Index%).%ExtName%
			If !FileExist( File )
			{
				break
			}
		}
	}
	FileCopy, %ShellNew%\%TemplateFileName%.%ExtName%, %File%, 0
}
else
	msgbox 无法从当前窗口新建文件
	PostMessage,1075,540,0,,ahk_class TTOTAL_CMD ;刷新TC来源窗口
Return

Return
B537E2AE-5E90-48B2-B831-47DE66E57B23:
;运行 via AutoHotkey>>(&R)
FileFullPathList := RegExReplace(gMenuZ.Data.files, "\r\n", """ """) ; "%FileFullPathList%" （含双引号）是被选中文件的列表。
Run "%A_AhkPath%" "%FileFullPathList%"
Return
Return
B75A5D8D-D087-4DCD-9A6E-824A23439EB3:
;运行所有常驻程序及脚本>>(&A)
Run "%A_AhkPath%" "\QuickZ\Apps\AutoHotkey\AHK_Script_Manager\小工具及AHK脚本管理器.ahk"
Return
BEE6AB5F-ED75-4588-8641-15EC770C72FB:
;有道网络翻译 (&Y)
Youdao_keyword=% QZData("text")
Youdao_译文:=YouDaoApi(Youdao_keyword)
;~ 	MsgBox %Youdao_译文%

Youdao_音标:= json(Youdao_译文, "basic.phonetic")
Youdao_基本释义:= json(Youdao_译文, "basic.explains")
Youdao_网络释义:= json(Youdao_译文, "web.value")
Gui Gui_youdao_danci: Font,s14 微软雅黑 c62384C q2
If Youdao_基本释义<>
{
    Gui Gui_youdao_danci:add,Edit,x10 y10  w300 h100,[ %Youdao_音标% ]
    Gui Gui_youdao_danci:add,Edit,x10 y120 w300 h100,%Youdao_基本释义%
    Gui Gui_youdao_danci:add,Edit,x10 y230 w300 h100,%Youdao_网络释义%
}
Else
{
    Youdao_音标:=RegExReplace(Youdao_译文,"m)({""translation""\:\["")|(""\],""query""\:.*)")
    Gui Gui_youdao_danci:add,Edit,x10 y10  w300 h300,%Youdao_音标%
}

Gui Gui_youdao_danci:show,,有道网络翻译
Return
Gui_youdao_danciGuiClose:
Gui_youdao_danciGuiEscape:
Gui Gui_youdao_danci:destroy
Return




YouDaoApi(KeyWord)
{
    KeyWord:=CustomFunction_SkSub_UrlEncode(KeyWord,"utf-8")
	url:="http://fanyi.youdao.com/fanyiapi.do?keyfrom=qqqqqqqq123&key=86514254&type=data&doctype=json&version=1.1&q=" . KeyWord
    WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    WebRequest.Open("GET", url)
    WebRequest.Send()
    result := WebRequest.ResponseText
    Return result
}


json(ByRef js, s, v = "")
{
	j = %js%
	Loop, Parse, s, .
	{
		p = 2
		RegExMatch(A_LoopField, "([+\-]?)([^[]+)((?:\[\d+\])*)", q)
		Loop {
			If (!p := RegExMatch(j, "(?<!\\)(""|')([^\1]+?)(?<!\\)(?-1)\s*:\s*((\{(?:[^{}]++|(?-1))*\})|(\[(?:[^[\]]++|(?-1))*\])|"
				. "(?<!\\)(""|')[^\7]*?(?<!\\)(?-1)|[+\-]?\d+(?:\.\d*)?|true|false|null?)\s*(?:,|$|\})", x, p))
				Return
			Else If (x2 == q2 or q2 == "*") {
				j = %x3%
				z += p + StrLen(x2) - 2
				If (q3 != "" and InStr(j, "[") == 1) {
					StringTrimRight, q3, q3, 1
					Loop, Parse, q3, ], [
					{
						z += 1 + RegExMatch(SubStr(j, 2, -1), "^(?:\s*((\[(?:[^[\]]++|(?-1))*\])|(\{(?:[^{\}]++|(?-1))*\})|[^,]*?)\s*(?:,|$)){" . SubStr(A_LoopField, 1) + 1 . "}", x)
						j = %x1%
					}
				}
				Break
			}
			Else p += StrLen(x)
		}
	}
	If v !=
	{
		vs = "
		If (RegExMatch(v, "^\s*(?:""|')*\s*([+\-]?\d+(?:\.\d*)?|true|false|null?)\s*(?:""|')*\s*$", vx)
			and (vx1 + 0 or vx1 == 0 or vx1 == "true" or vx1 == "false" or vx1 == "null" or vx1 == "nul"))
			vs := "", v := vx1
		StringReplace, v, v, ", \", All
		js := SubStr(js, 1, z := RegExMatch(js, ":\s*", zx, z) + StrLen(zx) - 1) . vs . v . vs . SubStr(js, z + StrLen(x3) + 1)
	}
	Return, j == "false" ? 0 : j == "true" ? 1 : j == "null" or j == "nul"
		? "" : SubStr(j, 1, 1) == """" ? SubStr(j, 2, -1) : j
}
Return
C0ED14DE-E2CE-4A9B-B58D-748E6B948044:
;查询剪贴板数据类型>>(&C)
if DllCall( "IsClipboardFormatAvailable", "UInt", iFmt:=15)
	msgbox % "剪贴板内包含的文件为：`n"Clipboard
if DllCall( "IsClipboardFormatAvailable", "UInt", iFmt:=2)
	MsgBox 剪贴板内为位图
if DllCall( "IsClipboardFormatAvailable", "UInt", iFmt:=1)
	msgbox % "剪贴板内的文本内容为：`n"Clipboard
else
	MsgBox 无法识别剪贴板内容
Return
Return
C3A4C284-79B3-4DCF-8516-AD4A653CA8BD:
;ChangeMode_插入模式
vimd.changeMode("插入模式")
SplashImage Off
SplashImage, % "",W100 B fs10 CTFFFFFF CW000000,% "插入模式", , 切换模式提示
WinSet, Transparent, 180, ahk_class AutoHotkey2
sleep 1300
SplashImage Off
return
Return
C52F6052-0D11-4CE9-B33E-ACBEEC27A1A8:
;浏览进程目录 via 资源管理器
WinActivate,% "ahk_class " QZData("winclass")
WinWaitActive,% "ahk_class " QZData("winclass")
WinGet,ProcessPath,ProcessPath,A
Run,% "explorer.exe /select,"ProcessPath
return
Return
C751C970-3F47-458F-BA18-F6C462501342:
;复制文件完整路径 Alt+Ins
if % gMenuZ.Data.files=""
{
    ;#UseHook  ; 强制从这里往后的热键使用键盘钩子。
    PreClipboard:=ClipboardAll
    SendInput, ^Ins
    Sleep 200
    ;#UseHook off
    if DllCall( "IsClipboardFormatAvailable", "UInt", iFmt:=15)
        Clipboard=% Clipboard
    else
        Clipboard:=PreClipboard
    PreClipboard=
}
else
    Clipboard=% gMenuZ.Data.files
gMenuZ.Data.files:=""
Return
Return
C81BC009-6E97-4C0A-87BE-39F9A9AB97B9:
;Keyremap_Up
sendinput {Blind}{Up}
Return
CA590820-AB53-4F2E-A82D-DCB2A4DD8857:
;转到 Notepad2-mod 中编辑 (&2)
Editor= ;执行前清空变量
Editor:=QZData("%Notepad2%") ;在本行指定要使用的编辑器变量
;===========
;以下内容无需改动
;===========
dPath=
dPath:=CustomFunction_getDocumentPath()
WinActivate % "ahk_class" QZData("winclass")
WinWaitActive % "ahk_class" QZData("winclass")
dTitle=
WinGetTitle, dTitle,  A
;~ ;===========
;~ ;通过Pipe运行代码
;~ ;===========
ScriptContent:=% "SetTitleMatchMode, 3`nGroupAdd, GroupName, " dTitle "`nWinClose, ahk_group GroupName`nWinWaitClose, ahk_group GroupName`nRun, """ Editor """ """ dPath """`nreturn"
CustomFunction_PipeRun(ScriptContent)
Return
Return
CFD902C9-C82E-475A-A490-C326C2B6AF39:
;Spy++>>(&S)
Run "%A_AhkPath%" "\QuickZ\Apps\AutoHotkey\AHK_Script_Manager\scripts\!Ahkspy++\Ahkspy++.ahk"
Return
D1212C27-5B50-4B26-B5DF-E07290ED60E5:
;&Word 97 - 2003 文档 (&W)
TemplateFileName=doc1 ;模板文件名
ExtName=doc ;模板后缀名
NewFileName=新建文档 ;新建文件名
ShellNew:=QZData("%ShellNew%")

CustomWinClass= % GMenuZ.data.winclass ;将获取的class名赋值给用户变量
if % CustomWinClass="ExploreWClass" or CustomWinClass="CabinetWClass" ;如果当前激活窗口为任务栏 ;如果当前激活窗口为资源管理器
{
	ControlGetText, DstDir, ToolbarWindow322,ahk_class %CustomWinClass% ;通过地址栏获取路径
	stringreplace, DstDir, DstDir, 地址:%A_space%, , All
	if DstDir =
		ControlGetText, DstDir, Edit1,ahk_class %CustomWinClass%
	if DstDir=桌面
		DstDir=%A_Desktop%
	if DstDir=库\文档
		DstDir=%A_MyDocuments%
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=库\音乐
		DstDir=%A_MyDocuments%\..\Music
	if DstDir=库\视频
		DstDir=%A_MyDocuments%\..\Videos
	if DstDir=库\下载
		DstDir=%A_MyDocuments%\..\Downloads
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}
if % CustomWinClass="WorkerW" or CustomWinClass="Progman" ;如果当前激活窗口桌面
	DstDir=%A_Desktop%
if % CustomWinClass="Shell_TrayWnd" ;如果当前激活窗口为任务栏
{
	MsgBox 无法从任务栏新建文件
	Exit
}
if % CustomWinClass="TTOTAL_CMD" ;如果当前激活窗口为TC
{
	ClipSaved := ClipboardAll   ; 把剪贴板的所有内容保存到您选择的变量中.
	; ... 这里临时使用剪贴板, 例如使用 Transform Unicode 粘贴 Unicode 文本 ...
	PostMessage,1075,332,0,,ahk_class TTOTAL_CMD ;把焦点移到来源窗口的地址栏
	PostMessage,1075,2029,0,,ahk_class TTOTAL_CMD ;获取路径
	sleep 80
	DstDir= % Clipboard
	Clipboard := ClipSaved   ; 恢复剪贴板为原来的内容. 注意这里使用 Clipboard (不是 ClipboardAll).
	ClipSaved =   ; 在原来的剪贴板含大量内容时释放内存.
	if DstDir=\\我的文档
		DstDir=%A_MyDocuments%
	if DstDir=\\桌面
		DstDir=%A_Desktop%
	if DstDir=\\回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}

if DstDir=
{
	msgbox 无法从当前窗口新建文件
	Exit
}
if InStr(FileExist(DstDir), "D")
{
	File=%DstDir%\%NewFileName%.%ExtName%
	IfExist, %File%
	{
		Loop
		{
			File=%DstDir%\%NewFileName%_(%A_Index%).%ExtName%
			If !FileExist( File )
			{
				break
			}
		}
	}
	FileCopy, %ShellNew%\%TemplateFileName%.%ExtName%, %File%, 0
}
else
	msgbox 无法从当前窗口新建文件
	PostMessage,1075,540,0,,ahk_class TTOTAL_CMD ;刷新TC来源窗口
Return
Return
D2E5E9CC-A552-40A5-AD7D-29EE74CB80C9:
;PPT 演示文稿
TemplateFileName=演示文稿1 ;模板文件名
ExtName=pptx ;模板后缀名
NewFileName=新建演示文稿 ;新建文件名
ShellNew:=QZData("%ShellNew%")

CustomWinClass= % GMenuZ.data.winclass ;将获取的class名赋值给用户变量
if % CustomWinClass="ExploreWClass" or CustomWinClass="CabinetWClass" ;如果当前激活窗口为任务栏 ;如果当前激活窗口为资源管理器
{
	ControlGetText, DstDir, ToolbarWindow322,ahk_class %CustomWinClass% ;通过地址栏获取路径
	stringreplace, DstDir, DstDir, 地址:%A_space%, , All
	if DstDir =
		ControlGetText, DstDir, Edit1,ahk_class %CustomWinClass%
	if DstDir=桌面
		DstDir=%A_Desktop%
	if DstDir=库\文档
		DstDir=%A_MyDocuments%
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=库\音乐
		DstDir=%A_MyDocuments%\..\Music
	if DstDir=库\视频
		DstDir=%A_MyDocuments%\..\Videos
	if DstDir=库\下载
		DstDir=%A_MyDocuments%\..\Downloads
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}
if % CustomWinClass="WorkerW" or CustomWinClass="Progman" ;如果当前激活窗口桌面
	DstDir=%A_Desktop%
if % CustomWinClass="Shell_TrayWnd" ;如果当前激活窗口为任务栏
{
	MsgBox 无法从任务栏新建文件
	Exit
}
if % CustomWinClass="TTOTAL_CMD" ;如果当前激活窗口为TC
{
	ClipSaved := ClipboardAll   ; 把剪贴板的所有内容保存到您选择的变量中.
	; ... 这里临时使用剪贴板, 例如使用 Transform Unicode 粘贴 Unicode 文本 ...
	PostMessage,1075,332,0,,ahk_class TTOTAL_CMD ;把焦点移到来源窗口的地址栏
	PostMessage,1075,2029,0,,ahk_class TTOTAL_CMD ;获取路径
	sleep 80
	DstDir= % Clipboard
	Clipboard := ClipSaved   ; 恢复剪贴板为原来的内容. 注意这里使用 Clipboard (不是 ClipboardAll).
	ClipSaved =   ; 在原来的剪贴板含大量内容时释放内存.
	if DstDir=\\我的文档
		DstDir=%A_MyDocuments%
	if DstDir=\\桌面
		DstDir=%A_Desktop%
	if DstDir=\\回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}

if DstDir=
{
	msgbox 无法从当前窗口新建文件
	Exit
}
if InStr(FileExist(DstDir), "D")
{
	File=%DstDir%\%NewFileName%.%ExtName%
	IfExist, %File%
	{
		Loop
		{
			File=%DstDir%\%NewFileName%_(%A_Index%).%ExtName%
			If !FileExist( File )
			{
				break
			}
		}
	}
	FileCopy, %ShellNew%\%TemplateFileName%.%ExtName%, %File%, 0
}
else
	msgbox 无法从当前窗口新建文件
	PostMessage,1075,540,0,,ahk_class TTOTAL_CMD ;刷新TC来源窗口
Return

Return
D8D9E343-81FC-461F-ACEC-3B88917B56D2:
;AHK Control>>(&C)
Run "%A_AhkPath%" "\QuickZ\Apps\AutoHotkey\AHK_Script_Manager\scripts\AHKControl\AHKControl.ahk"
Return
E6BB23EF-8B23-482F-B6B2-226869855DBD:
;转到 Notepad++ 中编辑 (&+)
Editor= ;执行前清空变量
Editor:=QZData("%Notepad++%") ;在本行指定要使用的编辑器变量
;===========
;以下内容无需改动
;===========
dPath=
dPath:=CustomFunction_getDocumentPath()
WinActivate % "ahk_class" QZData("winclass")
WinWaitActive % "ahk_class" QZData("winclass")
dTitle=
WinGetTitle, dTitle,  A
;~ ;===========
;~ ;通过Pipe运行代码
;~ ;===========
ScriptContent:=% "SetTitleMatchMode, 3`nGroupAdd, GroupName, " dTitle "`nWinClose, ahk_group GroupName`nWinWaitClose, ahk_group GroupName`nRun, """ Editor """ """ dPath """`nreturn"
CustomFunction_PipeRun(ScriptContent)
Return

Return
E7ABDEB0-05A5-4A88-96EF-3605FC4DBBC4:
;粉碎文件 via 360文件粉碎机
ExePath:=QZData("%360FileSmasher%")
;指定程序路径
WinTitle=ahk_exe FileSmasher.exe
;打开程序后的默认标题
CustomFunction_RunD(ExePath,WinTitle,x=0,y=0,WaitDuration=0)
Return

Return
E81E2ED3-78C1-40E1-B9E1-5DEF106D7DAE:
;擦除文件 via SDelete (&D)
SDelete:=QZData("%SDelete%")
CustomFunction_TaskDialogUseMsgBoxOnXP(true)
Choice=
Choice:=CustomFunction_TaskDialogEx("删除文件确认,删除的文件将不可恢复，请谨慎操作。确定要彻底删除下列文件？",QZData("files"),"SDelete - 文件永久删除",6,7,800,-1,0)
if Choice=6
{
	FileList := RegExReplace(QZData("files"), "\r\n", """ """) ; "%FileList%" （含双引号）是被选中文件的列表。
	Run, "%SDelete%" -a -r "%FileList%" 
	WinWait, ahk_exe SDelete.exe
	WinWaitClose, ahk_exe SDelete.exe
	FileList=% QZData("files")
	Loop, Parse, FileList, `n, `r
		FileRemoveDir, %A_LoopField%, 1
	if % QZData("winclass")="TTOTAL_CMD"
		PostMessage,1075,540,0,,ahk_class TTOTAL_CMD
	else
	{
		WinActivate,% "ahk_class " QZData("winclass")
		WinWaitActive,% "ahk_class " QZData("winclass")
		SendInput {F5}
	}
}
Return
Return
E86D8A59-FE5E-47B3-84BE-1ABD21B83ABB:
;压缩打包 via 7-Zip (&Z)
FileList := RegExReplace(gMenuZ.Data.files, "\r\n", """ """) 
IfInString,FileList," "
	RegExMatch(gMenuZ.Data.files, "([^(\\|\n)]+[^:]|\w)(?=:?\\[^\\]+$)", PackName) ;%PackName% 为被选中文件的父目录名，将被用作压缩包名
else
	TempAttribute:=FileExist(FileList)
	IfInString,TempAttribute,D
		SplitPath, FileList, PackName
	else
		SplitPath, FileList, , , , PackName
RegExMatch(gMenuZ.Data.files, "((?!(\\|\n)).+(?=\\[^\\]+\n?$))", ParentDirPath) ;%ParentDirPath% 为被选中文件的父目录路径
Pack:=PackNameCheck(ParentDirPath,PackName)
ThisProcess := DllCall("GetCurrentProcess")
if !DllCall("IsWow64Process", "uint", ThisProcess, "int*", IsWow64Process)
	IsWow64Process := false
if  %IsWow64Process%=0
	Run "Apps\PortableApps\7-ZipPortable\App\7-Zip\7zG.exe" a "%Pack% "%FileList%"
else
	Run "Apps\PortableApps\7-ZipPortable\App\7-Zip64\7zG.exe" a "%Pack%" "%FileList%"
PostMessage,1075,540,0,,ahk_class TTOTAL_CMD
Return

PackNameCheck(ParentDirPath,PackName)
{
	Pack=%ParentDirPath%\%PackName%.zip
	IfExist, %Pack%
	{
		Loop
		{
			Pack=%ParentDirPath%\%PackName%_(%A_Index%).zip
			If !FileExist( Pack )
			{
				break
			}
		}
	}
	Return Pack
}
Return
EFCEF694-2DBA-4D5D-94C7-0D06374CAC2D:
;测试

Return
F25AC06D-0672-4AFB-BF53-66C2224FF013:
;窗口置顶/取消置顶 Win+Tab
iHwnd=
iHwnd := gMenuZ.Data.hwnd
if iHwnd=
	WinGet, iHwnd, ID, A
wTitle=
WinGetTitle, wTitle, ahk_id %iHwnd%
X=
Y=
Width=
Height=
WinSet, AlwaysOnTop, Toggle, ahk_id %iHwnd%
WinGetPos, X, Y, Width, Height, ahk_id %iHwnd%
Y:=Y+5
WinGet, ExStyle, ExStyle, ahk_id %iHwnd%
if (ExStyle & 0x8)  ; 0x8 为 WS_EX_TOPMOST.
;  ... 窗口处于置顶状态, 执行适当的动作.
{
	WinSetTitle, ahk_id %iHwnd%, , %wTitle%_已置顶
	SplashImage Off
	SplashImage, % "",X%X% Y%Y% W100 B fs10 CTFFFFFF CW000000,% "窗口已置顶", , 切换模式提示
	WinSet, Transparent, 180, ahk_class AutoHotkey2
	sleep 1300
	SplashImage Off
}
else
{
	wTitle:=RegExReplace(wTitle, "_已置顶")
	WinSetTitle, ahk_id %iHwnd%, , %wTitle%
	SplashImage Off
	SplashImage, % "",X%X% Y%Y% W100 B fs10 CTFFFFFF CW000000,% "取消置顶", , 切换模式提示
	WinSet, Transparent, 180, ahk_class AutoHotkey2
	sleep 1300
	SplashImage Off
}
return
Return
F5EE2F80-5ED3-4884-8CB2-C9319CF091BE:
;&Excel 97 - 2003 工作表 (&E)
TemplateFileName=book1 ;模板文件名
ExtName=xls ;模板后缀名
NewFileName=新建工作表 ;新建文件名
ShellNew:=QZData("%ShellNew%")

CustomWinClass= % GMenuZ.data.winclass ;将获取的class名赋值给用户变量
if % CustomWinClass="ExploreWClass" or CustomWinClass="CabinetWClass" ;如果当前激活窗口为任务栏 ;如果当前激活窗口为资源管理器
{
	ControlGetText, DstDir, ToolbarWindow322,ahk_class %CustomWinClass% ;通过地址栏获取路径
	stringreplace, DstDir, DstDir, 地址:%A_space%, , All
	if DstDir =
		ControlGetText, DstDir, Edit1,ahk_class %CustomWinClass%
	if DstDir=桌面
		DstDir=%A_Desktop%
	if DstDir=库\文档
		DstDir=%A_MyDocuments%
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=库\音乐
		DstDir=%A_MyDocuments%\..\Music
	if DstDir=库\视频
		DstDir=%A_MyDocuments%\..\Videos
	if DstDir=库\下载
		DstDir=%A_MyDocuments%\..\Downloads
	if DstDir=库\图片
		DstDir=%A_MyDocuments%\..\Pictures
	if DstDir=回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}
if % CustomWinClass="WorkerW" or CustomWinClass="Progman" ;如果当前激活窗口桌面
	DstDir=%A_Desktop%
if % CustomWinClass="Shell_TrayWnd" ;如果当前激活窗口为任务栏
{
	MsgBox 无法从任务栏新建文件
	Exit
}
if % CustomWinClass="TTOTAL_CMD" ;如果当前激活窗口为TC
{
	ClipSaved := ClipboardAll   ; 把剪贴板的所有内容保存到您选择的变量中.
	; ... 这里临时使用剪贴板, 例如使用 Transform Unicode 粘贴 Unicode 文本 ...
	PostMessage,1075,332,0,,ahk_class TTOTAL_CMD ;把焦点移到来源窗口的地址栏
	PostMessage,1075,2029,0,,ahk_class TTOTAL_CMD ;获取路径
	sleep 80
	DstDir= % Clipboard
	Clipboard := ClipSaved   ; 恢复剪贴板为原来的内容. 注意这里使用 Clipboard (不是 ClipboardAll).
	ClipSaved =   ; 在原来的剪贴板含大量内容时释放内存.
	if DstDir=\\我的文档
		DstDir=%A_MyDocuments%
	if DstDir=\\桌面
		DstDir=%A_Desktop%
	if DstDir=\\回收站
	{
		MsgBox 无法从回收站中新建文件
		Exit
	}
}

if DstDir=
{
	msgbox 无法从当前窗口新建文件
	Exit
}
if InStr(FileExist(DstDir), "D")
{
	File=%DstDir%\%NewFileName%.%ExtName%
	IfExist, %File%
	{
		Loop
		{
			File=%DstDir%\%NewFileName%_(%A_Index%).%ExtName%
			If !FileExist( File )
			{
				break
			}
		}
	}
	FileCopy, %ShellNew%\%TemplateFileName%.%ExtName%, %File%, 0
}
else
	msgbox 无法从当前窗口新建文件
	PostMessage,1075,540,0,,ahk_class TTOTAL_CMD ;刷新TC来源窗口
Return

Return
/*
    功能：QuickZ在加载的时候执行此函数
*/
Global_Init()
{
    Global VimD
}

/*
    功能：每次切换模式的时候执行此函数
*/
Global_ChangeMode()
{
    Global VimD
}

/*
    功能：按下热键后，热键对应的功能执行前，会运行此函数
    * 默认返回False，功能正常执行。
    * 如果返回True，功能不会执行。
    可以利用这个函数设置自动判断模式
*/
Global_ActionBefore()
{
    Global VimD
}

/*
    功能：热键对应的功能执行后，会运行此函数。
    函数不需要返回值
    可以利用这个函数来做状态提醒
*/
Global_ActionAfter()
{
    Global VimD
}

/*
    功能：热键提醒，用于提示当前有效热键
    QuickZ会传递当前有效热键列表到此函数中。所以需要预留两个参数
    aTemp - 当前热键缓存
    aMore - 符合当前热键缓存的更多热键
*/
Global_Show(aTemp, aMore)
{
    Global VimD
}

Return
/*
    功能：QuickZ在加载的时候执行此函数
*/
explorer_Init()
{
    Global VimD
}

/*
    功能：每次切换模式的时候执行此函数
*/
explorer_ChangeMode()
{
    Global VimD
}

/*
    功能：按下热键后，热键对应的功能执行前，会运行此函数
    * 默认返回False，功能正常执行。
    * 如果返回True，功能不会执行。
    可以利用这个函数设置自动判断模式
*/
explorer_ActionBefore()
{
    Global VimD
}

/*
    功能：热键对应的功能执行后，会运行此函数。
    函数不需要返回值
    可以利用这个函数来做状态提醒
*/
explorer_ActionAfter()
{
    Global VimD
}

/*
    功能：热键提醒，用于提示当前有效热键
    QuickZ会传递当前有效热键列表到此函数中。所以需要预留两个参数
    aTemp - 当前热键缓存
    aMore - 符合当前热键缓存的更多热键
*/
explorer_Show(aTemp, aMore)
{
    Global VimD
}

Return
/*
    功能：QuickZ在加载的时候执行此函数
*/
TOTALCMD_Init()
{
    Global VimD
}

/*
    功能：每次切换模式的时候执行此函数
*/
TOTALCMD_ChangeMode()
{
    Global VimD
}

/*
    功能：按下热键后，热键对应的功能执行前，会运行此函数
    * 默认返回False，功能正常执行。
    * 如果返回True，功能不会执行。
    可以利用这个函数设置自动判断模式
*/
TOTALCMD_ActionBefore()
{
    Global VimD
}

/*
    功能：热键对应的功能执行后，会运行此函数。
    函数不需要返回值
    可以利用这个函数来做状态提醒
*/
TOTALCMD_ActionAfter()
{
    Global VimD
}

/*
    功能：热键提醒，用于提示当前有效热键
    QuickZ会传递当前有效热键列表到此函数中。所以需要预留两个参数
    aTemp - 当前热键缓存
    aMore - 符合当前热键缓存的更多热键
*/
TOTALCMD_Show(aTemp, aMore)
{
    Global VimD
}

Return
