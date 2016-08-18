/*
Plugin=转换为AHK原义文本
Name1=转换为AHK原义文本
Command1=CustomFunction_TextEscaping
Author=LL
Version=0.1
*/

;此函数对获得的文本进行转义，具有特殊作用的符号将被转换为原义的字符。
CustomFunction_TextEscaping(Text)
{
    If Text=
    {
        Text:=QZData("text")
        if Text=
            msgbox 无法获取文本
    }
    Char:="``、" ",、" "%、" ";"
    Loop, Parse, Char, 、
        Text:=RegExReplace(Text, A_LoopField, "``" A_LoopField, OutputVarCount)
    StringReplace, Text, Text, `n, ``n, All
    StringReplace, Text, Text, `r, ``r, All
    StringReplace, Text, Text, `b, ``b, All
    StringReplace, Text, Text, `t, ``t, All
    StringReplace, Text, Text, `v, ``v, All
    StringReplace, Text, Text, `a, ``a, All
    StringReplace, Text, Text, `f, ``f, All
    return Text
}