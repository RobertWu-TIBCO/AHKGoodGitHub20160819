/*
Filter=CustomFilter_isFile
Tips=此函数对任意文件或文件夹时返回true
Author=LL
Version=0.1
*/

CustomFilter_isFile() ;此函数对任意文件或文件夹返回true
{	
	Global gMenuZ
	FileList=% gMenuZ.Data.files
	If % StrLen(FileList)
		isFile:=True
	else
		isFile:=False
	Return isFile
}