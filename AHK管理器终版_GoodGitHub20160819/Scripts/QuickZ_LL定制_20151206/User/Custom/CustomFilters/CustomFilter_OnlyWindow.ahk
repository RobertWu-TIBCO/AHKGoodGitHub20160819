/*
Filter=CustomFilter_OnlyWindow
Tips=此函数当仅选中窗口时返回true
Author=LL
Version=0.1
*/

CustomFilter_OnlyWindow()
{	
	Global gMenuZ
	TextSelected =% gMenuZ.Data.text
	FileList =% gMenuZ.Data.files
	CurrentWindow := gMenuZ.Data.winclass
	OnlyWindow := true
	If % StrLen(FileList) or StrLen(TextSelected)
		OnlyWindow := false
	If % CurrentWindow="TTOTAL_CMD" and !StrLen(TextSelected)
		OnlyWindow := true
	Return OnlyWindow
}
