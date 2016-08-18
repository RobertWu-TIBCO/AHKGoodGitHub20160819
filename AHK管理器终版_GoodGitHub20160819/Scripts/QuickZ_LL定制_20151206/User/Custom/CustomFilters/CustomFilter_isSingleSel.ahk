/*
Filter=CustomFilter_isSingleSel
Tips=此函数对任意单选返回true
Author=LL
Version=0.1
*/

CustomFilter_isSingleSel()
{
	Global gMenuZ
	FileList=% gMenuZ.Data.files
	IfInString,FileList,`n
		isSingleSel:=false
	else
		isSingleSel:=true
	Return isSingleSel
}