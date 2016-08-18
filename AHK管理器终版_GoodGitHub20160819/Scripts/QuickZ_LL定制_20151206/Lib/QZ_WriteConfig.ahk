/*
    Function: QZ_WriteConfig
        保存配置文件到指定的路径

    Parameters: 
        aObj  - Json对象
        aPath - 需要保存的路径
        aChar - 格式化字符串，Json对象中以aChar个空格分开

    Returns: 
        无    

    Remarks: 
        如果配置文件已经存在，自动保存原先的配置文件为aPath "_Bak"
        需要 Class_Json.ahk
*/
QZ_WriteConfig(aObj, aPath, aChar=2)
{
    strConfig := Json.Dump(aObj, aChar)
    If FileExist(aPath)
        FileDelete, %aPath%
    FileAppend, %strConfig%, %aPath%
}
