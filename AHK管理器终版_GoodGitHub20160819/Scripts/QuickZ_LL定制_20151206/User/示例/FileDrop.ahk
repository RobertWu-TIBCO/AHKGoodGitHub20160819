/*
Label={FileDrop}
Tips=运行命令并拖动选中的文件进程序窗口
Author=Array
Version=0.1
*/

FileDrop(aParam:="")
{
    ;msgbox % gMenuZ.RunPID "`n" aParam
    Global objRunAndDrop
    If RegExMatch(aParam, "(\d+)", Match)
    objRunAndDrop := {Time:Match1, Files:QZData("Files")}
    Settimer, LookRunPID, 50
}

LookRunPID()
{
    Global objRunAndDrop, gQZEngine
    If gQZEngine.RunPID
    {
        Settimer, LookRunPID, off
        Sleep % objRunAndDrop.Time
        WinTitle := "ahk_PID " gQZEngine.RunPID
        ;WinWaitActive, %WinTitle% ,,5
        WinActivate, %WinTitle%
        x:=x ? x : 0
        y:=y ? y : 0
        ;run notepad.exe , , , pid
        ;WinTitle := "ahk_PID " pid
        PostMessage, 0x233, FileDrop_Hdrop(objRunAndDrop.files,x,y), 0, , %WinTitle%
    }
}

FileDrop_Hdrop(fnames,x=0,y=0)
{
	characterSize := A_IsUnicode ? 2 : 1
	fns:=RegExReplace(fnames,"\n$")
	fns:=RegExReplace(fns,"^\n")
	hDrop:=DllCall("GlobalAlloc","UInt",0x42,"UInt",20+(StrLen(fns)*characterSize)+characterSize*2)
	p:=DllCall("GlobalLock","UInt",hDrop)
	NumPut(20, p+0)  ;offset
	NumPut(x,  p+4)  ;pt.x
	NumPut(y,  p+8)  ;pt.y
	NumPut(0,  p+12) ;fNC
	NumPut(A_IsUnicode ? 1 : 0,  p+16) ;fWide
	p2:=p+20
	Loop,Parse,fns,`n,`r
	{
		DllCall("RtlMoveMemory","UInt",p2,"Str",A_LoopField,"UInt",StrLen(A_LoopField)*characterSize)
		p2+=StrLen(A_LoopField)*characterSize + characterSize
	}
	DllCall("GlobalUnlock","UInt",hDrop)
	Return hDrop
}
