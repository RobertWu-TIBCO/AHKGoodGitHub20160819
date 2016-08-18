/*
; --------- Example ---------------------
GroupAdd(MyGroup, "Untitled")       ; You have to use expression syntax in functions
WinWaitActive ahk_group %MyGroup%   ; and ahk_group %MyGroup% in Win-commands
WinMinimize % "ahk_group" MyGroup   ; or "ahk_group" MyGroup in expression mode
MyGroup =                           ; "Deletes" the group
; ---------------------------------------
*/

GroupAdd(ByRef GroupName,p1="",p2="",p3="",p4="",p5=""){
  static g:= 1
  If (GroupName = "")
     GroupName:= "AutoName" g++
  GroupAdd %GroupName%, %p1%, %p2%, %p3%, %p4%, %p5%
}