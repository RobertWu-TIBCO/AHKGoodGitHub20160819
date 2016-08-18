QZ_Engine(aCommand, aParam:="", aWorkingDir:="", aRunState:="")
{
    Global gMenuZ, gQZEngine
    Static objShell
    gQZEngine := {}
    gQZEngine.RunPID := 0
    Command := QZ_ReplaceEnv(aCommand)
    Param   := QZ_ReplaceEnv(aParam)
    WorkingDir := QZ_ReplaceEnv(aWorkingDir)
    Param := QZ_SpecialChrEncode(Param)
    If IsFunc(Command)
    {
        %Command%(Param)
        Return
    }
    fPos := 1, objFile := ""
    Loop
    {
        If fPos := RegExMatch(Param, "{[^{}]*}", strMatch, fPos)
        {
            strRepl := QZ_LabelTrans(strMatch)
            StringReplace, Param, Param, %strMatch%, % QZ_SpecialChrDecode(strRepl)
            fPos += StrLen(strRepl) - 1		;-1 because we removing two %
            If fPos < 1
                fPos := 1
        }
        Else
          Break
    }
    If FileExist(Command) && Strlen(Param)
        strBreak := A_Space
    String := Trim(RegExReplace(Command strBreak Param, "[\n\r]"), " ")
    ; 判断aCommand是否为函数？
    ; 判断aParam是否为多行
    ; 找出所有的{}结构
    ;clipboard := string
    ;QZ_ShellExecute(Command, Param, aWorkingDir)
    Run, %String%, %aWorkingDir%, UseErrorLevel, PID
    If ErrorLevel
    {
        Msgbox % "File Not Exist: " Command
        Return
    }
    gQZEngine.RunPID := PID
    gQZEngine.RunString := String
}

QZ_ShellExecute(target,args = "", work_dir = "",verb = "")
{
    ;https://msdn.microsoft.com/en-us/library/windows/desktop/bb762153(v=vs.85).aspx
    return DllCall("shell32\ShellExecuteW", "Ptr", 0, "str", verb, "str", target, "str", args, "str", work_dir, "int", 1)
}

