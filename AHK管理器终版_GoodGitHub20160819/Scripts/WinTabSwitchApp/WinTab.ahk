#SingleInstance force  ; force reloading
Menu, Tray, Icon, firefox.ico

#Persistent
DetectHiddenText, On
SetTitleMatchMode,2
;~ 2: 窗口标题的某个位置必须包含WinTitle。.
main:
WinGetClass, class, A
;MsgBox, The active window's class is "%class%".
WinTitle=ahk_class %class% ;filelocator has different winclass each time
WinGet, winList,List,%WinTitle%
wins:=[]
Loop,%winList%
{
    this_id=% winList%A_Index%
    WinGetTitle,this_title,ahk_id %this_id%
    wins.Insert({index:A_Index,title:this_title,id:this_id})
}
;MsgBox,% wins.Length()
WinGetTitle,this_title,ahk_id %this_id%
for each,win in wins
{
tid:=win.id
tindex:=win.index
ttitle:=win.title
;MsgBox, The active window's class is "%class%" for, index is %tindex%, id is %tid%, titile is %ttitle%
gosub bind
;牛掰! 就这么写好了 !!
KeyWait, LWin
KeyWait, Tab
}
return

bind:
WinActivate,ahk_id %tid%
return

#Tab::
gosub main
return

::atab::
edit
return