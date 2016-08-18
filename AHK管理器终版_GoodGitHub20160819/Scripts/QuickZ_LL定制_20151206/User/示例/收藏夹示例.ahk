/*
Plugin=My收藏夹
Name1=My收藏夹
Command1=dm_Test
Author=Array
Version=0.1
*/

DM_Test(aParam) ; 此Plugin执行的command为Test，代表执行Test函数,函数请预留一个aParam，用于QuickZ传递参数过来。
{
    TestMenu := MenuZ_GetSub() ; 获取一个子菜单对象
    TestMenu.Add({name:aParam}) ; 可以添加菜单
    Loop, 10
        TestMenu.Add({name:"Item" A_Index})
    return TestMenu  ; 必须返回子菜单对象
}

;Test + _Handle 会被QuickZ获取到，并把点击的内容转换到此函数中
DM_Test_Handle(aMsg, aObj) 
{
    If (aMsg = "OnRun")
        msgbox % "test run " aObj.Name
}
