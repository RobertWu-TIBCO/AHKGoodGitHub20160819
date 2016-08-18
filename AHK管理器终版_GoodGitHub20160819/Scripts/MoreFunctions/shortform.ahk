#SingleInstance force
Menu, Tray, Icon, shortform.ico
::ash::
edit
return

::rsh::
reload
return

;输入 appinn，输出小众软件地址：
::appinn::
text = http://www.appinn.com
clipboard = %text%
Send ^v
return

;输入 weibo，输出小众软件微博地址：
::weibo::
text = http://weibo.com/appinncom
clipboard = %text%
Send ^v
return
::ah8::
text = http://weibo.com/appinncom
clipboard = %text%
Send ^v
return
::linend::
send {End}
send +{Home}
send ^c 
return

::pad::F:\Program Files\Notepad++\notepad++.exe