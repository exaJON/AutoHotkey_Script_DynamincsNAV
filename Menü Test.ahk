#Requires AutoHotkey v2.0

Mymenu := Menu()
Mymenu.Add("setrange", (*) => Send("SETRANGE(){LEFT 1}"))
Mymenu.Add("setfilter", (*) => Send("SETFILTER(){LEFT 1}"))
Mymenu.Add("findset", (*) => Send("FINDSET(FALSE,FALSE)"))
#::Mymenu.Show()


