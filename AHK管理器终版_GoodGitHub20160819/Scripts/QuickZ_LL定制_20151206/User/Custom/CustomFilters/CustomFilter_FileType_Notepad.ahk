/*
Filter=CustomFilter_FileType_Notepad
Tips=此函数当所选仅包含文本文件时返回true
Author=LL
Version=0.1
*/

CustomFilter_FileType_Notepad()
{	
    ExtNameSupported=NoExt;txt;log;ini;inf;java;cs;pas;pp;inc;as;mx;ada;ads;adb;asm;asp;au3;bash;sh;bsh;csh;bat;cmd;nt;c;ml;mli;sml;thy;cmake;cbl;cbd;cdb;cdc;cob;litcoffee;h;hpp;hxx;cpp;cxx;cc;css;d;diff;patch;f;for;f90;f95;f2k;hs;lhs;las;html;htm;shtml;shtm;xht;hta;url;iss;js;jsm;jsp;kix;lsp;lisp;bat;xml;reg;cfg;aau;ass;ssa;srt;json;
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