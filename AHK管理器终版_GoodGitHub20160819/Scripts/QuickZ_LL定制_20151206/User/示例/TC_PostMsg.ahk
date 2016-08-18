/*
Plugin=TC_PostMsg
Name1=发送TC消息
Command1=
Param1={TC_PostMsg:0}
Label=TC_PostMsg
API=TC_PostMsg
Tips=发送TC消息
Author=Array
Version=0.1
*/

/*
    函数: TC_PostMsg
        发送消息到TC中。
        消息列表可以通过在TC界面的命令行内输入：
        cm_CommandBrowser
        打开"浏览命令界面"， 序号列的数字就是对应的消息

    参数: 纯数字的消息，如3001 代表"新建标签"
    
    返回: 无
*/

TC_PostMsg(aParam)
{
    Global TCData
    If RegExMatch(aParam, "^\d+$")
    {
        TCData.SendPos := aParam
    }
    Else If RegExMatch(aParam, "i)^{TC_PostMsg:(\d+)}", Match)
    {
        TCData.SendPos := Match1
    }
    aNum := TCData.SendPos
    PostMessage 1075, %aNum%, 0, , AHK_CLASS TTOTAL_CMD
}
