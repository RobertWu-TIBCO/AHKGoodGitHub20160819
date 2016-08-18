/*
	Title: 配置文件生成
        此文件维护配置文件中的菜单项、筛选器对象的生成
        
        通过此文件，你可以了解配置文件数据组成和格式。并更好地调用
        
    About: 注意
        
        配置文件为Json格式。
        
        关于Json，你可以在这里了解更多 <http://www.json.org/json-zh.html>
*/

/*
    Function: QZ_CreateConfig
        生成默认的Json配置文件

    Returns: 
        返回Json对象

    Remarks: 
        需要 Class_Json 库
*/

QZ_CreateConfig()
{
    objConfig := Json.Load("{}")
    objConfig.setting := {"global":{}
        ,"menuz":{"Keyword":[]}
        ,"vimd":{}
        ,"gesture":{}
        ,"userenv":{}}
    objConfig.gesture := []
    objConfig.vimd := []
    objConfig.menuz := []
    objConfig.Items := []
    objConfig.Filters := []
    Return objConfig
}

/*
    Function:  QZ_CreateConfig_Item()
        用于返回一个Item格式的对象，用于理解Item的数据格式

    Returns: 
        返回一个Json对象

    Remarks:
        Name - 保存菜单项的名称
        Command - 执行的命令，可以是执行文件路径，也有可以是内置的命令
        Param - 对应命令的参数
        Tips - 备注说明
        Code - AHK代码
        Options.Workingdir - 运行工作目录
        Options.CodeMode - 使用代码模式
        Options.category - 自定义类别名。如"TC相关"，用于快速浏览项。
        Options.RunState - 运行状态:0:正常/1:最大化/2:最小化/3:隐藏/a:管理员运行

*/
QZ_CreateConfig_Item()
{
    objItem := { "Name": ""
        ,"Command":""
        ,"Param":""
        ,"Tips":""
        ,"Code":""
        ,"Options":{"WorkingDir":""
            ,"CodeMode":0
            ,"category":""
            ,"IsGroup":""
            ,"RunState":""}}
    Return objItem
}

/*
    Function: QZ_CreateConfig_Filter()
        用于返回一个筛选器对象，用于理解筛选器的数据格式

    Returns: 
        返回一个Json对象

    Remarks:
        name - 表示筛选器的名称
        Special - 特殊条件。0表示不使用，1表示任意文件，2表示任意文本，3表示多文件
        FileExt  - 监控文件后缀名，如ahk;json
        WinClass - 判断当前Class, method有四种方法。分别是
                   > 0 表示不使用，判断过程中忽略Class类
                   > 1 表示包含neelde关键字，有关键字筛选器才有效
                   > 2 表示排除neelde关键字，没有关键字筛选器才有效
                   > 3 表示使用正则匹配Match关键字,正则无效则筛选器无效
        TextRegex - 文本正则式，需要正则的基本概念。
        Keyword  - 与热键关联在一起的关键词，不同热键通过设置关键词控制菜单出现。
        Function - 关联到某个函数中，函数返回True表示有效，返回False表示无效
        FileMulti - 多文件，ahk;json
        FileName - 监控文件名，如note，代表文件名中含有"note"
        FileDir  - 监控文件目录名，如 dir，代表当前选中所在文件夹名中必须有 "dir"
        WinExe - 与WinClass 类似，但只是监控当前程序名，如 Notepad.exe
        WinTitle - 监控当前标题, 如 记事本
        WinControl - 监控当前控件名，如 Edit1
*/

QZ_CreateConfig_Filter()
{
    objFilter := {"Name": ""  
        ,"Special":0
        ,"FileExt":{"method":0,"Match":""}
        ,"WinClass":{}
        ,"TextRegex":{}
        ,"Keyword":""
        ,"Function":""
        ,"FileMulti":{} 
        ,"FileName":{}
        ,"FileDir":{}
        ,"WinExe":{}
        ,"WinTitle":{}
        ,"WinControl":{}}
    Return objFilter
}

/*
    Function: QZ_CreateConfig_MenuItem
        生成菜单项

    Parameters: 
        无

    Returns: 
        返回一个对象

    Remarks: 
        UUID - Items中的索引uuid
        Filter - 关联到此菜单项的筛选器
        SubItem - 分组的子对象
        Options.IconFile - 图标文件
        Options.IconNumber - 图标序号
        Options.Bold - 在菜单中显示为粗体
        Options.ColorFore - 菜单项中的文本颜色
        Options.ColorBack - 菜单项中的背景颜色
        Options.Hide - 控制菜单项是否隐藏
        Options.Disable - 控制菜单项禁用
        Options.FilterLogic - 筛选器的逻辑：0代表与，1代表或
        Options.Type - 此项作为普通菜单项(0)/子菜单(1)/或者分组(2)
*/

QZ_CreateConfig_MenuItem(IsSep:=False)
{
    objMenuItem := {}
    objMenuItem["ID"] := ""
    objMenuItem["Filter"] := []
    objMenuItem["Options"] := {}
    objMenuItem.Options["Hide"] := 0
    objMenuItem.Options["Disable"] := 0
    objMenuItem.Options["FilterLogic"] := 0
    If !IsSep
    {
        objMenuItem["uuid"] := ""
        objMenuItem["SubItem"] := []
        objMenuItem.Options["IconSize"] := 0
        objMenuItem.Options["IconFile"] := ""
        objMenuItem.Options["IconNumber"] := 0
        objMenuItem.Options["Bold"] := 0
        objMenuItem.Options["Type"] := 0
        objMenuItem.Options["ColorBack"] := ""
        objMenuItem.Options["ColorFore"] := ""
    }
    Return objMenuItem
}

/*
    Name - 程序别名
    WinClass - 程序的ahk class值
    WinTitle - 程序标题
    WinExe - 程序文件名
    TimeOut - 超时时间，默认为0
    MaxCount - 重复运行次数
    DefaultMode - 默认模式
    BeforeActionDo - 每次热键判定之前都会运行此函数
    AfterActionDo  - 每次热键判断之后都会运行此函数
    Code - 保存代码
    Modes - 对象，保存模式对象列表
*/

QZ_CreateConfig_VimWin()
{
    objWin := {}
    objWin["Name"]     := ""
    objWin["WinClass"] := ""
    objWin["WinExe"]   := ""
    objWin["Code"] := ""
    objWin["Modes"] := {}
    objWin.Options := {}
    objWin.Options["TimeOut"]  := 0
    objWin.Options["MaxCount"] := 0
    objWin.Options["Disable"]  := 0
    objWin.Options["DefaultMode"] := ""
    objWin.Options["OnInit"]      := ""
    objWin.Options["OnShow"]      := ""
    objWin.Options["OnActionBefore"] := ""
    objWin.Options["OnActionAfter"]  := ""
    objWin.Options["OnChangeMode"]   := ""
    Return objWin
}

QZ_CreateConfig_VimMode()
{
    objMode := {}
    objMode["Name"] := ""
    objMode["Maps"] := {}
    objMode.Options := {}
    objMode.Options["Disable"] := 0
    objMode.Options["IconFile"] := ""
    objMode.Options["IconNumber"] := 0
    Return objMode
}

QZ_CreateConfig_VimKey()
{
    objKey := {}
    objKey["Key"]  := ""
    objKey["UUID"] := ""
    objKey["Disable"] := 0
    objKey["Tips"] := ""
    Return objKey
}
