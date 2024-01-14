#Requires AutoHotkey v2.0

; 1.00  JN 14.01.2023   Erster Release
;                       - Programm dient dazu, um aus Excelspalten schnell eine Navision-tauglichen Filtertext zu erstellen
;                       - erstellter Filtertext wird dann in Zwischenablage kopiert und im TRAY angezeigt WIN 10 + WIN11        
; 2.00  JN 14.01.2023 neue Tastenkombination STRG + WIN + C 
; Veröffentlicht auf Github

;Beschreibung Hotstring Symbole

;	*  	- bedeutet es muss kein Endzeichen gesetzt werden also ohne Leertaste TAB oder Enter
;	B0	- Backspace wird nicht ausgeführt. also der zuvor eingegebene Befehl wird nicht gelöscht. @sr ergibt  @sr SETRANGE(); 
;	O	- es wird kein Leerzeichen nach dem {Left 2} ausgeführt setrange(); anstatt setrange( );
;	?	- der Hotstring kann mitten in einem anderen Wort stehen

; ^   entspricht der Steuerung - Taste
; !   entspricht der Alt Taste
; +   entspricht der Shift Taste
; #   entspricht der Windows Taste
;################# Hot Key's #########################

; Kopiert den ausgewählen Text(Excel) Zellen und ersetzt Umbrüche und Leerzeichen durch Pipe
^!c::
{
    Send "^c"
    Clipwait(10)
    KeyWait "Control"
	KeyWait "Alt"
	KeyWait "c"
    no := 0
    clip := RegExReplace(A_Clipboard, "\s", "|")
     ; Doppelte Pipes entfernen
    While InStr(clip, "||")
        {
          clip := StrReplace(clip, "||", "|")
        }
    IF (substr(clip, strlen(clip), 1) = "|")
        {
          clip := substr(clip, 1 , strlen(clip)-1)   
        }
    A_Clipboard := clip
    TrayTip "Neue Zwischenablage: " clip
    
}

; Kopiert den ausgewählen Text(Excel) Zellen und ersetzt Umbrüche und Leerzeichen durch Pipe mit 
; zusätzlichem @*
^#c::
{
    Send "^c"
    Clipwait(10)
    KeyWait "Control"
	KeyWait "Alt"
	KeyWait "c"
    no := 0
    ; Regex Leerzeichen Zeilenumbrüche durch Pipe ersetzen
    clip := RegExReplace(A_Clipboard, "\s", "|")
    ; Doppelte Pipes entfernen
    While InStr(clip, "||")
        {
          clip := StrReplace(clip, "||", "|")
        }
    
    ; Letztes Pipe entfernen
    IF (substr(clip, strlen(clip), 1) = "|")
        {
          clip := substr(clip, 1 , strlen(clip)-1)   
        }
    ; Vorn ran ein @* setzen
    clip := StrReplace(clip, "|", "|@*")
    
    ; Zwischenablage neu setzen
    A_Clipboard := clip
    TrayTip "Neue Zwischenablage: " clip
    
}

HotIfWinActive "ahk_exe CDViewer.exe"
Hotkey "!^Home", ToggleWordWrap  ; STRG + ALT + Home 

ToggleWordWrap(ThisHotkey)
{
    KeyWait "Control"
	KeyWait "Alt"
	Send "^!{CtrlBreak}"
	Sleep (50)
	Send "h"
}
