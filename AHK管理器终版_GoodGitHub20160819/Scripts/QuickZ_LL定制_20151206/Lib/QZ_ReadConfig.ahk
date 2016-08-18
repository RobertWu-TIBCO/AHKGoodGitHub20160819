/*
    Function: QZ_ReadConfig
        读取配置文件

    Parameters: 
        aPath - 配置文件的路径

    Returns: 
        返回Json对象

    Remarks: 
        需要 Class_Json.ahk 和 Class_QZLang.ahk
 */

QZ_ReadConfig(aPath)
{
    If FileExist(aPath)
    {
        FileRead, strJson, %aPath%
        objJson := Json.Load(strJson)
    }
    Else
    {
        If FileExist(aPath := aPath ".Example")
        {
            FileRead, strJson, %aPath%
            objJson := Json.Load(strJson)
        }
        Else
        {
            objJson := QZ_CreateConfig()
        }
    }
    Return objJson
}
