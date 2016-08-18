/*
Plugin=TC收藏夹
Name1=TC收藏夹
Command1=dm_TCDirHotList
Author=Array
Version=0.1
*/

dm_TCDirHotList(aParam)
{
    Global gMenuZ ; 固定
    Static TCDir
    TC:=QZData("%TC%")
    SplitPath, TC, , TCDir
    ;TestMenu := gMenuZ.PUM.CreateMenu() ; 固定
    TestMenu := MenuZ_GetSibling() ; 将当前编辑的菜单设置为主菜单，由于添加同级菜单
    If !FileExist(TCDir)
        TCDir := FileExist(aParam) ? aParam : TotalCmd_GetInstallDir()
    If FileExist(TCDir)
    {
        TCINI := TCDir .  ((SubStr(TCDir, 0) = "\") ? "wincmd.ini" : "\wincmd.ini")
        IniRead, HD, %TCINI%, DirMenu
        Loop
        {
            Key := "Menu" A_Index
            cmd := "Cmd" A_Index
            IniRead, name, %TCINI%, DirMenu, %Key%
            IniRead, dir,  %TCINI%, DirMenu, %cmd%
            If (name = "ERROR")
                Break
            Else
                TestMenu.Add({name:Name,uid:{handle:"TotalCmdDirMenu_Handle",data:dir}})
                ; uid 可以存放对象。至少需要一个 handle:TotalCmdDirMenu_Handle 来让菜单插件知道必须将数据转给某个函数。其它的可以自由发挥。这里使用一个Data用于存放路径，供TotalCmdDirMenu_Handle操作
        }
    }
    Return TestMenu ; 固定
}

TotalCmdDirMenu_Handle(aMsg, aObj)
{
    If (aMsg = "OnRun")
    {
        TotalCmd_Command(aObj.uid.Data)
    }
}

TotalCmd_GetInstallDir()
{
    RegRead,TCDir,HKEY_CURRENT_USER,Software\Ghisler\Total Commander,InstallDir
    ;TCDir := "C:\My_TC_Path"
    Return TCDir
}

TotalCmd_Command(aStr)
{
    ; 执行 cd 命令
    strPath := A_WinDir "\explorer.exe /select," RegExReplace(aStr, "cd\s")
    run %strPath%
}
