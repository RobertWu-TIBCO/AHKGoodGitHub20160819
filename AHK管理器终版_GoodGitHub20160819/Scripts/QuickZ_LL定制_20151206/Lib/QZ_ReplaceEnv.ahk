/*!
    - Function: QZ_ReplaceEnv
        进行QZ的用户变量进行替换
    - Parameters:
        aEnv 需要替换的用户变量，如%user%
    - Returns: 字符串
    - Remarks: 无
*/

QZ_ReplaceEnv(aEnv)
{
    Global gQZConfig
    Static objShell
    If !IsObject(objShell)
    {
        objShell := ComObjCreate("WScript.shell")
        ;EnvSet, A_ScriptDir, %A_ScriptDir%
        ;EnvSet, A_WinDir, %A_WinDir%
        ;EnvSet, A_AhkPath, %A_AhkPath%
        EnvSet, Apps, %A_ScriptDir%\Apps
        EnvSet, User, %A_ScriptDir%\User\
        EnvSet, Icons, %A_ScriptDir%\User\Icons
        QZ_UpdateUserEnv()
    }
    newEnv := objShell.ExpandEnvironmentStrings(aEnv)
    Return newEnv
}

QZ_UpdateUserEnv()
{
    Global gQZConfig, gQZUserEnvList
    varInside := QZGlobal.InsideEnv
    Loop, Parse, varInside , |
        EnvSet, %A_LoopField%, % %A_LoopField%
    For Name , Value In gQZUserEnvList
        EnvSet, %Name%, `%%Name%`%
    Loop % gQZConfig.Setting.UserEnv.MaxIndex()
    {
        objEnv := gQZConfig.Setting.UserEnv[A_Index]
        QZ_SetEnv(objEnv.Name, objEnv.Value)
    }
    If FileExist(QZGlobal.OutsideEnv)
    {
        FileRead, EnvText, % QZGlobal.OutsideEnv
        Loop, Parse, EnvText, `n, `r
        {
            If Strlen(A_LoopField)
            {
                If RegExMatch(A_LoopField, "^\s*\[.*\]\s*$")
                    Continue
                If InStr(A_LoopField, "=")
                    QZ_SetEnv(Regexreplace(A_loopfield, "=.*$"), Regexreplace(A_loopfield, "^[^=]*="))
                Else
                    QZ_SetEnv(A_LoopField, "")
            }
        }
    }
}

QZ_SetEnv(aName, aValue)
{
    Global gQZUserEnvList 
    If !IsObject(gQZUserEnvList)
        gQZUserEnvList := {}
    If RegExMatch(aValue, "%\K.+?(?=%)")
        aValue := ParseEnvVars(aValue)
    gQZUserEnvList[aName] := aValue
    EnvSet, %aName%, %aValue%
}
