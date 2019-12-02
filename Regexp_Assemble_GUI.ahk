#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui, Add, Edit, Vinputtext x12 y10 w450 h320 , ここに改行区切りのテキストを入力してください
Gui, Add, Button, gExec x362 y340 w100 h30 , OK
; Generated using SmartGUI Creator 4.0
Gui, Show, x127 y87 h379 w479, テキスト入力ウィンドウ
Return

;;; Main
Exec:

; 入力されたテキストを変数に代入
Gui, Submit, NoHide

; 変数の値をクリップボードにコピー
Clipboard = %inputtext%
ClipWait,1
;MsgBox, %Clipboard%
Sleep, 30

cmd = wperl Regexp_Assemble.pl
Run , %cmd%

Return

GuiClose:
ExitApp