/*
    Function: QZ_UpdateCode()
        保存Items中的代码到 Lib\QZ_Codes.ahk
*/
QZ_UpdateCode()
{
    /*
    SetTimer, __UpdateCode, -1  ; 使用SetTimer执行。
    Return
    __UpdateCode:
      _QZ_UpdateCode()
    Return
}
_QZ_UpdateCode()
{
    */
    Global gQZConfig
    FileEncoding, UTF-8
    strCode := "Return`r`n"
    codePath := A_ScriptDir "\Lib\QZ_Codes.ahk"
    FileDelete, %codePath%
    For UUID , Obj IN gQZConfig.Items
    {
        If Obj.Options.CodeMode ; 如果为代码模式，保存代码文本到lib\QZ_Codes.ahk中
        {
            strCode .= UUID ":`n" 
            strCode .= "`;" obj.Name "`n"
            strCode .= obj.Code "`n"
            strCode .= "Return`n"
        }
    } 
    Loop % gQZConfig.VIMD.MaxIndex()
    {
        Obj := gQZConfig.VIMD[A_Index]
        strCode .= obj.Code "`n"
        strCode .= "Return`n"
    }
    FileAppend, %strCode%, %codePath%
}
