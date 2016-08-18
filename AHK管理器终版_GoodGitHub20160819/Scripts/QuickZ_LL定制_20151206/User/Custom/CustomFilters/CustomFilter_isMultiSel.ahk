/*
Filter=CustomFilter_isMultiSel
Tips=此函数对任意多选返回true
Author=LL
Version=0.1
*/

CustomFilter_isMultiSel()
{	
	Global gMenuZ
	FileList=% gMenuZ.Data.files
	IfInString,FileList,`n
		isMultiSel:=true
	else
		isMultiSel:=false
	Return isMultiSel
}