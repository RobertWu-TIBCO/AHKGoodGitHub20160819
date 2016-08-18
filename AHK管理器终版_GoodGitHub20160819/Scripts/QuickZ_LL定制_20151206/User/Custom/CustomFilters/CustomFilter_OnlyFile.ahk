/*
Filter=CustomFilter_OnlyFile
Tips=此函数当不包含文件夹返回true
Author=LL
Version=0.1
*/

CustomFilter_OnlyFile()
{	
	Global gMenuZ
	FileList=% gMenuZ.Data.files
	;~ IfInString,FileList,`n
	OnlyFile:=true ;先假定不包含文件
	{
		Loop, Parse, FileList, `n, `r
		{
			FileAttrib:=FileExist(A_LoopField)
			IfInString,FileAttrib,D
			{
				OnlyFile:=false
				break
			}
		}
	}
	Return OnlyFile
}