/*
Plugin=CustomFunction_Text2QRCode
Name1=文本生成二维码
Command1=CustomFunction_Text2QRCode
Author=Array
Version=0.1
*/

CustomFunction_Text2QRCode()
{
    global f
    GUI,QRCode:Destroy
    GUI,QRCode:Add,Pic,x20 y20 w500 h-1 hwndhimage,% f:=CustomFunction_GEN_QR_CODE(Substr(QZData("Text"),1,850))
    GUI,QRCode:Add,Text,x20 y542 h24,按Esc关闭                                   点击图片可显示源文本
    GUI,QRCode:Add,Button,x420 y540 w100 h24 gQZ_QRCode_SaveAs,另存为(&S)
    GUI,QRCode:Show,w540 h580, 文本生成二维码
    ;======函数中的以下部分提供点击图片提示源文本的功能======
    SourceText:=CustomFunction_TextEscaping(QZData("text"))
    ;~ ScriptContent=
    ScriptContent=%ScriptContent%`nMenu,Tray,Icon, %A_ScriptDir%\User\Custom\CustomIcons\CustomIcon_Text_QRCode.ico ;图标放在托盘颜色太淡，以后再换一个
    ScriptContent=%ScriptContent%`nMenu, Tray, Tip, 文本生成二维码
    ScriptContent=%ScriptContent%`n#ifWinActive,文本生成二维码
    ScriptContent=%ScriptContent%`n~Esc::goto AutoExitApp
    ScriptContent=%ScriptContent%`n~LButton::`nMouseGetPos, OutputVarX, OutputVarY, OutputVarWin, OutputVarControl
    ScriptContent=%ScriptContent%`nif `% OutputVarControl="Static1"
    ScriptContent=%ScriptContent%`n{
    ScriptContent=%ScriptContent%`n    ToolTip,%SourceText%
    ScriptContent=%ScriptContent%`n    SetTimer, RemoveQRCodeTextTip, 2000
    ScriptContent=%ScriptContent%`n}
    ScriptContent=%ScriptContent%`nelse
    ScriptContent=%ScriptContent%`n    goto AutoExitApp
    ScriptContent=%ScriptContent%`nreturn
    ScriptContent=%ScriptContent%`nAutoExitApp:
    ScriptContent=%ScriptContent%`nsleep 500
    ScriptContent=%ScriptContent%`nIfWinNotExist 文本生成二维码
    ScriptContent=%ScriptContent%`n    ExitApp
    ScriptContent=%ScriptContent%`nreturn
    ScriptContent=%ScriptContent%`n#ifWinNotExist,文本生成二维码
    ScriptContent=%ScriptContent%`n~LButton::ExitApp
    ScriptContent=%ScriptContent%`nRemoveQRCodeTextTip:
    ScriptContent=%ScriptContent%`nSetTimer, RemoveQRCodeTextTip, Off
    ScriptContent=%ScriptContent%`nToolTip
    ScriptContent=%ScriptContent%`nreturn
    CustomFunction_PipeRun(ScriptContent)
}

QRCodeGUIEscape:
  GUI,QRCode:Destroy
  FileDelete, % f
return

QZ_QRCode_SaveAs:
  Fileselectfile,nf,s16,,另存为,PNG图片(*.png)
  If not strlen(nf)
    return
  nf := RegExMatch(nf,"i)\.png") ? nf : nf ".png"
  FileCopy,%f%,%nf%,1
return

CustomFunction_GEN_QR_CODE(string,file="")
{
  sFile := strlen(file) ? file : A_Temp "\" A_NowUTC ".png"
  SplitPath, A_LineFile, , QRCode_Path
  DllCall( QRCode_Path "\quricol32.dll\GeneratePNG","str", sFile , "str", string, "int", 4, "int", 2, "int", 0)
  Return sFile
}