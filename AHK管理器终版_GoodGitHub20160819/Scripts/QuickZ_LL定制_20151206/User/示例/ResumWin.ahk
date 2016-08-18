/*
API=ResumeWin
Tips=激活选中窗口
Author=Array
Version=0.1
*/

/*
    函数: ResumeWin
        用于激活选中窗口。
        一般配合Send, Click 等命令使用

    使用方式:
        ResumeWin()

*/
ResumeWin()
{
    WinActivate, % "ahk_id " QZData("Hwnd")
}
