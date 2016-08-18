/*
Filter=CustomFilter_FileType_PotPlayer
Tips=此函数当所选仅包含PotPlayer视频文件时返回true
Author=LL
Version=0.1
*/

CustomFilter_FileType_PotPlayer()
{	
    ExtNameSupported=folder avi wmv wmp wm asf mpg mpeg mpe m1v m2v mpv2 mp2v dat ts tp tpr trp vob ifo ogm ogv mp4 m4v m4p m4b 3gp 3gpp 3g2 3gp2 mkv rm ram rmvb rpm flv swf mov qt amr nsv dpg m2ts m2t mts dvr-ms k3g skm evo nsr amv divx webm wav wma mpa mp2 m1a m2a mp3 ogg m4a aac mka ra flac ape mpc mod ac3 eac3 dts dtshd wv tak asx m3u m3u8 pls wvx wax wmx cue mpls mpl dpl
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
				continue
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