;QZ_LabelDecode(
QZ_LabelTrans(strMatch)
{
    Global gMenuZ
    strRepl := strMatch
    If IsFunc(_Func := RegExReplace(strMatch, "((^{)|(:.*}$)|(}$))"))
    {
        If InStr(strMatch, ":")
            strRepl := %_Func%(strMatch)
        Else
            strRepl := %_Func%()
    }
    Else If InStr(strMatch, "{file:")
    {  
        If !IsObject(objFile)
            objFile := new QZ_LabelFile(gMenuZ.Data.Files)
        strRepl := objFile.Parse(strMatch)
    }
    Else If (strMatch = "{text}")
        strRepl := gMenuZ.Data.text
    Else If (strMatch = "{select}")
        strRepl := gMenuZ.Data.text
    Return strRepl
}


QZ_SpecialChrEncode(String)
{
    String := RegExReplace(String, "\[\[\]", Chr(1))
    String := RegExReplace(String, "\[\]\]", Chr(2))
    String := RegExReplace(String, "\[\{\]", Chr(3))
    String := RegExReplace(String, "\[\}\]", Chr(4))
    Return String
}

QZ_SpecialChrDecode(string)
{
    String := RegExReplace(String, Chr(1), "[")
    String := RegExReplace(String, Chr(2), "]")
    String := RegExReplace(String, Chr(3), "{")
    String := RegExReplace(String, Chr(4), "}")
    Return String
}

Class QZ_LabelFile
{
    __new(aFile)
    {
        This.arrFiles := []
        Loop, Parse, aFile, `n
        {
            If !Strlen(A_LoopField)
                Continue
            This.ArrFiles[A_Index] := A_LoopField
        }
        This.File := aFile
        SplitPath, aFile, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
        This.FileName := OutFileName
        This.Dir := OutDir
        This.Extension := OutExtension
        This.NameNoExt := OutNameNoExt
        This.Drive := OutDrive
    }

    Parse(aLabel)
    {
        If (aLabel = "{file:path}")
            strRepl := This.File
        Else If (aLabel = "{file:name}")
            strRepl := This.FileName
        Else If (aLabel = "{file:dir}")
            strRepl := This.dir
        Else If (aLabel = "{file:ext}")
            strRepl := This.Extension
        Else If (aLabel = "{file:namenoext}")
            strRepl := This.NameNoExt
        Else If (aLabel = "{file:drive}")
            strRepl := This.Drive
        Else If RegExMatch(aLabel, "i)^{file.*}$")
            strRepl := This.FileTemplate(aLabel)
        Else
            strRepl := aLabel
        Return strRepl
    }

    FileTemplate(aLabel)
    {
        strOption := RegExReplace(aLabel, "i)(^{file:)|(})")
        If InStr(aLabel, "[OF]")
        {
            StringReplace, strOption, strOption, [OF]
            boldOF:= True
        }
        If InStr(aLabel, "[OD]")
        {
            StringReplace, strOption, strOption, [OD]
            boldOD:= True
        }
        If RegExMatch(aLabel, "\[<(\d*)\]", co_DelChar)
        {
            StringReplace, strOption, strOption, %co_DelChar%
            numDel := co_DelChar1
        }
        If RegExMatch(aLabel, "\[@(.*)\]", co_Regex)
        {
            StringReplace, strOption, strOption, %co_Regex%
            strNeedle := co_Regex1
        }
        If RegExMatch(aLabel, "\[#(.*)\]", co_Func)
        {
            StringReplace, strOption, strOption, %co_Func%
            strFunc := co_Func1
        }
        If RegExMatch(aLabel, "\[=(.*)\]", co_Equal)
        {
            StringReplace, strOption, strOption, %co_Equal%
            arrEqual := {}
            Loop, Parse, co_Equal1, |
                arrEqual[A_Index] := A_LoopField
        }
        If RegExMatch(aLabel, "\[!(.*)\]", co_Unequ)
        {
            StringReplace, strOption, strOption, %co_Unequ%
            arrUnequ := {}
            Loop, Parse, co_Unequ1, |
                arrUnequ[A_Index] := A_LoopField
        }
        If RegExMatch(aLabel, "\[%([\d\-,]*)\]", co_Index)
        {
            StringReplace, strOption, strOption, %co_Index%
            arrIndex := []
            Loop, Parse, co_Index1, `,
            {
                If !Strlen(A_LoopField)
                    Continue
                Else If InStr(A_LoopField, "-")
                {
                    N1 := Substr(A_LoopField, 1, Instr(A_LoopField,"-")-1)
                    N2 := SubStr(A_LoopField, InStr(A_LoopField,"-")+1)
                    Loop % N2 - N1 + 1
                        arrIndex[A_Index + N1 - 1] := True
                }
                Else
                {
                    arrIndex[A_LoopField] := True
                }
            }
        }
        arrFilesList := This.arrFiles
        arrOut := "", idx := 1
        ;strOption := Trim(strOption)
        Loop % arrFilesList.MaxIndex()
        {
            strFile := arrFilesList[A_Index]
            IsEqual := True
            If IsObject(arrEqual)
            {
                Loop % arrEqual.MaxIndex()
                    If InStr(strFile, arrEqual[A_Index])
                    {
                        IsEqual := False
                        Break
                    }
            }
            IsUnequ := False
            If IsObject(arrUnequ)
            {
                Loop % arrUnequ.MaxIndex()
                    If InStr(strFile, arrUnequ[A_Index])
                    {
                        IsUnequ:= True
                        Break
                    }
            }
            If (IsObject(arrIndex) && !arrIndex[A_LoopField])
            || (Strlen(strNeedle) && !RegExMatch(strFile, strNeedle))
            || (Strlen(strFunc) && IsFunc(strFunc) && !%strFunc%(strFile))
            || (boldOF && Instr(FileExist(strFile), "D"))
            || (boldOD && !Instr(FileExist(strFile), "D"))
            || !IsEqual
            || IsUnequ
                Continue
            strRepl := strOption
            SplitPath, strRepl, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
            StringReplace, strRepl, strRepl, [P], %strFile%
            StringReplace, strRepl, strRepl, [N], %OutFileName%
            StringReplace, strRepl, strRepl, [NE], %OutNameNoExt%
            StringReplace, strRepl, strRepl, [E], %OutExtension%
            StringReplace, strRepl, strRepl, [F], %OutDir%
            StringReplace, strRepl, strRepl, [D], %OutDrive%
            StringReplace, strRepl, strRepl, [Date], %A_YYYY%%A_MM%%A_DD%
            StringReplace, strRepl, strRepl, [YY], %A_YYYY%
            StringReplace, strRepl, strRepl, [MM], %A_MM%
            StringReplace, strRepl, strRepl, [DD], %A_DD%
            StringReplace, strRepl, strRepl, [Time], %A_Hour%%A_Min%%A_Sec%
            StringReplace, strRepl, strRepl, [H], %A_Hour%
            StringReplace, strRepl, strRepl, [M], %A_Min%
            StringReplace, strRepl, strRepl, [S], %A_Sec%
            StringReplace, strRepl, strRepl, [CR],  % "`n"
            StringReplace, strRepl, strRepl, [TAB], % A_Tab
            StringReplace, strRepl, strRepl, [I], %idx%
            idx++
            If numDel
                strRepl := SubStr(strRepl, 1, Strlen(strRepl) - numDel)
            arrOut .= strRepl
        }
        Return arrOut
    }
}

