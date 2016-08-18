/*
Filter=TestFunc
Tips=测试功能感觉不错
Author=Array
Version=0.1
*/

TestFunc()
{
    If WinActive("ahk_class Vim")
        return True
}

