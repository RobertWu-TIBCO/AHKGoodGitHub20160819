
GUI_ItemProperty_Load(aHandl)
{
    Global ItemProperty
    ItemProperty:= New GUI2("ItemProperty", "+LastFound +Theme -DPIScale")
    ItemProperty.SetFont(QZGlobal.FontSize, "Microsoft YaHei")
    ItemProperty.AddCtrl("Edit_Item", "Edit", "x10 y10 w400 r18")
    ItemProperty.Show()
}

GUI_ItemProperty_LoadData(aObj)
{
    Global ItemProperty
    ItemProperty.Edit_Item.SetText(Json.Dump(aObj, 2))
}
