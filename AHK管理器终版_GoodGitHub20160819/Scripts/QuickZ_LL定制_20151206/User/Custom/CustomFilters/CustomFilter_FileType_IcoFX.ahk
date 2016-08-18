/*
Filter=CustomFilter_FileType_IcoFX
Tips=此函数当所选仅包含文本文件时返回true
Author=LL
Version=0.1
*/

CustomFilter_FileType_IcoFX()
{	
    ExtNameSupported=ico;icns;bmp;jpg;png;gif;cur;jp2;j2k;ani;exe;dll;ocx;icl;bin;rsc;rsrc;lnk
	;枚举所有支持的文件类型，正常状态下只需要修改筛选函数名以及支持的文件后缀即可（第2行、第8行、第10行）
	Global gMenuZ
	FileList=% gMenuZ.Data.files
	Result:=true ;先假定为真
	;~ IfInString,FileList,`n
	{
		Loop, Parse, FileList, `n, `r
		{
			FileAttrib:=FileExist(A_LoopField)
			IfInString,FileAttrib,D
			{
				Result:=false
				break
			}
            SplitPath, A_LoopField, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
            IfNotInString, ExtNameSupported, %OutExtension%
            {
				Result:=false
				break
            }
		}
	}
	Return Result
}