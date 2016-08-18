/*
Filter=CustomFilter_OnlyFolder
Tips=此函数当所选仅包含文件夹返回true
Author=LL
Version=0.1
*/

CustomFilter_OnlyFolder()
{	
	Global gMenuZ
	FileList=% gMenuZ.Data.files
	;~ IfInString,FileList,`n
	OnlyFolder:=true ;先假定仅包含文件夹
	{
		Loop, Parse, FileList, `n, `r
		{
			FileAttrib:=FileExist(A_LoopField)
			IfNotInString,FileAttrib,D
			{
				OnlyFolder:=false
				break
			}
		}
	}
	Return OnlyFolder
}