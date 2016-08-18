/*
Label={ParentDirName}
Tips=被选中文件的父目录名称
Author=Array
Version=0.1
*/

ParentDirName(aParam:="")
{
    FileDir := QZData("FileDir")
    SplitPath, FileDir, , , , PDir
    return PDir
}
