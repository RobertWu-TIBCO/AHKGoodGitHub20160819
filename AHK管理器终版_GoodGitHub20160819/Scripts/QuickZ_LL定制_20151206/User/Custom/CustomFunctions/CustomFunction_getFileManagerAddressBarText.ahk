CustomFunction_getFileManagerAddressBarText(WinClass="")
{
    if WinClass=
        WinGetClass, WinClass, A
    if % WinClass="ExploreWClass" or WinClass="CabinetWClass" ;如果当前激活窗口为资源管理器
    {
        ControlGetText, AddressBarText, ToolbarWindow322,ahk_class %WinClass% ;通过地址栏获取路径
        stringreplace, AddressBarText, AddressBarText, 地址:%A_space%, , All
        if AddressBarText =
            ControlGetText, AddressBarText, Edit1,ahk_class %WinClass%
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
    if % WinClass="WorkerW" or WinClass="Progman" ;如果当前激活窗口为桌面
    {
        AddressBarText=%A_Desktop%
    }
    if % WinClass="Shell_TrayWnd" ;如果当前激活窗口为任务栏
        AddressBarText=
	if % CustomWinClass="TTOTAL_CMD" ;如果当前激活窗口为TC
	{
		PreClipboard := ClipboardAll   ; 把剪贴板的所有内容保存到您选择的变量中.
		; ... 这里临时使用剪贴板, 例如使用 Transform Unicode 粘贴 Unicode 文本 ...
		PostMessage,1075,332,0,,ahk_class TTOTAL_CMD ;把焦点移到来源窗口的地址栏
		PostMessage,1075,2029,0,,ahk_class TTOTAL_CMD ;获取路径
		sleep 80
		AddressBarText= % Clipboard
		Clipboard := PreClipboard   ; 恢复剪贴板为原来的内容. 注意这里使用 Clipboard (不是 ClipboardAll).
		PreClipboard =   ; 在原来的剪贴板含大量内容时释放内存.
		if AddressBarText=\\我的文档
			AddressBarText=%A_MyDocuments%
		if AddressBarText=\\桌面
			AddressBarText=%A_Desktop%
		if AddressBarText=\\回收站
            AddressBarText:="::{645FF040-5081-101B-9F08-00AA002F954E}"
        if AddressBarText=\\计算机\
            AddressBarText:="::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
	}
    Return AddressBarText
}