#Include, Class_Json.ahk
Menu, Tray, NoIcon
Dir := A_ScriptDir "\..\user"
FileSelectFile, Config, , %Dir%, Config.json, *.json
If !FileExist(Config)
    ExitApp
FileCopy, %Config%, %Config%_Bak, 1
FileRead, txt, %Config%
objConf := Json.Load(txt)
newtxt  := Json.Dump(_Compress(objConf), 2)
FileDelete, %Config%
FileAppend, %newTxt%, %Config%
ExitApp


_Compress(obj)
{
    for key , value in obj.Clone()
    {
        If IsObject(Value)
        {
            obj[Key] := _Compress(Value)
        }
        Else If !Strlen(Value) || !Value
            obj.delete(key)
        ;Else
            ;Msgbox % "Keep:" key
    }
    return obj
}

