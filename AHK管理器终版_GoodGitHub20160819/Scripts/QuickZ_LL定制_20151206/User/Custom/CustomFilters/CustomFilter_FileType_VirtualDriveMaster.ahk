/*
Filter=CustomFilter_FileType_VirtualDriveMaster
Tips=此函数当所选仅包含软媒虚拟光驱支持的镜像时返回true
Author=LL
Version=0.1
*/

CustomFilter_FileType_VirtualDriveMaster()
{	
    ExtNameSupported=iso;udf;cue;nrg;mds;ccd;bin
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