QZ_LabelDate(Switch)
{
	If RegExMatch(switch,"\[(.*?)(?<!\\)\]",now)
	{
		If RegExMatch(now1,"^\w*$")
			now := now1
		Else
		{

			Now := A_now
			If RegExMatch(now1,"i)d\s*\+\s*(\d+)",d)
				now += d1 , d
			If RegExMatch(now1,"i)m\s*\+\s*(\d+)",m)
				now += d1 , m
			If RegExMatch(now1,"i)s\s*\+\s*(\d+)",s)
				now += d1 , s
		}
	}
	Else
		now := A_Now
	If RegExMatch(switch,"i)^\{date\}$")
		FormatTime, time , %now% ,yyyyMMdd
	Else
	{
		format := RegExReplace(RegExReplace(switch,"i)(^\{date:)|(\}$)"),"\[(.*?)(?<!\\)\]")
		If RegExMatch(format,"\w*")
			FormatTime, time , %now% ,%format%
	}
	;If RegExMatch(switch,"
	return time
}

QZ_LabelSelect(select,switch)
{
    RtString := select
	If RegExMatch(switch,"\[@(.*?)(?<!\\)\]",RegExSelect)
	{
		RegExSelect:= RegExReplace(RegExSelect1,"\\\]","]")
		RegExMatch(select,RegExSelect,RtString)
	}
	If RegExMatch(switch,"\[(?<!@)(.*?)(?<!\\)\]",RegExEncode)
	{
		Encode := RegExReplace(RegExEncode1,"\\\]","]")
		RtString := SksSub_UrlEncode(select,Encode)
	}
	Return RtString
}

; SksSub_UrlEncode(string, enc="UTF-8") {{{4
; 来自万年书妖的Candy里的函数，用于转换编码。感谢！
SksSub_UrlEncode(string, enc="UTF-8")
{   ;url编码
    enc:=trim(enc)
    If enc=
        Return string
	If Strlen(String) > 200
		string := Substr(string,1,200)
    formatInteger := A_FormatInteger
    SetFormat, IntegerFast, H
    VarSetCapacity(buff, StrPut(string, enc))
    Loop % StrPut(string, &buff, enc) - 1
    {
        byte := NumGet(buff, A_Index-1, "UChar")
        encoded .= byte > 127 or byte <33 ? "%" Substr(byte, 3) : Chr(byte)
    }
    SetFormat, IntegerFast, %formatInteger%
    return encoded
}

QZ_LabelSave(Save)
{
    Global ObjData
    fpath := RegExReplace(Save,"i)(^\{save:)|(\}$)")
    SplitPath, fpath, , OutDir
    if not strlen(OutDir)
        fpath := A_Temp "\" RegExReplace(Save,"i)(^\{save:)|(\}$)")
    If FileExist(fpath)
        FileDelete, %fpath%
    ftext := ObjData.text
    FileAppend, %ftext% , %fpath%
    return "" fpath ""
}

QZ_LabelWindow(switch)
{
    Global ObjData
    hHwnd := ObjData.hwnd 
    WinGet,f,ProcessPath,ahk_id %hHwnd%
    Splitpath,f,filename,dir,,namenoext,drive
    If RegExMatch(switch,"i)\{window:path\}")
        return f
    If RegExMatch(switch,"i)\{window:file\}")
        return filename
    If RegExMatch(switch,"i)\{window:dir\}")
        return dir
    If RegExMatch(switch,"i)\{window:name\}")
        return namenoext
    If RegExMatch(switch,"i)\{window:drive\}")
        return drive
}
