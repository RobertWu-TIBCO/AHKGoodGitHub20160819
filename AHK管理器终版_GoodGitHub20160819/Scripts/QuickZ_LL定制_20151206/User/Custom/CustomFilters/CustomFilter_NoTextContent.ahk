/*
Filter=CustomFilter_NoTextContent
Tips=此函数对空文本返回true
Author=LL
Version=0.1
*/

CustomFilter_NoTextContent()
{	
	Global gMenuZ
	TextSel =% gMenuZ.Data.text
	If % StrLen(TextSel)
		NoTextContent := false
	else
		NoTextContent := true
	Return NoTextContent
}
