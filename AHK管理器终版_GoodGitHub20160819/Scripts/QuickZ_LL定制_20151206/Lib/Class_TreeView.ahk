Class TreeView{
	static list:=[]
	__New(hwnd){
		this.list[hwnd]:=this
		OnMessage(0x4e,"TreeView_WM_NOTIFY")
		this.hwnd:=hwnd,this.selectcolor:=""
	}
	add(info){
		Gui,TreeView,% this.hwnd
		hwnd:=TV_Add(info.Label,info.parent,info.option)
		if info.fore!=""
			this.control["|" hwnd,"fore"]:=info.fore
		if info.back!=""
			this.control["|" hwnd,"back"]:=info.back
		return hwnd
	}
	modify(info){
		this.control["|" info.hwnd,"fore"]:=QZ_Rgb(info.fore)
		this.control["|" info.hwnd,"back"]:=QZ_Rgb(info.back)
		WinSet,Redraw,,A
	}
	Remove(hwnd){
		this.control.Remove("|" hwnd)
	}
}
TreeView_WM_NOTIFY(Param*){
    Global GuiMain
	static list:=[],ll:=""
    CtrlID :=  NumGet(param.2)
    If (CtrlID = GuiMain.Manager.hwnd) && (GuiMain.EditMode = 1)
    {
        control:=""
        if (this:=treeview.list[NumGet(Param.2)])&&(NumGet(Param.2,2*A_PtrSize,"int")=-12){
            stage:=NumGet(Param.2,3*A_PtrSize,"uint")
            if (stage=1)
                return 0x20 ;sets CDRF_NOTIFYITEMDRAW
            if (stage=0x10001&&info:=this.control["|" numget(Param.2,A_PtrSize=4?9*A_PtrSize:7*A_PtrSize,"uint")]){ ;NM_CUSTOMDRAW && Control is in the list
                if info.fore!=""
                    NumPut(info.fore,Param.2,A_PtrSize=4?12*A_PtrSize:10*A_PtrSize,"int") ;sets the foreground
                if info.back!=""
                    NumPut(info.back,Param.2,A_PtrSize=4?13*A_PtrSize:10.5*A_PtrSize,"int") ;sets the background
            }
            if (this.selectcolor){
                Gui,TreeView,% NumGet(param.2)
                if (NumGet(param.2,9*A_PtrSize)=TV_GetSelection())
                    NumPut(this.selectcolor,Param.2,A_PtrSize=4?13*A_PtrSize:10.5*A_PtrSize,"int") ;sets the background
            }
        }
    }
    Else
    {
        Toolbar_onNotify(Param.1, Param.2, Param.3, Param.4)
    }
}

