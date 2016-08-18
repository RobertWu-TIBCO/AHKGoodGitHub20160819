cando_msdn搜索:
candysel=%candysel%
funct_string=https://www.bing.com/search?q=%candysel%+msdn
;~ https://www.bing.com/search?q=
;MsgBox %funct_string%
a := URLDownloadToVar(funct_string,"utf-8")
;Clipboard=%a%
RegExmatch(a,"m)(*ANYCRLF).*href\=""(https://msdn.*\(v=vs.85\).aspx)"".*",m)   ;匹配下载地址的正则
dizhi:=% m1
;MsgBox %dizhi%
if dizhi=
{
run https://social.msdn.microsoft.com/search/en-us/windows?query=%candysel%&Refinement=183
return
}
else
run %dizhi%
return
URLDownloadToVar(url, Encoding = "",Method="GET",postData=""){ ;网址，编码,请求方式，post数据
    hObject:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
    if Method = GET
    {
        hObject.Open("GET",url)
        Try
            hObject.Send()
        catch e
            return -1
    }
    else if Method = POST
    {
        hObject.Open("POST",url,False)
        hObject.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        Try
            hObject.Send(postData)
        catch e
            return -1
    }
    if Encoding
    {
        oADO := ComObjCreate("adodb.stream")
        oADO.Type := 1
        oADO.Mode := 3
        oADO.Open()
        oADO.Write(hObject.ResponseBody)
        oADO.Position := 0
        oADO.Type := 2
        oADO.Charset := Encoding
        return oADO.ReadText(), oADO.Close()
    }
    return hObject.ResponseText
}