#Requires AutoHotkey v2.0

Mymenu := Menu()
Mymenu.Add("Mit freundlichen Grüßen", (*) => Send("Mit freundlichen Grüßen"))
Mymenu.Add("Viele Grüße", (*) => Send("Viele Grüße"))
Mymenu.Add("Beste Grüße", (*) => Send("Beste Grüße"))
F12::Mymenu.Show()
   