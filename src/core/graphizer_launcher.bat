@echo off
mode 200,500
call config.bat
title BatOS
color 07
:grst
cls
call cocolor.dll 10 "Graphizer"
call cocolor.dll %dcolor% "  Wpisz " 07 ".done" %dcolor% ", by powr¢ci†."
call cocolor.dll 07
call graphizer.bat -list
echo.
set /p "graphizerins=Liczba: "
if %graphizerins%==.done goto exit
cls
call cocolor.dll 10 "Graphizer"
echo. &echo.
call graphizer.bat -%graphizerins%
pause >nul
goto grst
:exit
exit