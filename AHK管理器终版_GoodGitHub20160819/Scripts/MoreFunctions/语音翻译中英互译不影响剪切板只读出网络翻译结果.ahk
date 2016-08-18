;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;作者：天甜；QQ：105224583
;测试环境：win7
;感谢万年书妖的 Cando_有道翻译，感谢小古的视频教程
;语音翻译-中英互译-不影响剪切板-只语音读出网络翻译结果，必须有网络
;更新于：2016-07-16
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Process, Priority,,high			;脚本高优先级
#NoTrayIcon 						;隐藏托盘图标
#NoEnv								;不检查空变量是否为环境变量
#Persistent						;让脚本持久运行(关闭或ExitApp)
#SingleInstance Force				;跳过对话框并自动替换旧实例
#WinActivateForce					;强制激活窗口
#MaxHotkeysPerInterval 200		;时间内按热键最大次数
SetBatchLines -1					;脚本全速执行
SetControlDelay 0					;控件修改命令自动延时
CoordMode Menu Window				;坐标相对活动窗口
SendMode Input						;更速度和可靠方式发送键盘点击
SetTitleMatchMode 2				;窗口标题模糊匹配
DetectHiddenWindows On			;显示隐藏窗口
SetWorkingDir %A_ScriptDir%		;当前脚本所在目录的绝对路径.不包含最后的反斜线
;以上是我主脚本的开头，貌似哪里有问题，各位大神还请不吝赐教，感谢

$!y::
	原值:=Clipboard
	clipboard =
	Send ^c
	gosub sound
	Return  
sound:
	ClipWait,0.5
	If(ErrorLevel)
		{
		InputBox,varTranslation,请输入,你想翻译啥，我来说
		Youdao译文:=YouDaoApi(varTranslation)
		Youdao_网络释义:= json(Youdao译文, "web.value")
		;zxh语音翻译=% Youdao_网络释义
		spovice:=ComObjCreate("sapi.spvoice")
		spovice.Speak(Youdao_网络释义)
		}
	else
		{
		varTranslation:=clipboard
		Youdao译文:=YouDaoApi(varTranslation)
		Youdao_网络释义:= json(Youdao译文, "web.value")
		;zxh语音翻译=% Youdao_网络释义
		;MsgBox, "%zxh语音翻译%"
		spovice:=ComObjCreate("sapi.spvoice")
		spovice.Speak(Youdao_网络释义)
		}
	Clipboard:=原值
	return 

YouDaoApi(KeyWord)
{
;    KeyWord:=SkSub_UrlEncode(KeyWord,"utf-8")
	url:="http://fanyi.youdao.com/fanyiapi.do?keyfrom=qqqqqqqq123&key=86514254&type=data&doctype=json&version=1.1&q=" . KeyWord
    WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    WebRequest.Open("GET", url)
    WebRequest.Send()
    result := WebRequest.ResponseText
    Return result
}
json(ByRef js, s, v = "")
{
	j = %js%
	Loop, Parse, s, .
	{
		p = 2
		RegExMatch(A_LoopField, "([+\-]?)([^[]+)((?:\[\d+\])*)", q)
		Loop {
			If (!p := RegExMatch(j, "(?<!\\)(""|')([^\1]+?)(?<!\\)(?-1)\s*:\s*((\{(?:[^{}]++|(?-1))*\})|(\[(?:[^[\]]++|(?-1))*\])|"
				. "(?<!\\)(""|')[^\7]*?(?<!\\)(?-1)|[+\-]?\d+(?:\.\d*)?|true|false|null?)\s*(?:,|$|\})", x, p))
				Return
			Else If (x2 == q2 or q2 == "*") {
				j = %x3%
				z += p + StrLen(x2) - 2
				If (q3 != "" and InStr(j, "[") == 1) {
					StringTrimRight, q3, q3, 1
					Loop, Parse, q3, ], [
					{
						z += 1 + RegExMatch(SubStr(j, 2, -1), "^(?:\s*((\[(?:[^[\]]++|(?-1))*\])|(\{(?:[^{\}]++|(?-1))*\})|[^,]*?)\s*(?:,|$)){" . SubStr(A_LoopField, 1) + 1 . "}", x)
						j = %x1%
					}
				}
				Break
			}
			Else p += StrLen(x)
		}
	}
	If v !=
	{
		vs = "
		If (RegExMatch(v, "^\s*(?:""|')*\s*([+\-]?\d+(?:\.\d*)?|true|false|null?)\s*(?:""|')*\s*$", vx)
			and (vx1 + 0 or vx1 == 0 or vx1 == "true" or vx1 == "false" or vx1 == "null" or vx1 == "nul"))
			vs := "", v := vx1
		StringReplace, v, v, ", \", All
		js := SubStr(js, 1, z := RegExMatch(js, ":\s*", zx, z) + StrLen(zx) - 1) . vs . v . vs . SubStr(js, z + StrLen(x3) + 1)
	}
	Return, j == "false" ? 0 : j == "true" ? 1 : j == "null" or j == "nul"
		? "" : SubStr(j, 1, 1) == """" ? SubStr(j, 2, -1) : j
}
