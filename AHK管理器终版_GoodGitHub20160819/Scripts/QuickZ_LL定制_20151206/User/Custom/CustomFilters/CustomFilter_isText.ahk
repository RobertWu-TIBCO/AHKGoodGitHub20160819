/*
Filter=CustomFilter_isText
Tips=此函数对任意文本返回true
Author=LL
Version=0.1
*/

CustomFilter_isText()
{	
	Global gMenuZ
	TextSel=% gMenuZ.Data.text
	If % StrLen(TextSel)
		isText:=True
	else
		isText:=False
	Return isText
}