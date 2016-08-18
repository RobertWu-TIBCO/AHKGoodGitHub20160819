CustomFunction_RunD(ExePath,WinTitle,x=0,y=0,WaitDuration=0)
{ ;格式为RunD(应用程序,应用程序的标题,x,y,等待时间)
	Global gMenuZ
	Run "%ExePath%"
	Sleep,% (WaitDuration="") ? 1000 : WaitDuration
	WinWaitActive, %WinTitle% ,,5
	WinActivate, %WinTitle%
	x:=x ? x : 100
	y:=y ? y : 100
	PostMessage, 0x233, CustomFunction_HDrop(gMenuZ.Data.files,x,y), 0,, %WinTitle%
}