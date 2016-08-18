;Msgbox % Language.exit
Class QZLang
{
    Static ModuleMenuZ := "配置菜单(F1)"
    Static ModuleVIMD := "配置热键(F2)"
    Static ModuleGesture := "配置手势(F3)"
    Static ReloadQZ := "保存并重启QZ(F4)"
    Static Rebuild := "检查代码模式和插件(&V)"
    Static ExitQZ := "退出&QuickZ"
    Static ReloadEditor := "重启编辑器(&R)"
    Static ExitEditor := "退出编辑器(&X)"
    Static OpenEditor := "打开编辑器(&E)"
    Static Debug := "调试(&D)"
    Static ListLines := "显示运行内容(&L)"
    Static ShowKey := "显示热键(&S)"
    Static Reload := "重启(&R)"
    Static Suspend := "禁用热键(&S)"
    Static TextExit := "退出"
    Static ButtonOK := "确定(&O)"
    Static ButtonSelect := "选择(&O)"
    Static ButtonClose := "关闭(&C)"
    Static ButtonDelete := "删除(&D)"
    Static ButtonAdd := "添加(&A)"
    Static ButtonModify := "修改(&E)"
    Static ButtonNew := "新建(&N)"
    Static ButtonCopy := "复制(&P)"
    Static ButtonHelp := "帮助(&H)"
    Static ButtonSearch := "搜索(&S)"
    Static ButtonBrowse := "浏览(&B)"
    Static ButtonForceDelete := "永久删除(&X)"
    Static ButtonSearchStop := "中止搜索(&S)"
    Static ButtonClear := "清除图标(&D)"
    Static ButtonAutoIcon := "自动图标(&A)"
    Static ButtonBColor := "背景颜色(&F)"
    Static ButtonTColor := "文字颜色(&T)"
    Static ButtonClearColor := "清除配色(&E)"
    Static ButtonBold := "加粗(&B)"
    Static ButtonClear1 := "清除命令(&D)"
    Static ButtonClear2 := "清除分类(&D)"
    Static ButtonEdit := "编辑(&E)"
    Static ButtonSave := "保存(&S)"
    Static ButtonAddAgain := "保存并添加(&A)"
    Static ButtonManager := "管理(&A)"
    Static ButtonEnv := "变量(&E)"
    Static ButtonInfo := "说明(&H)"
    Static ButtonInsert := "插入(&A)"
    Static browseFile := "浏览文件"
    Static browseFolder := "浏览目录"
    Static NotExist := "不存在!"
    Static TextDoubleClick := "注：双击可直接选择"
    Static TitleEditor := "编辑器"
    Static WinEditor := "窗口编辑"
    Static ModeEditor := "模式编辑"
    Static AddKeyMap := "添加热键"
    Static TitleFilterMgr := "筛选器管理"

    Static ButtonAddTo := "<-添加(&A)"
    Static ButtonRemove := "移除(&R)->"
    Static ButtonMore := "更多(&M)>>"
    Static ButtonLess := "<<隐藏(&M)"
    Static ButtonDeleteForce := "完全删除"

    Static SuffixCopy := "-副本"
    ; 主编辑器
    Static TB_AddItem := "添加菜单"
    Static TB_AddSubItem := "添加分组(子菜单)"
    Static TB_AddSep := "添加分隔符"
    Static TB_ModifyItem := "编辑菜单"
    Static TB_DeleteItem := "删除菜单"
    Static TB_MoveUp := "向上移动"
    Static TB_MoveDown := "向下移动"
    Static TB_Hide := "隐藏菜单项"
    Static TB_Disable := "禁用菜单项"
    Static TB_AddWin := "添加程序"
    Static TB_AddMode := "添加模式"
    Static TB_Delete2 := "删除程序/模式"
    Static TB_Disable2 := "禁用程序/模式"
    Static TB_AddKey := "添加热键"
    Static TB_ModifyKey := "编辑热键"
    Static TB_DeleteKey := "删除热键"
    Static TB_Import := "导入"
    Static TB_Check := "校验"
    Static TB_IconAndColor := "(风格)设置图标/配色"
    Static TB_Category := "(类别)设置分类"
    Static TB_EditBy := "使用外部编辑器编写代码"
    Static CM_Edit := "编辑(&E)"
    Static CM_Edit2 := "编辑程序(&E)"
    Static CM_Edit3 := "编辑模式(&E)"
    Static CM_Filter := "筛选器(&F)"
    Static CM_Advance := "高级(&A)"
    Static CM_Cut := "剪切(&T)"
    Static CM_Copy := "复制(&C)"
    Static CM_Paste := "粘贴(&V)"
    Static CM_Delete := "删除(&X)"
    Static CM_DeleteKey := "删除热键(&X)"
    Static CM_ModifyKey := "编辑热键(&E)"
    Static CM_property := "属性(&R)"
    Static TextExecute := "可执行文件"
    Static FileSelectExe := "请选择程序"
    Static FileSelectExeFilter := "可执行文件(*.exe)"
    Static TextInsertFile := "文件(&F)"
    Static TextPleaseSelectFile := "请选择文件"
    Static TextInsertDir := "目录(&D)"
    Static TextPleaseSelectDir := "请选择目录"
    Static TextInsertVar := "变量(&V)"
    Static TextRelativePath := "转换为相对路径(&R)"
    Static TextFullPath := "转换为完整路径(&T)"
    Static TextListViewTitle := "热键|功能|状态|说明"
    Static TextListViewTitle2 := "筛选条件|匹配方式|匹配内容"
    Static TextCategoryName := "当前分类:"
    Static TextSelectCategory := "请选择分类(&T):"
    Static TextFunctions := "函数(&F):"
    Static TextMenu16x := "&16x16图标"
    Static TextMenu24x := "&24x24图标"
    Static TextMenu32x := "&32x32图标"

    ; 菜单项编辑器
    Static ItemEditor := "菜单项编辑"
    Static GroupEditor := "菜单分组编辑"
    Static colorful := "配色"
    Static IconSelector := "选择图标"
    Static ItemSelector := "选择菜单项"
    Static TextGroupType := "设置此分组为:"
    Static TextGroupIsSub := "子菜单(&S)"
    Static TextGroupIsSibling := "同级菜单(&F)"
    Static TextItemName := "菜单项名称"
    Static TextGroupName := "菜单分组名称"
    Static TextItemContent := "执行内容"
    Static TextItemRunSetting := "运行设置"
    Static TextName := "名称(&N):"
    Static TextCommand := "命令(&D):"
    Static TextChangeCMD := "更改命令"
    Static TextParam := "参数(&F):"
    Static TextWorkingDir := "目录(&U):"
    Static TextRunmode := "运行状态:"
    Static TextComment := "备注(&T):"
    Static TextIconSearchTip := "查找此路径中的图标(A):"
    Static TextIconDoubleClick := "注：双击可选择图标"
    Static TextEnvTips := "格式：变量=变量值(%已有变量%)"
    Static TextEnvTips2 := "请选择变量(双击或者按确定):"
    Static TextCBUserEnv := "用户变量(&E)"
    Static TextCBInsideEnv := "内置变量(&D)"
    Static TextCBOutsideEnv := "外置变量(&U)"
    Static TextListViewEnv := "变量|值"
    Static TitleEnv := "编辑变量"
    Static TextView := "视图:"
    Static TextViewNormal := "详细信息(&N)"
    Static TextViewList := "平铺列表(&L)"
    Static TextViewSmallIcons := "小图铺(&S)"
    Static TextViewBigIcons := "大图标(&W)"
    Static TextChangeToCode := "切换到AHK代码模式"
    Static TextChangeToNormal := "切换到普通模式"
    Static TextFilePath := "#文件路径"
    Static TextFileDir := "#目录路径"
    Static TextVar := "%变量%"
    Static TextLabel := "{标签}"
    Static TextTools := "@工具"
    Static TextHelp := "?帮助"
    Static CBNormal := "正常(&K)"
    Static CBMax := "最大化(&M)"
    Static CBMin := "最小化(&N)"
    Static CBHide := "隐藏(&H)"
    Static CBAdmin := "管理员权限(&P)"
    Static TextOtherOptions:= "其它选项"
    Static TextHide := "【隐藏】"
    Static TextDisable := "【禁用】"
    Static TextDisable2 := "禁用"
    Static TextEnable := "启用"
    Static ButtonWorkingDir := "浏览(&B)"
    Static TextAll:= "全部"
    Static TextInsideCmds  := "内置命令"
    Static TextUserActions := "用户插件"
    Static TextExistMenus  := "已有菜单"
    Static TextCtrlPanels  := "控制面板"
    Static TextSystemCmds  := "系统命令"
    Static TextSystemDirs  := "常用目录"
    Static TextUtilities   := "实用工具"
    Static TextShellPaths  := "Shell路径"
    Static TextCategory := "类别:"
    Static TextCommandList := "命令列表:"
    Static TextCmdTitle := "名称|命令|参数"
    
    ; 图标选择
    Static bookmark := "收藏夹"
    Static FileSelectIcon := "请选择图标文件"
    Static FileSelectIconFilter := "图标文件(*.ICO; *.CUR; *.ANI; *.EXE; *.DLL; *.CPL; *.SCR; *.PNG)"
    Static FolderSelectIcon := "选择图标所在的文档"
    Static FolderSelectIconFolder := "*%A_ScriptDir%\Icons\"
    Static IconListView := "序号|路径|"
    Static MenuIconBookmarkAdd := "添加到收藏夹(&A)"
    Static MenuIconBookmarkManage := "管理收藏夹(&M)"
    Static ItemEditorShowAdv := "显示高级设置"
    Static ItemEditorHideAdv := "隐藏高级设置"
    Static ItemEditorScrollTop := "回到顶部"
    Static IconBookMarkBreak := "-----以上为内置常用图标-----"
    ; 筛选器
    Static FilterEditor := "筛选器编辑器"
    Static FilterName := "筛选器名称"
    Static FilterItem := "单项(&I)"
    Static FilterMenu := "智能菜单(&M)"
    Static FilterVimd := "Vim热键(&V)"
    Static FilterGes := "简单手势(&G)"
    Static FilterLauncher := "启动器(&L)"
    Static FilterOption := " |包含|排除|正则"
    Static FilterWinClassMgr := "管理匹配窗口类"
    Static FilterMatchMethod := "匹配方式"
    Static FilterMatchContent := "匹配内容"
    Static FilterTextRegexMgr := "管理匹配文本类"
    Static TextExistFilter := "可用筛选器(&V):"
    Static TextFilterList := "筛选器列表(&T):"
    Static FilterFileExt := "文件后缀"
    Static FilterWinClass := "窗口类"
    Static FilterTextRegex := "文本类型"
    Static FilterFileMulti := "多文件"
    Static FilterFileName := "文件名"
    Static FilterFileDir := "文件目录名"
    Static FilterWinExe := "程序文件"
    Static FilterWinTitle := "窗口标题"
    Static FilterWinControl := "控件名称"
    Static FilterKeyword := "关键字"
    Static FilterFunction := "函数"
    Static FilterAll := "全部"
    Static FilterLogic := "匹配方式:"
    Static FilterLogicAnd := "全部(&A)"
    Static FilterLogicOr  := "部分(&S)"
    Static FilterSelectType := "#选择筛选条件"
    Static FilterSpecial := "特殊条件:"
    Static FilterAnyFile := "#任意文件"
    Static FilterAnyText := "#任意文本"
    Static FilterAnyMultiFiles := "#任意多文件"
    Static FilterMenuExtAny := "* 任意文件后缀(&A)"
    Static FilterMenuExtFolder := "Folder 文件夹(&F)"
    Static FilterMenuExtDrive := "Drive 驱动器(&D)"
    Static FilterMenuExtNoExt := "NoExt 无后缀文件(&N)"
    Static FilterMenuExtMulti := "MultiFiles 多文件(&M)"
    Static FilterMenuFoundWin := "寻找窗口(按住左键寻找，释放左键确认)"
    ;Static FilterMenuClassAny := "+添加任意窗口"
    Static FilterAddFileType := "+添加内置文件类型"
    Static FilterMenuFunc := "+添加匹配函数"
    Static FilterMenuMode := "+添加关键字"
    Static TextName2 := "名称"
    Static TextType := "类型"
    Static TextPath := "位置"
    Static TextUUID := "标识ID"
    Static TextMenu := "菜单"
    Static TextKey := "热键"
    Static TextFilterType := "筛选器类型(&T):"
    Static TextWinDefine := "程序定义"
    Static TextWinName := "程序名称"
    Static TextWinOptions := "选项"
    Static TextTimeOut := "热键超时"
    Static TextMaxCount := "最大运行次数"
    Static TextDefaultMode := "默认模式"
    Static TextCBDisable := "禁用此程序"
    Static TextCBDisable2 := "禁用此模式"
    Static TextCBDisable3 := "禁用此热键"
    Static TextWinFunctions := "关联函数"
    Static TextOnInit := "当加载配置时"
    Static TextOnShow := "当显示提示时"
    Static TextOnChangeMode := "当切换模式时"
    Static TextOnActionBefore := "当功能执行前"
    Static TextOnActionAfter := "当功能执行后"
    Static TextModeName := "模式名称"
    Static TextNormalMode := "普通模式"
    Static TextInsertMode := "插入模式"
    Static TextKeymap := "热键映射"
    Static TextKeyName := "热键名"
    Static TextAction := "功能"
    Static TextKeyTips := "热键说明"
    ; 热键映射相关
    Static TextDefineCmd := "#定义命令"
    Static TextInsideCmd := "#内置命令"
    Static TextKeySuffix := "#热键前缀"
    Static TextKeyHelp := "?热键帮助"
    Static Num0 := "数字&0"
    Static Num1 := "数字&1"
    Static Num2 := "数字&2"
    Static Num3 := "数字&3"
    Static Num4 := "数字&4"
    Static Num5 := "数字&5"
    Static Num6 := "数字&6"
    Static Num7 := "数字&7"
    Static Num8 := "数字&8"
    Static Num9 := "数字&9"
    Static KeyAHK:= "AHK格式热键"
    Static KeySuper := "热键不会被禁用"
    Static KeyNowait  := "无视超时限制"
    Static KeyNoMulti := "不允许多次运行"
    Static HelpTitleFilter := "筛选器帮助"
    
    Help_Filter()
    {
        strHelp =
        (LTrim
        请选择列表里的筛选条件，按"?帮助"后，会有针对每种条件的帮助说明。
        )
        Return {Text:strHelp, Title:"筛选器条件"}
    }
    Help_FilterFileExt()
    {
        strHelp =
        (LTrim
        当选中的内容是文件时，此条件有效。此条件会判断文件的后缀名，如txt;doc等。
        匹配内容请填写后缀名，多个后缀名用;分割，注意不要带"."，如 txt;doc;xls;json。
        文件夹、无后缀名、根目录 可以使用"+添加内置文件类型" 快速添加

        匹配方式有三种：“包含、排除、正则式”。
        包含：选中的文件后缀名满足匹配内容里的某一项，如 C:\test.txt 满足 txt;doc中的txt后缀，此条件有效。
        排除：排除与包含相反。
        正则式：对文件后缀名使用正则式匹配。

        匹配内容为"*"时，表示匹配任意文件，和特殊条件的“任意文件”类似。
        配合排除条件，用于“当不是选择的内容不是文件时有效”。
        )
        Return {Text:strHelp, Title:"文件类型"}
    }
    Help_FilterWinClass()
    {
        strHelp =
        (LTrim
        每个程序界面都有窗口类，利用窗口类可以限制在特定窗口中有效
        鼠标左键按住"?帮助"按钮右侧的"靶"图标不放，鼠标移动到想要匹
        配的窗口上，释放鼠标左键即可定位。
        匹配窗口类使用分号(;)分割。注意每次按住"靶"寻找窗口类都会自动添加分号

        匹配方式有三种：“包含、排除、正则式”。
        包含：当前窗口类满足匹配内容里的类，如记事本程序满足Notepad;Vim中的Notepad。
        排除：排除与包含相反。
        正则式：使用正则式来判断窗口类。
        )
        Return {Text:strHelp, Title:"窗口类"}
    }
    Help_FilterTextRegEx()
    {
        strHelp =
        (LTrim
        当选择的内容为文本时，此条件有效。
        利用文件类型条件，可以限定某种文本中有效。

        匹配方式有三种：“包含、排除、正则式”。
        包含：选中的文本里含有匹配内容里的某一项，如www.baidu.com满足www;html里的www字符
        排除：排除与包含相反。
        正则式：对文本使用正则式匹配（建议使用正则式条件）。
        )
        Return {Text:strHelp, Title:"文本类型"}
    }

    Help_KeyName()
    {
        strHelp =
        (LTrim
        1. 常规热键直接写："j" , "gg" , "wq" , "0" , "t1"
        2. 特殊热键用尖括号: "<esc>" , "<capslock>" , "<f1>", "<ctrl>"
        3. 组合键使用尖括号加减号: 
           "<c-w>" 表示 ctrl & w
           "<a-w>" 表示 alt & w
           "<s-w>" 表示 shift & w
           "<w-w>" 表示 win & w
           "<t-w>" 表示 Tab & w
           "<l-w>" 表示 CapsLock & w
           "<e-w>" 表示 Escape & w
           "<lc-w>" 表示左侧ctrl键, "<rc-w>" 表示右侧ctrl键
        ====================================================
        按键列表如下：
        鼠标
        "<LButton>", "<RButton>", "<MButton>"
        "<XButton1>", "<XButton2>"
        "<WheelDown>", "<WheelUp>"
        "<WheelLeft>", "<WheelRight>"
        ; 键盘控制
        "<CapsLock>", "<Space>", "<Tab>"
        "<Enter>", "<Esc>", "<BS>"
        光标控制
        "<ScrollLock>", "<Del>", "<Ins>"
        "<Home>", "<End>", "<PgUp>", "<PgDn>"
        "<Up>", "<Down>", "<Left>", "<Right>"
        修饰键
        "<Lwin>", "<Rwin>"
        "<control>", "<Lcontrol>", "<Rcontrol>"
        "<Alt>", "<LAlt>", "<RAlt>"
        "<Shift>", "<LShift>", "<RShift>"
        特殊按键
        "<Insert>", "<Ins>"
        "<AppsKey>", "<LT>":"<", "<RT>":">"
        "<PrintScreen>"
        "<controlBreak>"
        注意：数字小键盘暂时不支持
        )
        Return {Text:strHelp, Title:"热键说明"}
    }

    Help_QZFunctions()
    {
        FuncList = 
        (LTrim
        QZData   获取QZ的数据
        MenuZAll 获取数据并显示菜单
        MenuZWin 仅获取窗口信息并显示菜单
        )
        Return  FuncList
    }
    
    QZData_Help()
    {
        Var2 =
        (LTrim
        ==============================
        函数用于获取QZ的数据
        用法举例：
        )
        Var3 := "Msgbox % QZData(""Files"")`n"
        Var4 =
        (LTrim
        ---------------------------------------------
        可用参数如下：
        标签: {file:path} {text} 等普通模式里用的标签
        变量: `%uservar`% 等用户变量或者内置变量
        参数名称: 如以下内容所示
        ---------------------------------------------
        窗口相关
        x - 鼠标x坐标
        y - 鼠标y坐标
        hWnd - 程序的 ahk_id
        WinControl - 程序焦点所在控件的 classNN
        WinClass - 程序的 ahk_class
        WinExe - 程序的 exe名，如notepad.exe
        ---------------------------------------------
        文本相关
        Text - 获取到的文本内容
        ---------------------------------------------
        文件相关
        Files - 获取到的文件列表
        FileExt - 文件后缀名。文件夹: *Folder* 
        >         驱动器路径: *Drvie*、无后缀: *NoExt* 
        >         多文件时: *MultiFiles*
        FileName - 获取的文件名/文件夹名，多文件无效
        FileDir - 获取的文件/文件夹对应的上级文件夹
        FileMulti - 对象，包含各个文件的后缀名
        ---------------------------------------------
        其它
        SepMode - 关键字过滤使用独立模式
        Keyword - 当前热键对应的关键字
        )
        strHelp := Var1 . Var2 . Var3 . Var4
        Return {Text:strHelp, Title:"QZData( aParam )"}
    }

    MenuZAll_Help()
    {
        strHelp =
        (LTrim
        ==============================
        直接使用即可。
        建议绑定到热键或者手势。
        )
        Return {Text:strHelp, Title:"MenuZAll()"}
    }
}
