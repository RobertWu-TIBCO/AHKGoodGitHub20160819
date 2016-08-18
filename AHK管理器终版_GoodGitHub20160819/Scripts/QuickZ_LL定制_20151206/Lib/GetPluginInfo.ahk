/*
    Function: GetPluginInfo
        此函数用于获取插件的注释作为信息。

    Parameters:
        aPath - 需要获取插件信息的路径

    Author: Array
    
    Version:  0.3
    
    History:
              0.3 移除键名的限定，只要是 key = value 的格式都支持。
              0.2 默认支持INI格式的注释，原先支持标准注释的函数修改为 GetPluginInfoM
              0.1 初始化 

    Return: 
        object - 成功返回对象
        False  - 失败返回False

    Example:
        (Start Code)
        ; INI格式注释
        for i , k in GetPluginInfo(A_ScriptDir "\Test.ahk")
            msgbox % i "`n" k
        ; 标准注释
        for i , k in GetPluginInfoM(A_ScriptFullPath)
            msgbox % i "`n" k
        (End Code)
*/

GetPluginInfo(aPath)
{
    FileRead, iText, %aPath%
    If RegExMatch(iText, "ms)/\*.*?\*/", Comment)
    {
        objPlugin := {}
        /*
            ,"Plugin": ""
            ,"Author":""
            ,"Version":""
            ,"Info":""}
        */
        Loop, Parse, Comment, `n, `r
        {
            strField := A_LoopField
            If RegExMatch(strField, "/?\*/?")
                Continue
            Key := RegExReplace(strField, "(\s|=.*)")
            If Strlen(Key) ; || objPlugin.HasKey(Key)
                objPlugin[Key] := RegExReplace(strField, "^[^=]*=")
        }
        Return objPlugin
    }
    Return False
}

GetPluginInfoM(aPath)
{
    If FileExist(aPath)
        FileRead, iText, %aPath%
    Else
        iText := aPath
    If RegExMatch(iText, "ms)/\*.*?\*/", Comment)
    {
        IsEnd := False
        IsContinue := False
        PluginInfo := {}
        PluginKeyword := {"Func"   : "函数 function"
                         ,"Author" : "作者 Author"
                         ,"Param"  : "参数 Parameters"
                         ,"Return" : "返回 Return"
                         ,"Example": "例子 Example"
                         ,"Author" : "作者 Author"
                         ,"Version": "版本 Version"}
        Loop, Parse, Comment, `n, `r
        {
            ;If (A_LoopField = "/*") || (A_LoopField = "*/")
            If RegExMatch(A_LoopField, "^[\s\t]*/\*[\s\t]*$") || RegExMatch(A_LoopField, "^[\s\t]*\*/[\s\t]*$")
                Continue
            iField := A_LoopField
            PluginInfo.All .= iField "`n"
            For kw, string in PluginKeyword
            {
                If _InStrKeyword(iField, string)
                {
                    ThisKw := kw
                    IsEnd := False
                    IsContinue := True
                    PluginInfo[ThisKw] .= iField "`n"
                    Break
                }
            }
            If IsContinue
            {
                IsContinue := False
                Continue
            }
            If Strlen(PluginInfo[ThisKw]) && !IsEnd
            {
                If !Strlen(Trim(iField, "`r`n`s"))
                    IsEnd := True
                Else
                    PluginInfo[ThisKw] .= iField "`n"
            }
        }
        Return PluginInfo
    }
    Return False
}

GetPluginInfo_Cut(aText)
{
    IsContinue := True
    Loop, Parse, aText, `n, `r
    {
        ThisLine := A_LoopField
        If RegExMatch(A_LoopField, "^[\s\t]*\*/[\s\t]*$")
        {
            If IsContinue
            {
                IsContinue := False
                Continue
            }
            Else
            {
                newText .= ThisLine "`n"
                Break
            }
        }
        If IsContinue
            Continue
        newText .= ThisLine "`n"
    }
    Return newText
}

_InStrKeyword(strField, strKeyword)
{
    IsKeyword := False
    StringSplit, arrOut, strKeyword, %A_Space%
    Loop % arrOut0
    {
        If (InStr(Trim(strField), arrOut%A_Index% ":") = 1)
        {
            IsKeyword := True
            Break
        }
    }
    Return IsKeyword
}
