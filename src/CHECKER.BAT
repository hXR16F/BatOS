@ECHO OFF
TITLE ^| CHECKER ^|
COLOR 1F
:ONSTART
CLS
	IF NOT EXIST "BatOS.bat" SET FILE=BatOS.bat &GOTO ERROR
	IF NOT EXIST "drawdesktop.bat" SET FILE=drawdesktop.bat &GOTO ERROR
	IF NOT EXIST "fastcleaner.bat" SET FILE=fastcleaner.bat &GOTO ERROR
	IF NOT EXIST "graphizer_launch.bat" SET FILE=graphizer_launch.bat &GOTO ERROR
	IF NOT EXIST "logo.bat" SET FILE=BatOS.bat &GOTO ERROR
CD core
	IF NOT EXIST "asc_logo_programu.txt" SET FILE=asc_logo_programu.txt &GOTO ERROR
	IF NOT EXIST "choice32.COM" SET FILE=choice32.com &GOTO ERROR
	IF NOT EXIST "choice64.dll" SET FILE=choice64.dll &GOTO ERROR
	IF NOT EXIST "cocolor.dll" SET FILE=cocolor.dll &GOTO ERROR
	IF NOT EXIST "config.bat" SET FILE=config.bat &GOTO ERROR
	IF NOT EXIST "converter.dll" SET FILE=converter.dll &GOTO ERROR
	IF NOT EXIST "Converter.ini" SET FILE=converter.ini &GOTO ERROR
	IF NOT EXIST "drawlogo.bat" SET FILE=drawlogo.bat &GOTO ERROR
	IF NOT EXIST "edit.com" SET FILE=edit.com &GOTO ERROR
	IF NOT EXIST "edit.hlp" SET FILE=edit.hlp &GOTO ERROR
	IF NOT EXIST "Full.com" SET FILE=full.com &GOTO ERROR
	IF NOT EXIST "graphizer.bat" SET FILE=graphizer.bat &GOTO ERROR
	IF NOT EXIST "graphizer_launcher.bat" SET FILE=graphizer_launcher.bat &GOTO ERROR
	IF NOT EXIST "logo_programu.bmp" SET FILE=logo_programu.bmp &GOTO ERROR
	IF NOT EXIST "memory.dll" SET FILE=memory.dll &GOTO ERROR
	IF NOT EXIST "mouse.dll" SET FILE=mouse.dll &GOTO ERROR
	IF NOT EXIST "pomoc.hlp" SET FILE=pomoc.hlp &GOTO ERROR
	IF NOT EXIST "spacebar.bat" SET FILE=spacebar.bat &GOTO ERROR
	IF NOT EXIST "system.dll" SET FILE=system.dll &GOTO ERROR
	IF NOT EXIST "tftp.dll" SET FILE=tftp.dll &GOTO ERROR
	IF NOT EXIST "wait.dll" SET FILE=wait.dll &GOTO ERROR
	IF NOT EXIST "WBAT.COM" SET FILE=wbat.com &GOTO ERROR
EXIT /B

:ERROR
ECHO Brak pliku %file%lub nazwa jest niepoprawna.
ECHO Brak pliku %file%lub nazwa jest niepoprawna w dniu %date% o godzinie %time%. >> log.txt
PING localhost -n 3 > NUL
EXIT