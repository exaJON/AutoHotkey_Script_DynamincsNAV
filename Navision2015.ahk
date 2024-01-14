#Requires AutoHotkey v2.0
;Beschreibung Hotstring Symbole

;	*  	- bedeutet es muss kein Endzeichen gesetzt werden also ohne Leertaste TAB oder Enter
;	B0	- Backspace wird nicht ausgeführt. also der zuvor eingegebene Befehl wird nicht gelöscht. @sr ergibt  @sr SETRANGE(); 
;	O	- es wird kein Leerzeichen nach dem {Left 2} ausgeführt setrange(); anstatt setrange( );
;	?	- der Hotstring kann mitten in einem anderen Wort stehen

; ^   entspricht der Steuerung - Taste
; !   entspricht der Alt Taste
; +   entspricht der Shift Taste
; #   entspricht der Windows-Taste

;################# Funktionen #########################



; Initialen holen für Doku-Triger
GetInitials()
{
	FirstLetter := substr(A_username,1,1)
	SecondLetter := substr(A_username, instr(A_username, ".", false ) +1, 1)
	Return FirstLetter SecondLetter
}

GetFirstLetter()
{
		FirstLetterString := ""
		Loop 3
		{
			
			FirstLetterString := FirstLetterString substr(A_username,1,1)
		}
		Return FirstLetterString

}
ShowHelp()
{
	MsgBox "
  (
    ###### Hotkeys für NAV Entwicklungsumgebung ######
	
CTRL + o	Optionen aufrufen, Springen auf 
	Mandantenauswahl
CTRL + ALT + d 	Dokumentationstrigger aus aktueller Zeile 
	wird hochgezählt und darunter eine neue Zeile
	angelegt. Es muss die vorherige 
	Dokumentationsnummerierung markiert sein.
CTRL + g	Globale Variablen aufrufen 
CTRL + l	Lokale Variablen aufrufen 
CTRL + # Dokumentationsbereich einfügen, 
	erster Buchstabe des Anmeldenamens 3x
	// jjj |
CTRL + d Aktuelle Zeile kopieren
CTRL + Shift + f	Suche mit Begriff unter Cursor füllen.
	oder markierten Text als Suchbegriff
CTRL + Shift + h	Suche und Ersetzen mit Begriff unter 
	Cursor, oder markierten Text als Suchbegriff

################# Hot Strings #################
Texte die hintereinander eingegeben werden. 
wird ein Text erkannt wird er automatisch ersetzt. 
Die Texte müssen für sich alleine stehen 
oder können einen vorangestellten "." haben.
 | symbolisiert den Cursor nach Konvertierung des Strings

begin	BEGIN|END;
d#	Heutiges Datum dd.MM.yyyy
vl#	VALIDATE(|);
tf#	TESTFIELD(|);
ff#	FINDFIRST;
fl#	FINDLAST;
if#	IF () THEN BEGIN
				
	END;
re#	repeat;
un#	Until |.next = 0;
sr#	SETRANGE();
sf#	SETFILTER(|);
srr#	Es sollte eine Variable mit Punktvorangestellte sein.
	res.srr#    rec.RESET;
	rec.SETRANGE(|);
//(	DokuTag eröffnen, mit erstem Buchstaben 
	des Benutzertnamens
	// jjj B
	// jjj E
fs#	rec.findset then repeat
	until rec.next = 0;
doc#	Doku-Triggerzeile, In Zwischenablage muss die 
	letzte Versionsnummer sein.
	2.00    P0XXX      JN  dd.MM.yyyy  |
ndoc#	Hotstring für komplett neuen Doku-Trigger
=====================================
No.     Module  Name  Date       Description
=====================================
1.00    P0XXX       JN    dd.MM.yyyy |
  )", "Hotkey Hilfe", "iconi"

}
; Suchen oder Ersetzen mit Text unter dem gerade gesetzten Cursor
SearchString(search)
{
	cliptemp := A_Clipboard
	A_Clipboard := ""
	Send "^c"
	KeyWait "Control"
	KeyWait "c"
	clipwait(.5) 
	IF (A_Clipboard = "") {
		Send "^{Left}"
		KeyWait "Control"
		KeyWait "Left"
		Send "^+{Right}"
		KeyWait "Control"
		KeyWait "Right"
		KeyWait "Shift"
		Send "^c"
		KeyWait "Control"
		KeyWait "c"
		clipwait(.3)
		Loop {
			LastChr := SubStr(A_Clipboard, Strlen(A_Clipboard) , 1)
			;MsgBox LastChr
			sleep(200)
			IF (LastChr ~= "\w") {
				break
			}
			If (LastChr ~= "\s|.|,|\("){
				A_Clipboard := SubStr(A_Clipboard, 1 , Strlen(A_Clipboard)-1)
			}
		}
	} 
	If (search = true) {
		Send "^f"
	} else {
		Send "^h"
	}
	Sleep(50)
	SEND "^v"
}

