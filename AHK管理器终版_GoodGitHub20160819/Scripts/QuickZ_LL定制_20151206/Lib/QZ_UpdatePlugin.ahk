/*
    Function: QZ_UpdatePlugin()
        搜索User\下的所有的AHK，并加载到 Lib\QZ_Plugins.ahk。用于动态加载
*/

QZ_UpdatePlugin()
{
    FileEncoding,utf-8
    ExtensionsAHK := A_ScriptDir "\Lib\QZ_Plugins.ahk"
    ; 清理无用#include
    Filedelete, %ExtensionsAHK%
    ;; 查询插件
    Loop, % QZGlobal.PluginDir "*.ahk", 1, 1
    {
        PluginPath := StrReplace(A_LoopFileFullPath, A_ScriptDir "\")
        pluginStr .=  "#include *i `%A_ScriptDir`%\" PluginPath "`n"
    }
    FileAppend,%pluginStr%,%ExtensionsAHK%
    Return ; 默认不使用保存修改时间。
    ; 保存修改时间
    SaveTime := "/*`r`n[ExtensionsTime]`r`n"
    Loop,% QZGlobal.PluginDir "*.ahk", 1, 1
    {
        PluginPath := StrReplace(A_LoopFileFullPath, A_ScriptDir "\")
        ;plugin :=  QZGlobal.PluginDir A_LoopFileName 
        FileGetTime, ExtensionsTime, %A_LoopFileFullPath%, M
        SaveTime .= PluginPath "=" ExtensionsTime "`r`n"
    }
    SaveTime .= "*/`r`n"
    FileAppend, %SaveTime%, %ExtensionsAHK%
}
