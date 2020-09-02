#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui, Add, Edit, Vinputtext x12 y10 w450 h320
Gui, Add, Button, gExec x362 y340 w100 h30 , OK
; Generated using SmartGUI Creator 4.0
Gui, Show, x127 y87 h379 w479, Text entry window
Return

;;; Main
Exec:

; Assign the text entered to a variable
Gui, Submit, NoHide

; Copy the value of the variable to the clipboard
Clipboard = %inputtext%
ClipWait,1
;MsgBox, %Clipboard%
Sleep, 30

cmd = wperl Regexp_Assemble.pl
Run , %cmd%

Return

GuiClose:
ExitApp