; ######################   Hotkeys für alles  #########################

^!h::ShowHelp()


; ############## Hotkeys und Hotstrings nur für NAV ###########################

;HotIfWinActive "ahk_class Finsql.exe" 
#HotIf WinActive("ahk_exe finsql.exe")

^+f::SearchString(true)
^+h::SearchString(false)

;CTRL + o Optionen aufrufen 
^o::
{	
	Send "!f"
	Send "!f"
	Sleep 50
	Send "{left}"
	Sleep 50
	Send "o"
	Sleep 100
	Send "{left}"
	Send "{m 2}"
	Send "{right}"
}

;CTRL + ALT + d Dokumentationstrigger aus akzueller Zeile wird hochgezählt und darunter eine neue Zeile angelegt
;Es muss die vorherige Dokumentationsnummerierung markiert sein
^!d::
{
	Send "^c"
	Send "{SHIFTUP}"
	Sleep 100
	A_Clipboard := A_Clipboard + 1
	clip := round(A_Clipboard, 2)
	today := FormatTime(, "dd.MM.yyyy")
	Send "{End}{Enter}" clip "{Tab 2}P0xxx{Tab 3}" GetInitials() "{Tab 3}" today "{right 2}"
	clip := ""
}

;CTRL + g Globale Variablen aufrufen 
^g::
{
	Send "!a" 
	Send "b" 
}

;CTRL + l Lokale Variablen aufrufen 
^l::
{
	Send "!a"
	Send "a"
}


; CTRL + # Dokumentationsbereich einfügen
^#::
{
	Send "// " GetFirstLetter() " "
}

; CTRL + d Aktuelle Zeile kopieren
^d::
{
	KeyWait "Control" 
	Send "{Home}"
	Send "+{END}"
	Send "^c"
	Clipwait(10)
	Send "{END}"
	SEND "{Enter}"
	KeyWait "Control"
	KeyWait "Enter"
	KeyWait "Shift"
	Sleep(50)
	SEND "^v"
	
}



;################# Hot Strings #########################

; :*B0:BEGIN::END;{Left 4}

::d#::
{
	today := FormatTime(, "dd.MM.yyyy")
	Send  today
}

:*O:vl#::VALIDATE();{Left 2}

:*O:tf#::TESTFIELD();{Left 2}


:*:ff#::FINDFIRST;

:*:fl#::FINDLAST;

:*:if#::
{
    Send "IF () THEN BEGINEND;{Left 4}{Enter 2}{UP 2}"
	Sleep 50
	Send "{Right 4}"
}


:*:re#::
{
	Send "repeat {Enter}"
}

:*:un#::
{
	Send "Until .next = 0;{Left 10}"
}


:O*:sr#::SETRANGE();{Left 2}

:O*:srr#::
{	
	A_Clipboard := ""
	Send "^{left}"
	Send "{CTRLDOWN}{SHIFTDOWN}{RIGHT}"
	Send "^c"
	Send "{CTRLUP}{SHIFTUP}{End}"
	Send "RESET;{Enter}"
	clipwait(2)
	Send A_Clipboard
    Send ".SETRANGE(); {Left 3}"
}

:O*:sf#::SETFILTER(); {Left 3}

:O*://(::             ;DokuTag eröffnen
{
	Send "{Enter}//" GetFirstLetter() " B//" GetFirstLetter() " E{Left 7}{Enter 2}{Up}"
}

:O*:fs#::
{
	A_Clipboard := ""
	Send "^{left}"
	Send "{CTRLDOWN}{SHIFTDOWN}{RIGHT}"
	Send "^c"
	Send "{CTRLUP}{SHIFTUP}{End}"
	Send "findset then repeat"
	Send "{Enter}"
	Clipwait(2)
	Send "until " A_Clipboard
	Send ".next = 0;"
	Send "{Right 10}{Up}{Enter}{Space}{Space}"
}


:*:doc#::            
{
	clip := A_Clipboard + 1
	clip := round(clip, 2)
	today := FormatTime(, "dd.MM.yyyy")
	Send "{End}{Enter}" clip "{Tab 2}P0XXX{Tab 3}" GetInitials() "{Tab 3}" today "{Right 2}"
}

;Hotstring für komplett neuen Docu-Trigger
:*:ndoc#::            
{
	today := FormatTime(, "dd.MM.yyyy")
	Send "{= 133}{Enter}"
	Send "No.     Module    Name    Date        Description"
	Send "{END}{Enter}{= 133}{Enter}"
	Send "1.00    P0XXX{Tab 3}" GetInitials() "    	" today "{Right 2}  "
}

;:*?O:(::(){Left}
