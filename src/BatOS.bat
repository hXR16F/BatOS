:: Programy hXR 16F

:: /// KONFIGURACJE \\\ ::
@echo off

set config="core\config.bat"
call %config%

	cd > defaultpath.dat
	set /P defaultpath= < "defaultpath.dat"
		
	echo Ostatnio uruchomiony w %date% o godzinie %time%. > log.txt

set ph=28 godzin
set version=1.0b
set exidate=5 wrze˜nia 2015

set drawdesktop0=call kolorpulpitu.bat
set drawdesktop1=%wbat% fill 1,1 (25,1) (on white)
set drawdesktop2=%wbat% fill 25,1 (1,80) (on white)
set drawdesktop3=%wbat% text 25,68 "%date%"
set drawdesktop4=%wbat% fill 1,1 (1,80) (on white)
:: // drawdesktop5 w sekcji logowania \\ ::
set drawdesktop6=%wbat% fill 1,80 (25,1) (on white)
set drawdesktop7=%wbat% text 1,80 (white on red) "X"
set drawdesktop8=%wbat% text 1,9 "BatOS"
set drawdesktop9=%wbat% text 1,79 (white on blue) "X"

set drawdesktop=call drawdesktop.bat

	ping localhost -n 2 > nul

		:: /// DETEKCJA 64 BITOWEGO SYSTEMU \\\ ::
		if exist "%SystemRoot%\Sysnative\" goto bitdetected
		goto bitnext
		:bitdetected
		title /// INFORMACJA ///
		cls
		echo Posiadanie 64 bitowej wersji systemu spowoduje, ¾e program nie zadziaˆa.
		pause
		goto bitnext
		
	:bitnext
	title BatOS
	%full%
	mode %window%
	
	:: /// LADOWANIE \\\ ::
	:startuplodading
		color 07
		cls
		echo Trwa buforowanie programu, prosz© czeka†...
		ping localhost -n 5 > nul
		goto startup
	
	:: /// START PROGRAMU \\\ ::
	:startup
		cls
		
		%wbat% box @core\system.dll:mglowne
		if %errorlevel%==1 goto login
		if %errorlevel%==2 goto exitsys
		if %errorlevel%==3 goto info
	goto startup

:: /// LOGIN \\\ :: /// WERYFIKACJA \\\ ::
:login
	cls
	%cocolor% 10 "Logowanie do programu" 90 " BatOS "
	%cocolor% %dcolor% "  Wpisz " 07 ".newuser" %dcolor% ", by utworzy† nowego u¾ytkownika."
	%cocolor% %dcolor% "  Wpisz " 07 ".deluser" %dcolor% ", by usun¥† u¾ytkownika."
	%cocolor% %dcolor% "  Wpisz " 07 ".renuser" %dcolor% ", by zmieni† nazw© u¾ytkownika."
	%cocolor% %dcolor% "  Wpisz " 07 ".list" %dcolor% ", by zobaczy† list© u¾ytkownik¢w."
	%cocolor% %dcolor% "  Wpisz " 07 ".done" %dcolor% ", by powr¢cic."
	echo.
	set /P "osusername=Nazwa u¾ytkownika: "
		if %osusername%==.newuser goto newuser
		if %osusername%==.deluser goto deluser
		if %osusername%==.renuser goto renuser
		if %osusername%==.list goto userlist
		if %osusername%==.done goto startup
	set /P "osuserpass=Haslo: "
		if %osuserpass%==.newuser goto newuser
		if %osusername%==.deluser goto deluser
		if %osusername%==.renuser goto renuser
		if %osusername%==.list goto userlist
		if %osuserpass%==.done goto startup
		:verify
		if exist "core\users\%osusername%\%osuserpass%" goto usernext
		echo. &echo Nieprawidˆowa nazwa lub hasˆo.
		ping localhost -n 3 > nul &goto login
		:usernext
			set drawdesktop5=%wbat% text 1,63 "%osusername%"
		if exist "core\users\%osusername%\%osuserpass%" goto zalogowano
		goto login
		
		:: /// NOWY UZYTKOWNIK \\\ ::
		:newuser
		cls
		%cocolor% 10 "Tworzenie nowego u¾ytkownika" 
		%cocolor% %dcolor% "  Wpisz "  07 ".done"  %dcolor% ", by powr¢cic."
		%cocolor% %dcolor% "  Je˜li nazwa b©dzie wynosi† "  07 "wi©cej ni¾ 16 cyfr "  %dcolor% "mog¥ wyst©powac bˆ©dy."
		echo.
		set /P "osusernamenew=Nazwa nowego u¾ytkownika: "
		if %osusernamenew%==.done goto login
		if exist "core\users\%osusernamenew%" goto ososuserexist
		set /P "osuserpassnew=Hasˆo nowego u¾ytkownika: "
			md "core\users\%osusernamenew%"
			md "core\users\%osusernamenew%\%osuserpassnew%"
		echo.
		%cocolor% %dcolor% "Pomy˜lnie zaˆo¾ono konto " 07 "%osusernamenew%"
		ping localhost -n 3 > nul
		goto login
		
		:: /// WELCOME \\\ ::
		:zalogowano
		cls
		%wbat% text 12,29 "Buforowanie pulpitu..."
		
		if exist "kolorpulpitucolor" goto zalogowanonext
			echo set desktopcolor=17 > "kolorpulpitu.bat"
		ping localhost -n 3 > nul
		call "kolorpulpitu.bat"
		:zalogowanonext
		ping localhost -n 4 > nul
		goto desktop
		
		:: /// JESLI UZYTKOWNIK ISTNIEJE \\\ ::
		:osuserexist
		%cocolor% %dcolor% "U¾ytkownik " 07 "%osusernamenew%" %dcolor% " ju¾ istnieje."
		ping localhost -n 3 > nul
		goto newuser
		
		:: /// JESLI UZYTKOWNIK NIE ISTNIEJE \\\ ::
		:osusernotexist
		%cocolor% %dcolor% "U¾ytkownik " 07 "%osusernamenew%"  %dcolor% " nie istnieje."
		ping localhost -n 3 > nul
		goto deluser
		
		:: /// USUWANIE UZYTKOWNIKA \\\ ::
		:deluser
		cls
		%cocolor% 10 "Usuwanie u¾ytkownika" 
		%cocolor% %dcolor% "  Wpisz " 07 ".done" %dcolor% ", by powr¢cic."
		echo.
		set /P "osusernamedel=Nazwa u¾ytkownika: "
		if %osusernamedel%==.done goto login
		if not exist "core\users\%osusernamedel%" goto osusernotexist
		echo.
		%cocolor% %dcolor% "Czy napewno chcesz usun¥c u¾ytkownika " 07 "%osusernamedel%" %dcolor% " ? (T/N) "
		set /P conosuserdel="
		if %conosuserdel%==T goto userdel
		if %conosuserdel%==N goto usernotdel
		if %conosuserdel%==t goto userdel
		if %conosuserdel%==n goto usernotdel
		if %conosuserdel%==1 goto userdel
		if %conosuserdel%==0 goto usernotdel
		goto delosuser
		
		:: /// LISTA WSZYSTKICH UZYTKOWNIKOW \\\ ::
		:userlist
		cls
		%cocolor% 10 "Lista wszystkich u¾ytkownik¢w" 
		%cocolor% 07
		echo.
		dir "core\users"
		echo.
		pause > nul
		goto login
		
		:: /// ZMIANA NAZWY UZYTKOWNIKA \\\ ::
		:renuser
		cls
		%cocolor% 10 "Zmiana nazwy u¾ytkownika" 
		%cocolor% %dcolor% "  Wpisz " 07 ".done"  %dcolor% ", by powr¢cic."
		echo.
		set /P "osusernameren=Nazwa u¾ytkownika: "
		if exist "core\users\%osusernameren%" goto renusernext
		echo. 
		%cocolor% %dcolor% "U¾ytkownik " 07 "%osusernameren% " %dcolor% "nie istnieje."
		ping localhost -n 3 > nul
		goto login
		:renusernext
		set /P "osusernamerenpass=Hasˆo u¾ytkownika: "
		if exist "core\users\%osusernameren%\%osusernamerenpass%" goto renusernext2
		echo.
		%cocolor% 07 "Nieprawidˆowe hasˆo." 
		ping localhost -n 3 > nul
		goto login
		:renusernext2
		echo.
		set /P "osusernamerennew=Nowa nazwa u¾ytkownika: "
		rd /S /Q "core\users\%osusernameren%
		md "core\users\%osusernamerennew%
		md "core\users\%osusernamerennew%\%osusernamerenpass%
		echo.
		%cocolor% %dcolor% "Zmieniono nazw© " 07 "%osusernameren% " %dcolor% "na "  07 "%osusernamerennew% " %dcolor% "."
		ping localhost -n 3 > nul
		goto login
		
		:userdel
		echo.
		rd /S /Q "core\users\%osusernamedel%
		%cocolor% %dcolor% "U¾ytkownik " 07 "%osusernamedel%" %dcolor% " zostaˆ usuni©ty."
		ping localhost -n 3 > nul
		goto login
	
		:usernotdel
		echo.
		%cocolor% %dcolor% "Usuwanie u¾ytkownika " 07 "%osusernamedel%" %dcolor% " zostaˆo anulowane."
		ping localhost -n 3 > nul
		goto login
		
		:: /// INFORMACJE ZE STARTUP \\\ ::
		:info
		%wbat% box @core\pomoc.hlp:info
		if %errorlevel%==1 goto startup
		if %errorlevel%==2 goto pomoc
		goto info
		
		:: /// POMOC \\\ ::
		:pomoc
		%wbat% box @core\pomoc.hlp:pomoc
		if %errorlevel%==1 goto info
		if %errorlevel%==2 goto pomoc
		if %errorlevel%==3 goto pomoc2
		if %errorlevel%==4 goto pomoc3
		if %errorlevel%==5 goto pomoc4
		if %errorlevel%==6 goto pomoc4.1
		goto pomoc
		:pomoc2
		%wbat% box @core\pomoc.hlp:pomoc2
		if %errorlevel%==1 goto info
		if %errorlevel%==2 goto pomoc
		if %errorlevel%==3 goto pomoc2
		if %errorlevel%==4 goto pomoc3
		if %errorlevel%==5 goto pomoc4
		if %errorlevel%==6 goto pomoc4.1
		goto pomoc2
		:pomoc3
		%wbat% box @core\pomoc.hlp:pomoc3
		if %errorlevel%==1 goto info
		if %errorlevel%==2 goto pomoc
		if %errorlevel%==3 goto pomoc2
		if %errorlevel%==4 goto pomoc3
		if %errorlevel%==5 goto pomoc4
		if %errorlevel%==6 goto pomoc4.1
		goto pomoc3
		:pomoc4
		%wbat% box @core\pomoc.hlp:pomoc4
		if %errorlevel%==1 goto info
		if %errorlevel%==2 goto pomoc
		if %errorlevel%==3 goto pomoc2
		if %errorlevel%==4 goto pomoc3
		if %errorlevel%==5 goto pomoc4
		if %errorlevel%==6 goto pomoc4.1
		goto pomoc4
		:pomoc4.1
		%wbat% box @core\pomoc.hlp:pomoc4.1
		if %errorlevel%==1 goto info
		if %errorlevel%==2 goto pomoc
		if %errorlevel%==3 goto pomoc2
		if %errorlevel%==4 goto pomoc3
		if %errorlevel%==5 goto pomoc4
		if %errorlevel%==6 goto pomoc4.1
		goto pomoc4.1
		
		:: /// SZYBKIE ZAMKNIECIE \\\ ::
		:exitsys
		exit
		
		:: /// PULPIT \\\ ::
		:desktop
		color %desktopcolor%
		cls
		
		%drawdesktop%
		
			for /F "tokens=1,2,3" %%W in ('"%mouse%"') do set /A "c=%%W,x=%%Y,y=%%X" > nul
			
			if %x%==0 (if %y%==1 (goto smenu ))
			if %x%==0 (if %y%==2 (goto smenu ))
			if %x%==0 (if %y%==3 (goto smenu ))
			if %x%==0 (if %y%==4 (goto smenu ))
			if %x%==0 (if %y%==5 (goto smenu ))
			if %x%==0 (if %y%==6 (goto smenu ))
			if %x%==0 (if %y%==7 (goto smenu ))
			if %x%==0 (if %y%==8 (goto smenu ))
			if %x%==0 (if %y%==9 (goto smenu ))
			if %x%==0 (if %y%==10 (goto smenu ))
			if %x%==0 (if %y%==11 (goto smenu ))
			if %x%==0 (if %y%==12 (goto smenu ))
			if %x%==0 (if %y%==13 (goto smenu ))
			if %x%==0 (if %y%==14 (goto smenu ))
			if %x%==0 (if %y%==15 (goto smenu ))
			if %x%==0 (if %y%==16 (goto smenu ))
			if %x%==0 (if %y%==17 (goto smenu ))
			if %x%==0 (if %y%==18 (goto smenu ))
			if %x%==0 (if %y%==19 (goto smenu ))
			if %x%==0 (if %y%==20 (goto smenu ))
			if %x%==0 (if %y%==21 (goto smenu ))
			if %x%==0 (if %y%==22 (goto smenu ))
			if %x%==0 (if %y%==23 (goto smenu ))
			
			if %x%==67 (if %y%==24 (goto showdate ))
			if %x%==68 (if %y%==24 (goto showdate ))
			if %x%==69 (if %y%==24 (goto showdate ))
			if %x%==70 (if %y%==24 (goto showdate ))
			if %x%==71 (if %y%==24 (goto showdate ))
			if %x%==72 (if %y%==24 (goto showdate ))
			if %x%==73 (if %y%==24 (goto showdate ))
			if %x%==74 (if %y%==24 (goto showdate ))
			if %x%==75 (if %y%==24 (goto showdate ))
			if %x%==76 (if %y%==24 (goto showdate ))
			
			if %x%==63 (if %y%==0 (goto useroptions ))
			if %x%==64 (if %y%==0 (goto useroptions ))
			if %x%==65 (if %y%==0 (goto useroptions ))
			if %x%==66 (if %y%==0 (goto useroptions ))
			if %x%==67 (if %y%==0 (goto useroptions ))
			if %x%==68 (if %y%==0 (goto useroptions ))
			if %x%==69 (if %y%==0 (goto useroptions ))
			if %x%==70 (if %y%==0 (goto useroptions ))
			if %x%==71 (if %y%==0 (goto useroptions ))
			if %x%==72 (if %y%==0 (goto useroptions ))
			if %x%==73 (if %y%==0 (goto useroptions ))
			if %x%==74 (if %y%==0 (goto useroptions ))
			if %x%==75 (if %y%==0 (goto useroptions ))
			if %x%==76 (if %y%==0 (goto useroptions ))
			if %x%==77 (if %y%==0 (goto useroptions ))
			
			if %x%==79 (if %y%==0 (goto shutoptions ))
			if %x%==78 (if %y%==0 (goto osoptions ))
			
			if %x%==8 (if %y%==0 (goto batosinfo ))
			if %x%==9 (if %y%==0 (goto batosinfo ))
			if %x%==10 (if %y%==0 (goto batosinfo ))
			if %x%==11 (if %y%==0 (goto batosinfo ))
			if %x%==12 (if %y%==0 (goto batosinfo ))
			
		goto desktop
		
		:: /// INFORMACJE O PROGRAMIE \\\ ::
		:batosinfo
		%wbat% fill 3,8 (13,29) (on +black)
		%wbat% text 4,10 "BatOS"
		%wbat% text 5,10 "Autor: hXR 16F"
		%wbat% text 6,10 "Wersja: %version%"
		
		%wbat% text 8,10 "Czas pracy nad t¥ wersj¥:"
		%wbat% text 9,10 "ok. %ph%"

		%wbat% text 11,10 "Data wydania:"
		%wbat% text 12,10 "%exidate%"
		
		%wbat% text 14,10 "[ Przeczytaj info ]"
		
		for /F "tokens=1,2,3" %%W in ('"%mouse%"') do set /A "c=%%W,x=%%Y,y=%%X" > nul
			if %x%==9 (if %y%==13 (goto readinfo ))
			if %x%==10 (if %y%==13 (goto readinfo ))
			if %x%==11 (if %y%==13 (goto readinfo ))
			if %x%==12 (if %y%==13 (goto readinfo ))
			if %x%==13 (if %y%==13 (goto readinfo ))
			if %x%==14 (if %y%==13 (goto readinfo ))
			if %x%==15 (if %y%==13 (goto readinfo ))
			if %x%==16 (if %y%==13 (goto readinfo ))
			if %x%==17 (if %y%==13 (goto readinfo ))
			if %x%==18 (if %y%==13 (goto readinfo ))
			if %x%==19 (if %y%==13 (goto readinfo ))
			if %x%==20 (if %y%==13 (goto readinfo ))
			if %x%==21 (if %y%==13 (goto readinfo ))
			if %x%==22 (if %y%==13 (goto readinfo ))
			if %x%==23 (if %y%==13 (goto readinfo ))
			if %x%==24 (if %y%==13 (goto readinfo ))
			if %x%==25 (if %y%==13 (goto readinfo ))
			if %x%==26 (if %y%==13 (goto readinfo ))
			if %x%==27 (if %y%==13 (goto readinfo ))
		goto desktop
		
		:readinfo
		cls
		%drawdesktop%
		%wbat% box @core\pomoc.hlp:info
		if %errorlevel%==1 goto desktop
		if %errorlevel%==2 goto pomocr
		goto readinfo
		
		:: /// POMOC \\\ ::
		:pomocr
		%wbat% box @core\pomoc.hlp:pomoc
		if %errorlevel%==1 goto readinfo
		if %errorlevel%==2 goto pomocr
		if %errorlevel%==3 goto pomoc2r
		if %errorlevel%==4 goto pomoc3r
		if %errorlevel%==5 goto pomoc4r
		if %errorlevel%==6 goto pomoc4.1r
		goto pomocr
		:pomoc2r
		%wbat% box @core\pomoc.hlp:pomoc2
		if %errorlevel%==1 goto readinfo
		if %errorlevel%==2 goto pomocr
		if %errorlevel%==3 goto pomoc2r
		if %errorlevel%==4 goto pomoc3r
		if %errorlevel%==5 goto pomoc4r
		if %errorlevel%==6 goto pomoc4.1r
		goto pomoc2r
		:pomoc3r
		%wbat% box @core\pomoc.hlp:pomoc3
		if %errorlevel%==1 goto readinfo
		if %errorlevel%==2 goto pomocr
		if %errorlevel%==3 goto pomoc2r
		if %errorlevel%==4 goto pomoc3r
		if %errorlevel%==5 goto pomoc4r
		if %errorlevel%==6 goto pomoc4.1r
		goto pomoc3r
		:pomoc4r
		%wbat% box @core\pomoc.hlp:pomoc4
		if %errorlevel%==1 goto readinfo
		if %errorlevel%==2 goto pomocr
		if %errorlevel%==3 goto pomoc2r
		if %errorlevel%==4 goto pomoc3r
		if %errorlevel%==5 goto pomoc4r
		if %errorlevel%==6 goto pomoc4.1r
		goto pomoc4r
		:pomoc4.1r
		%wbat% box @core\pomoc.hlp:pomoc4.1
		if %errorlevel%==1 goto readinfo
		if %errorlevel%==2 goto pomocr
		if %errorlevel%==3 goto pomoc2r
		if %errorlevel%==4 goto pomoc3r
		if %errorlevel%==5 goto pomoc4r
		if %errorlevel%==6 goto pomoc4.1r
		goto pomoc4.1r
		
		:: /// OPCJE PROGRAMU \\\ ::
		:osoptions
		%wbat% box @core\system.dll:osoptions
		if %errorlevel%==1 goto desktopsettings
		if %errorlevel%==2 goto desktop
		goto osoptions
		
		:desktopsettings
		%wbat% box @core\system.dll:desktopsettings
		if %errorlevel%==1 goto desktopcolorsettings
		if %errorlevel%==2 goto desktop
		goto desktopsettings
		
		:desktopcolorsettings
		cls
		%drawdesktop%
		
		%wbat% box @core\system.dll:desktopcolorsettings
		if %errorlevel%==1 echo set desktopcolor=07 > kolorpulpitu.bat
		if %errorlevel%==2 echo set desktopcolor=87 > kolorpulpitu.bat
		if %errorlevel%==3 echo set desktopcolor=17 > kolorpulpitu.bat
		if %errorlevel%==4 echo set desktopcolor=97 > kolorpulpitu.bat
		if %errorlevel%==5 echo set desktopcolor=27 > kolorpulpitu.bat
		if %errorlevel%==6 echo set desktopcolor=A7 > kolorpulpitu.bat
		if %errorlevel%==7 echo set desktopcolor=37 > kolorpulpitu.bat
		if %errorlevel%==8 echo set desktopcolor=B7 > kolorpulpitu.bat
		if %errorlevel%==9 echo set desktopcolor=47 > kolorpulpitu.bat
		if %errorlevel%==10 echo set desktopcolor=C7 > kolorpulpitu.bat
		if %errorlevel%==11 echo set desktopcolor=57 > kolorpulpitu.bat
		if %errorlevel%==12 echo set desktopcolor=D7 > kolorpulpitu.bat
		if %errorlevel%==13 echo set desktopcolor=67 > kolorpulpitu.bat
		if %errorlevel%==14 echo set desktopcolor=E7 > kolorpulpitu.bat
		if %errorlevel%==15 %wbat% box @core\system.dll:settingsdesktopbgcantchange
		if %errorlevel%==16 echo set desktopcolor=F7 > kolorpulpitu.bat
		if %errorlevel%==17 goto desktop
		goto desktopcolorsettings
		
		:: /// OPCJE ZASILANIA \\\ ::
		:shutoptions
		%wbat% box @core\system.dll:shutoptions
		if %errorlevel%==1 goto zamknij
		if %errorlevel%==2 goto restart
		if %errorlevel%==3 goto wyloguj
		if %errorlevel%==4 goto desktop
		goto shutoptions
		
		:zamknij
		ping localhost -n 2 > nul
			color 07
			ping localhost -n 3 > nul
			cls
			%wbat% text 4,12 "Zamykanie..."
			ping localhost -n 4 > nul
			cls
			ping localhost -n 1 > nul
			goto exitsys
			
		:restart
		ping localhost -n 2 > nul
			color 07
			ping localhost -n 3 > nul
			cls
			%wbat% text 4,12 "Restartowanie..."
			ping localhost -n 5 > nul
			cls
			call %config%
			ping localhost -n 1 > nul
			goto startup
			
		:wyloguj
		ping localhost -n 2 > nul
			color 07
			ping localhost -n 1 > nul
			cls
			%wbat% text 3,12 "Wylogowywanie..."
			ping localhost -n 2 > nul
			cls
			call %config%
			ping localhost -n 1 > nul
			goto login
		
		
		:: /// OPCJE UZYTKOWNIKA \\\ ::
		:useroptions
		%wbat% box "Usuni©cie lub zmienienie czego˜ poskutkuje utraceniem danych." OK
		if %errorlevel%==1 goto useroptionsnext
		goto useroptions
		:useroptionsnext
		%wbat% fill 3,39 (6,39) (on +black)
		
		%wbat% text 4,41 "Zarz¥dzanie kontem %osusername%"
		%wbat% text 6,41 "Usuä konto"
		%wbat% text 7,41 "Zmieä nazw©"
		
		for /F "tokens=1,2,3" %%W in ('"%mouse%"') do set /A "c=%%W,x=%%Y,y=%%X" > nul
		
			if %x%==40 (if %y%==5 (goto currentuserdel ))
			if %x%==41 (if %y%==5 (goto currentuserdel ))
			if %x%==42 (if %y%==5 (goto currentuserdel ))
			if %x%==43 (if %y%==5 (goto currentuserdel ))
			if %x%==44 (if %y%==5 (goto currentuserdel ))
			if %x%==45 (if %y%==5 (goto currentuserdel ))
			if %x%==46 (if %y%==5 (goto currentuserdel ))
			if %x%==47 (if %y%==5 (goto currentuserdel ))
			if %x%==48 (if %y%==5 (goto currentuserdel ))
			if %x%==49 (if %y%==5 (goto currentuserdel ))
			
			if %x%==40 (if %y%==6 (goto currentuserren ))
			if %x%==41 (if %y%==6 (goto currentuserren ))
			if %x%==42 (if %y%==6 (goto currentuserren ))
			if %x%==43 (if %y%==6 (goto currentuserren ))
			if %x%==44 (if %y%==6 (goto currentuserren ))
			if %x%==45 (if %y%==6 (goto currentuserren ))
			if %x%==46 (if %y%==6 (goto currentuserren ))
			if %x%==47 (if %y%==6 (goto currentuserren ))
			if %x%==48 (if %y%==6 (goto currentuserren ))
			if %x%==49 (if %y%==6 (goto currentuserren ))
			if %x%==50 (if %y%==6 (goto currentuserren ))
			
			goto desktop
			
			:currentuserdel
			cls
			%drawdesktop%
			
			:currentuserdelnext
			%wbat% box "Czy napewno chcesz usun¥† konto?" Tak, Nie
			if %errorlevel%==1 goto okdel
			if %errorlevel%==2 goto desktop
			goto currentuserdelnext
			:okdel
			rd /S /Q "core\users\%osusername%"
			%wbat% box "Konieczny jest restart" OK, P¢«niej
			if %errorlevel%==1 goto restart
			if %errorlevel%==2 goto desktop
			goto okdel
			
			:currentuserren
			cls
			set zmmemory=
			%drawdesktop%
			
			:currentuserrennext1
			%wbat% box @core\system.dll:currentuserrenl
			
			if %errorlevel%==1 set zmmemory=%zmmemory%1
			if %errorlevel%==2 set zmmemory=%zmmemory%2
			if %errorlevel%==3 set zmmemory=%zmmemory%3
			if %errorlevel%==4 set zmmemory=%zmmemory%4
			if %errorlevel%==5 set zmmemory=%zmmemory%5
			if %errorlevel%==6 set zmmemory=%zmmemory%6
			if %errorlevel%==7 set zmmemory=%zmmemory%7
			if %errorlevel%==8 set zmmemory=%zmmemory%8
			if %errorlevel%==9 set zmmemory=%zmmemory%9
			if %errorlevel%==10 set zmmemory=%zmmemory%0
			if %errorlevel%==11 set zmmemory=%zmmemory%Q
			if %errorlevel%==12 set zmmemory=%zmmemory%W
			if %errorlevel%==13 set zmmemory=%zmmemory%E
			if %errorlevel%==14 set zmmemory=%zmmemory%R
			if %errorlevel%==15 set zmmemory=%zmmemory%T
			if %errorlevel%==16 set zmmemory=%zmmemory%Y
			if %errorlevel%==17 set zmmemory=%zmmemory%U
			if %errorlevel%==18 set zmmemory=%zmmemory%I
			if %errorlevel%==19 set zmmemory=%zmmemory%O
			if %errorlevel%==20 set zmmemory=%zmmemory%P
			if %errorlevel%==21 set zmmemory=%zmmemory%A
			if %errorlevel%==22 set zmmemory=%zmmemory%S
			if %errorlevel%==23 set zmmemory=%zmmemory%D
			if %errorlevel%==24 set zmmemory=%zmmemory%F
			if %errorlevel%==25 set zmmemory=%zmmemory%G
			if %errorlevel%==26 set zmmemory=%zmmemory%H
			if %errorlevel%==27 set zmmemory=%zmmemory%J
			if %errorlevel%==28 set zmmemory=%zmmemory%K
			if %errorlevel%==29 set zmmemory=%zmmemory%L
			if %errorlevel%==30 set zmmemory=%zmmemory%Z
			if %errorlevel%==31 set zmmemory=%zmmemory%X
			if %errorlevel%==32 set zmmemory=%zmmemory%C
			if %errorlevel%==33 set zmmemory=%zmmemory%V
			if %errorlevel%==34 set zmmemory=%zmmemory%B
			if %errorlevel%==35 set zmmemory=%zmmemory%N
			if %errorlevel%==36 set zmmemory=%zmmemory%M
			if %errorlevel%==37 goto currentuserrennext2
			if %errorlevel%==38 goto currentuserrenok
			if %errorlevel%==39 set zmmemory=
			if %errorlevel%==40 goto desktop
			goto currentuserrennext1
			
			:currentuserrennext2
			%wbat% box @core\system.dll:currentuserrens
			
			if %errorlevel%==1 set zmmemory=%zmmemory%1
			if %errorlevel%==2 set zmmemory=%zmmemory%2
			if %errorlevel%==3 set zmmemory=%zmmemory%3
			if %errorlevel%==4 set zmmemory=%zmmemory%4
			if %errorlevel%==5 set zmmemory=%zmmemory%5
			if %errorlevel%==6 set zmmemory=%zmmemory%6
			if %errorlevel%==7 set zmmemory=%zmmemory%7
			if %errorlevel%==8 set zmmemory=%zmmemory%8
			if %errorlevel%==9 set zmmemory=%zmmemory%9
			if %errorlevel%==10 set zmmemory=%zmmemory%0
			if %errorlevel%==11 set zmmemory=%zmmemory%q
			if %errorlevel%==12 set zmmemory=%zmmemory%w
			if %errorlevel%==13 set zmmemory=%zmmemory%e
			if %errorlevel%==14 set zmmemory=%zmmemory%r
			if %errorlevel%==15 set zmmemory=%zmmemory%t
			if %errorlevel%==16 set zmmemory=%zmmemory%y
			if %errorlevel%==17 set zmmemory=%zmmemory%u
			if %errorlevel%==18 set zmmemory=%zmmemory%i
			if %errorlevel%==19 set zmmemory=%zmmemory%o
			if %errorlevel%==20 set zmmemory=%zmmemory%p
			if %errorlevel%==21 set zmmemory=%zmmemory%a
			if %errorlevel%==22 set zmmemory=%zmmemory%s
			if %errorlevel%==23 set zmmemory=%zmmemory%d
			if %errorlevel%==24 set zmmemory=%zmmemory%f
			if %errorlevel%==25 set zmmemory=%zmmemory%g
			if %errorlevel%==26 set zmmemory=%zmmemory%h
			if %errorlevel%==27 set zmmemory=%zmmemory%j
			if %errorlevel%==28 set zmmemory=%zmmemory%k
			if %errorlevel%==29 set zmmemory=%zmmemory%l
			if %errorlevel%==30 set zmmemory=%zmmemory%z
			if %errorlevel%==31 set zmmemory=%zmmemory%x
			if %errorlevel%==32 set zmmemory=%zmmemory%c
			if %errorlevel%==33 set zmmemory=%zmmemory%v
			if %errorlevel%==34 set zmmemory=%zmmemory%b
			if %errorlevel%==35 set zmmemory=%zmmemory%n
			if %errorlevel%==36 set zmmemory=%zmmemory%m
			if %errorlevel%==37 goto currentuserrennext1
			if %errorlevel%==38 goto currentuserrenok
			if %errorlevel%==39 set zmmemory=
			if %errorlevel%==40 goto desktop
			goto currentuserrennext2
			
			:currentuserrenok
			rd /S /Q "core\users\%osusername%"
			md "core\users\%zmmemory%"
			md "core\users\%zmmemory%\%osuserpass%"
			%wbat% box "Konieczny jest restart" OK, P¢«niej
			if %errorlevel%==1 goto restart
			if %errorlevel%==2 goto desktop
			goto currentuserrenok

		:: /// ROZWIJAJACE SIE MENU \\\ ::
		:smenu
		%wbat% fill 1,1 (25,21) (on +black)
		%wbat% fill 1,22 (25,1) (on white)
		
		%wbat% text 2,2 "Wszystkie programy"
		%wbat% text 3,2 "-------------------"
		%wbat% text 4,2 "Notatnik (edit.com)"
		%wbat% text 5,2 "Kalkulator"
		%wbat% text 6,2 "Randomer"
		%wbat% text 7,2 "Litera"
		%wbat% text 8,2 "Notatnik"
		%wbat% text 9,2 "Paint"
		%wbat% text 10,2 "Spacebar"
		%wbat% text 11,2 "CMD"
		%wbat% text 12,2 "Graphizer"
		%wbat% text 13,2 "Stoper"
		
			for /F "tokens=1,2,3" %%W in ('"%mouse%"') do set /A "c=%%W,x=%%Y,y=%%X" > nul
			
			if %x%==21 (if %y%==1 (goto desktop ))
			if %x%==21 (if %y%==2 (goto desktop ))
			if %x%==21 (if %y%==3 (goto desktop ))
			if %x%==21 (if %y%==4 (goto desktop ))
			if %x%==21 (if %y%==5 (goto desktop ))
			if %x%==21 (if %y%==6 (goto desktop ))
			if %x%==21 (if %y%==7 (goto desktop ))
			if %x%==21 (if %y%==8 (goto desktop ))
			if %x%==21 (if %y%==9 (goto desktop ))
			if %x%==21 (if %y%==10 (goto desktop ))
			if %x%==21 (if %y%==11 (goto desktop ))
			if %x%==21 (if %y%==12 (goto desktop ))
			if %x%==21 (if %y%==13 (goto desktop ))
			if %x%==21 (if %y%==14 (goto desktop ))
			if %x%==21 (if %y%==15 (goto desktop ))
			if %x%==21 (if %y%==16 (goto desktop ))
			if %x%==21 (if %y%==17 (goto desktop ))
			if %x%==21 (if %y%==18 (goto desktop ))
			if %x%==21 (if %y%==19 (goto desktop ))
			if %x%==21 (if %y%==20 (goto desktop ))
			if %x%==21 (if %y%==21 (goto desktop ))
			if %x%==21 (if %y%==22 (goto desktop ))
			if %x%==21 (if %y%==23 (goto desktop ))
			
			if %x%==1 (if %y%==3 (goto notepad ))
			if %x%==2 (if %y%==3 (goto notepad ))
			if %x%==3 (if %y%==3 (goto notepad ))
			if %x%==4 (if %y%==3 (goto notepad ))
			if %x%==5 (if %y%==3 (goto notepad ))
			if %x%==6 (if %y%==3 (goto notepad ))
			if %x%==7 (if %y%==3 (goto notepad ))
			if %x%==8 (if %y%==3 (goto notepad ))
			if %x%==9 (if %y%==3 (goto notepad ))
			if %x%==10 (if %y%==3 (goto notepad ))
			if %x%==11 (if %y%==3 (goto notepad ))
			if %x%==12 (if %y%==3 (goto notepad ))
			if %x%==13 (if %y%==3 (goto notepad ))
			if %x%==14 (if %y%==3 (goto notepad ))
			if %x%==15 (if %y%==3 (goto notepad ))
			if %x%==16 (if %y%==3 (goto notepad ))
			if %x%==17 (if %y%==3 (goto notepad ))
			if %x%==18 (if %y%==3 (goto notepad ))
			if %x%==19 (if %y%==3 (goto notepad ))
			
			if %x%==1 (if %y%==4 (goto calculator ))
			if %x%==2 (if %y%==4 (goto calculator ))
			if %x%==3 (if %y%==4 (goto calculator ))
			if %x%==4 (if %y%==4 (goto calculator ))
			if %x%==5 (if %y%==4 (goto calculator ))
			if %x%==6 (if %y%==4 (goto calculator ))
			if %x%==7 (if %y%==4 (goto calculator ))
			if %x%==8 (if %y%==4 (goto calculator ))
			if %x%==9 (if %y%==4 (goto calculator ))
			if %x%==10 (if %y%==4 (goto calculator ))
			
			if %x%==1 (if %y%==5 (goto randomer ))
			if %x%==2 (if %y%==5 (goto randomer ))
			if %x%==3 (if %y%==5 (goto randomer ))
			if %x%==4 (if %y%==5 (goto randomer ))
			if %x%==5 (if %y%==5 (goto randomer ))
			if %x%==6 (if %y%==5 (goto randomer ))
			if %x%==7 (if %y%==5 (goto randomer ))
			if %x%==8 (if %y%==5 (goto randomer ))
			
			if %x%==1 (if %y%==6 (goto litera ))
			if %x%==2 (if %y%==6 (goto litera ))
			if %x%==3 (if %y%==6 (goto litera ))
			if %x%==4 (if %y%==6 (goto litera ))
			if %x%==5 (if %y%==6 (goto litera ))
			if %x%==6 (if %y%==6 (goto litera ))
			
			if %x%==1 (if %y%==7 (goto notepad2 ))
			if %x%==2 (if %y%==7 (goto notepad2 ))
			if %x%==3 (if %y%==7 (goto notepad2 ))
			if %x%==4 (if %y%==7 (goto notepad2 ))
			if %x%==5 (if %y%==7 (goto notepad2 ))
			if %x%==6 (if %y%==7 (goto notepad2 ))
			if %x%==7 (if %y%==7 (goto notepad2 ))
			if %x%==8 (if %y%==7 (goto notepad2 ))
			
			if %x%==1 (if %y%==8 (goto paint1 ))
			if %x%==2 (if %y%==8 (goto paint1 ))
			if %x%==3 (if %y%==8 (goto paint1 ))
			if %x%==4 (if %y%==8 (goto paint1 ))
			if %x%==5 (if %y%==8 (goto paint1 ))
			
			if %x%==1 (if %y%==9 (goto spacebar ))
			if %x%==2 (if %y%==9 (goto spacebar ))
			if %x%==3 (if %y%==9 (goto spacebar ))
			if %x%==4 (if %y%==9 (goto spacebar ))
			if %x%==5 (if %y%==9 (goto spacebar ))
			if %x%==6 (if %y%==9 (goto spacebar ))
			if %x%==7 (if %y%==9 (goto spacebar ))
			if %x%==8 (if %y%==9 (goto spacebar ))
			
			if %x%==1 (if %y%==10 (goto oscmd ))
			if %x%==2 (if %y%==10 (goto oscmd ))
			if %x%==3 (if %y%==10 (goto oscmd ))
			
			:: __________________________________________________________
			if %x%==1 (if %y%==11 (goto graphizer_notavailable ))
			if %x%==2 (if %y%==11 (goto graphizer_notavailable ))
			if %x%==3 (if %y%==11 (goto graphizer_notavailable ))
			if %x%==4 (if %y%==11 (goto graphizer_notavailable ))
			if %x%==5 (if %y%==11 (goto graphizer_notavailable ))
			if %x%==6 (if %y%==11 (goto graphizer_notavailable ))
			if %x%==7 (if %y%==11 (goto graphizer_notavailable ))
			if %x%==8 (if %y%==11 (goto graphizer_notavailable ))
			if %x%==9 (if %y%==11 (goto graphizer_notavailable ))
			:: __________________________________________________________
			
			if %x%==1 (if %y%==12 (goto stoper ))
			if %x%==2 (if %y%==12 (goto stoper ))
			if %x%==3 (if %y%==12 (goto stoper ))
			if %x%==4 (if %y%==12 (goto stoper ))
			if %x%==5 (if %y%==12 (goto stoper ))
			if %x%==6 (if %y%==12 (goto stoper ))
			
		goto smenu
		
		:: /// POKAZ DATE \\\ ::
		:showdate
		%wbat% fill 20,62 (4,16) (on +black)
		%wbat% text 21,65 "%date%"
		%wbat% text 22,65 "%time:~0,8%"
		
		for /F "tokens=1,2,3" %%W in ('"%mouse%"') do set /A "c=%%W,x=%%Y,y=%%X" > nul
		goto desktop
		
		:: /// NOTATNIK EDIT.COM \\\ ::
		:notepad
		%edit%
		goto desktop
		
		:: /// NOTATNIK \\\ ::
		:notepad2
		cls
		
		%drawdesktop%
		
		:notepad2next
		%wbat% box @core\system.dll:notepad2
		
		if %errorlevel%==1 set ntpadmemory=%ntpadmemory%1
		if %errorlevel%==2 set ntpadmemory=%ntpadmemory%2
		if %errorlevel%==3 set ntpadmemory=%ntpadmemory%3
		if %errorlevel%==4 set ntpadmemory=%ntpadmemory%4
		if %errorlevel%==5 set ntpadmemory=%ntpadmemory%5
		if %errorlevel%==6 set ntpadmemory=%ntpadmemory%6
		if %errorlevel%==7 set ntpadmemory=%ntpadmemory%7
		if %errorlevel%==8 set ntpadmemory=%ntpadmemory%8
		if %errorlevel%==9 set ntpadmemory=%ntpadmemory%9
		if %errorlevel%==10 set ntpadmemory=%ntpadmemory%0
		if %errorlevel%==11 set ntpadmemory=%ntpadmemory%Q
		if %errorlevel%==12 set ntpadmemory=%ntpadmemory%W
		if %errorlevel%==13 set ntpadmemory=%ntpadmemory%E
		if %errorlevel%==14 set ntpadmemory=%ntpadmemory%R
		if %errorlevel%==15 set ntpadmemory=%ntpadmemory%T
		if %errorlevel%==16 set ntpadmemory=%ntpadmemory%Y
		if %errorlevel%==17 set ntpadmemory=%ntpadmemory%U
		if %errorlevel%==18 set ntpadmemory=%ntpadmemory%I
		if %errorlevel%==19 set ntpadmemory=%ntpadmemory%O
		if %errorlevel%==20 set ntpadmemory=%ntpadmemory%P
		if %errorlevel%==21 set ntpadmemory=%ntpadmemory%A
		if %errorlevel%==22 set ntpadmemory=%ntpadmemory%S
		if %errorlevel%==23 set ntpadmemory=%ntpadmemory%D
		if %errorlevel%==24 set ntpadmemory=%ntpadmemory%F
		if %errorlevel%==25 set ntpadmemory=%ntpadmemory%G
		if %errorlevel%==26 set ntpadmemory=%ntpadmemory%H
		if %errorlevel%==27 set ntpadmemory=%ntpadmemory%J
		if %errorlevel%==28 set ntpadmemory=%ntpadmemory%K
		if %errorlevel%==29 set ntpadmemory=%ntpadmemory%L
		if %errorlevel%==30 set ntpadmemory=%ntpadmemory%Z
		if %errorlevel%==31 set ntpadmemory=%ntpadmemory%X
		if %errorlevel%==32 set ntpadmemory=%ntpadmemory%C
		if %errorlevel%==33 set ntpadmemory=%ntpadmemory%V
		if %errorlevel%==34 set ntpadmemory=%ntpadmemory%B
		if %errorlevel%==35 set ntpadmemory=%ntpadmemory%N
		if %errorlevel%==36 set ntpadmemory=%ntpadmemory%M
		if %errorlevel%==37 set ntpadmemory=%ntpadmemory%,
		if %errorlevel%==38 set ntpadmemory=%ntpadmemory%.
		if %errorlevel%==39 set ntpadmemory=%ntpadmemory% 
		if %errorlevel%==40 goto ntpadsave
		if %errorlevel%==41 goto ntpadopen
		if %errorlevel%==42 goto notepad2nexts
		if %errorlevel%==43 set ntpadmemory=
		if %errorlevel%==44 goto desktop
		goto notepad2next
		
		:notepad2nexts
		%wbat% box @core\system.dll:notepad2s
		
		if %errorlevel%==1 set ntpadmemory=%ntpadmemory%1
		if %errorlevel%==2 set ntpadmemory=%ntpadmemory%2
		if %errorlevel%==3 set ntpadmemory=%ntpadmemory%3
		if %errorlevel%==4 set ntpadmemory=%ntpadmemory%4
		if %errorlevel%==5 set ntpadmemory=%ntpadmemory%5
		if %errorlevel%==6 set ntpadmemory=%ntpadmemory%6
		if %errorlevel%==7 set ntpadmemory=%ntpadmemory%7
		if %errorlevel%==8 set ntpadmemory=%ntpadmemory%8
		if %errorlevel%==9 set ntpadmemory=%ntpadmemory%9
		if %errorlevel%==10 set ntpadmemory=%ntpadmemory%0
		if %errorlevel%==11 set ntpadmemory=%ntpadmemory%q
		if %errorlevel%==12 set ntpadmemory=%ntpadmemory%w
		if %errorlevel%==13 set ntpadmemory=%ntpadmemory%e
		if %errorlevel%==14 set ntpadmemory=%ntpadmemory%r
		if %errorlevel%==15 set ntpadmemory=%ntpadmemory%t
		if %errorlevel%==16 set ntpadmemory=%ntpadmemory%y
		if %errorlevel%==17 set ntpadmemory=%ntpadmemory%u
		if %errorlevel%==18 set ntpadmemory=%ntpadmemory%i
		if %errorlevel%==19 set ntpadmemory=%ntpadmemory%o
		if %errorlevel%==20 set ntpadmemory=%ntpadmemory%p
		if %errorlevel%==21 set ntpadmemory=%ntpadmemory%a
		if %errorlevel%==22 set ntpadmemory=%ntpadmemory%s
		if %errorlevel%==23 set ntpadmemory=%ntpadmemory%d
		if %errorlevel%==24 set ntpadmemory=%ntpadmemory%f
		if %errorlevel%==25 set ntpadmemory=%ntpadmemory%g
		if %errorlevel%==26 set ntpadmemory=%ntpadmemory%h
		if %errorlevel%==27 set ntpadmemory=%ntpadmemory%j
		if %errorlevel%==28 set ntpadmemory=%ntpadmemory%k
		if %errorlevel%==29 set ntpadmemory=%ntpadmemory%l
		if %errorlevel%==30 set ntpadmemory=%ntpadmemory%z
		if %errorlevel%==31 set ntpadmemory=%ntpadmemory%x
		if %errorlevel%==32 set ntpadmemory=%ntpadmemory%c
		if %errorlevel%==33 set ntpadmemory=%ntpadmemory%v
		if %errorlevel%==34 set ntpadmemory=%ntpadmemory%b
		if %errorlevel%==35 set ntpadmemory=%ntpadmemory%n
		if %errorlevel%==36 set ntpadmemory=%ntpadmemory%m
		if %errorlevel%==37 set ntpadmemory=%ntpadmemory%,
		if %errorlevel%==38 set ntpadmemory=%ntpadmemory%.
		if %errorlevel%==39 set ntpadmemory=%ntpadmemory% 
		if %errorlevel%==40 goto ntpadsave
		if %errorlevel%==41 goto ntpadopen
		if %errorlevel%==42 goto notepad2next
		if %errorlevel%==43 set ntpadmemory=
		if %errorlevel%==44 goto desktop
		goto notepad2nexts
		
		:ntpadopenwith
		%drawdesktop%
		:ntpadopen
		%wbat% box @core\system.dll:ntpadopen
		
		if %errorlevel%==1 set ntpadname=%ntpadname%q
		if %errorlevel%==2 set ntpadname=%ntpadname%w
		if %errorlevel%==3 set ntpadname=%ntpadname%e
		if %errorlevel%==4 set ntpadname=%ntpadname%r
		if %errorlevel%==5 set ntpadname=%ntpadname%t
		if %errorlevel%==6 set ntpadname=%ntpadname%y
		if %errorlevel%==7 set ntpadname=%ntpadname%u
		if %errorlevel%==8 set ntpadname=%ntpadname%i
		if %errorlevel%==9 set ntpadname=%ntpadname%o
		if %errorlevel%==10 set ntpadname=%ntpadname%p
		if %errorlevel%==11 set ntpadname=%ntpadname%a
		if %errorlevel%==12 set ntpadname=%ntpadname%s
		if %errorlevel%==13 set ntpadname=%ntpadname%d
		if %errorlevel%==14 set ntpadname=%ntpadname%f
		if %errorlevel%==15 set ntpadname=%ntpadname%g
		if %errorlevel%==16 set ntpadname=%ntpadname%h
		if %errorlevel%==17 set ntpadname=%ntpadname%j
		if %errorlevel%==18 set ntpadname=%ntpadname%k
		if %errorlevel%==19 set ntpadname=%ntpadname%l
		if %errorlevel%==20 set ntpadname=%ntpadname%z
		if %errorlevel%==21 set ntpadname=%ntpadname%x
		if %errorlevel%==22 set ntpadname=%ntpadname%c
		if %errorlevel%==23 set ntpadname=%ntpadname%v
		if %errorlevel%==24 set ntpadname=%ntpadname%b
		if %errorlevel%==25 set ntpadname=%ntpadname%n
		if %errorlevel%==26 set ntpadname=%ntpadname%m
		if %errorlevel%==27 goto ntpadopenok
		if %errorlevel%==28 set ntpadname=
		if %errorlevel%==29 goto notepad2next
		goto ntpadopen
		
		:ntpadopenok
		if exist "core\users\%osusername%\notepad\%ntpadname%.txt" goto ntpadopenoknext
		%wbat% box @core\system.dll:ntpadopenoknotexist
		goto ntpadopen
		:ntpadopenoknext
		cls
		color 07
		%cocolor% 10 "Otworzono %ntpadname%.txt"
		echo.
		%cocolor% 08 "  Wci˜nij dowolny klawisz, by powr¢ci†."
		echo. &echo.
		type "core\users\%osusername%\notepad\%ntpadname%.txt"
		pause > nul
		cls
		color 10
		goto ntpadopenwith
		
		:ntpadsave
		%wbat% box @core\system.dll:ntpadsave
		
		if %errorlevel%==1 set ntpadname=%ntpadname%q
		if %errorlevel%==2 set ntpadname=%ntpadname%w
		if %errorlevel%==3 set ntpadname=%ntpadname%e
		if %errorlevel%==4 set ntpadname=%ntpadname%r
		if %errorlevel%==5 set ntpadname=%ntpadname%t
		if %errorlevel%==6 set ntpadname=%ntpadname%y
		if %errorlevel%==7 set ntpadname=%ntpadname%u
		if %errorlevel%==8 set ntpadname=%ntpadname%i
		if %errorlevel%==9 set ntpadname=%ntpadname%o
		if %errorlevel%==10 set ntpadname=%ntpadname%p
		if %errorlevel%==11 set ntpadname=%ntpadname%a
		if %errorlevel%==12 set ntpadname=%ntpadname%s
		if %errorlevel%==13 set ntpadname=%ntpadname%d
		if %errorlevel%==14 set ntpadname=%ntpadname%f
		if %errorlevel%==15 set ntpadname=%ntpadname%g
		if %errorlevel%==16 set ntpadname=%ntpadname%h
		if %errorlevel%==17 set ntpadname=%ntpadname%j
		if %errorlevel%==18 set ntpadname=%ntpadname%k
		if %errorlevel%==19 set ntpadname=%ntpadname%l
		if %errorlevel%==20 set ntpadname=%ntpadname%z
		if %errorlevel%==21 set ntpadname=%ntpadname%x
		if %errorlevel%==22 set ntpadname=%ntpadname%c
		if %errorlevel%==23 set ntpadname=%ntpadname%v
		if %errorlevel%==24 set ntpadname=%ntpadname%b
		if %errorlevel%==25 set ntpadname=%ntpadname%n
		if %errorlevel%==26 set ntpadname=%ntpadname%m
		if %errorlevel%==27 goto ntpadsaveok
		if %errorlevel%==28 set ntpadname=
		if %errorlevel%==29 goto notepad2next
		goto ntpadsave
		
		:ntpadsaveok
		if exist "core\users\%osusername%\notepad" goto ntpadsaveoknext
		md "core\users\%osusername%\notepad
		:ntpadsaveoknext
		if exist "core\users\%osusername%\notepad\%ntpadname%.txt" goto ntpadsaveokexist
		echo %ntpadmemory% >>"core\users\%osusername%\notepad\%ntpadname%.txt"
		%wbat% box @core\system.dll:ntpadsaved
		goto notepad2next
		:ntpadsaveokexist
		%wbat% box "Podana nazwa pliku jest zaj©ta, podaj inn¥."
		goto ntpadsave
		
		:: /// KALKULATOR \\\ ::
		:calculator
		cls
		
		%drawdesktop%
		
		:calculatornext
		%wbat% box @core\system.dll:calculator
		if %errorlevel%==1 set calcmemory=%calcmemory%1
		if %errorlevel%==2 set calcmemory=%calcmemory%2
		if %errorlevel%==3 set calcmemory=%calcmemory%3
		if %errorlevel%==4 set calcmemory=%calcmemory%+
		if %errorlevel%==5 set calcmemory=%calcmemory%4
		if %errorlevel%==6 set calcmemory=%calcmemory%5
		if %errorlevel%==7 set calcmemory=%calcmemory%6
		if %errorlevel%==8 set calcmemory=%calcmemory%-
		if %errorlevel%==9 set calcmemory=%calcmemory%7
		if %errorlevel%==10 set calcmemory=%calcmemory%8
		if %errorlevel%==11 set calcmemory=%calcmemory%9
		if %errorlevel%==12 set calcmemory=%calcmemory%*
		if %errorlevel%==13 set calcmemory=&set wynik=
		if %errorlevel%==14 set calcmemory=%calcmemory%0
		if %errorlevel%==15 goto wynik
		if %errorlevel%==16 set calcmemory=%calcmemory%/
		if %errorlevel%==17 set wynik=&set calcmemory=&set calcmemory2=&goto desktop
		goto calculatornext
		:wynik
		set /A wynik=%calcmemory%
		set calcmemory2=%wynik%
		set calcmemory=%calcmemory2%
		goto calculatornext
		
		:: /// RANDOMER \\\ ::
		:randomer
		cls
		
		%drawdesktop%
		
		:randomernext
		%wbat% box @core\system.dll:randomer
		set niewiadoma=%random:~0,1%
		if %errorlevel%==10 goto desktop
		if %errorlevel%==%niewiadoma% goto randwin
		echo Przegrana w %date% o godz. %time% odpowiedzia: %errorlevel%, gdyz poprawna cyfra to %niewiadoma%. >> "randomer-wyniki.txt"
		%wbat% box "Przegraˆe˜/A˜ Poprawna liczba to: %niewiadoma%" Od nowa, Wyjd«
		if %errorlevel%==1 goto randomernext
		if %errorlevel%==2 goto desktop
		:randwin
		echo Wygrana w %date% o godz. %time% odpowiedzia: %niewiadoma%. >> "randomer-wyniki.txt"
		%wbat% box "Wygraˆe˜/A˜! Poprawna cyfra to: %niewiadoma%" Od nowa, Wyjd«
		if %errorlevel%==1 goto randomernext
		if %errorlevel%==2 goto desktop
		goto randomernext
		
		:: /// LITERA \\\ ::
		:litera
		cls
		
		%drawdesktop%
		
		:literanext
		set litera=
		set gloska=
		%wbat% box @core\system.dll:litera
		
		if %errorlevel%==1 set litera=q &set gloska=spolgloska
		if %errorlevel%==2 set litera=w &set gloska=spolgloska
		if %errorlevel%==3 set litera=e &set gloska=samogloska
		if %errorlevel%==4 set litera=r &set gloska=spolgloska
		if %errorlevel%==5 set litera=t &set gloska=spolgloska
		if %errorlevel%==6 set litera=y &set gloska=samogloska
		if %errorlevel%==7 set litera=u &set gloska=samogloska
		if %errorlevel%==8 set litera=i &set gloska=samogloska
		if %errorlevel%==9 set litera=o &set gloska=samogloska
		if %errorlevel%==10 set litera=p &set gloska=spolgloska
		if %errorlevel%==11 set litera=a &set gloska=samogloska
		if %errorlevel%==12 set litera=s &set gloska=spolgloska
		if %errorlevel%==13 set litera=d &set gloska=spolgloska
		if %errorlevel%==14 set litera=f &set gloska=spolgloska
		if %errorlevel%==15 set litera=g &set gloska=spolgloska
		if %errorlevel%==16 set litera=h &set gloska=spolgloska
		if %errorlevel%==17 set litera=j &set gloska=spolgloska
		if %errorlevel%==18 set litera=k &set gloska=spolgloska
		if %errorlevel%==19 set litera=l &set gloska=spolgloska
		if %errorlevel%==20 set litera=z &set gloska=spolgloska
		if %errorlevel%==21 set litera=x &set gloska=spolgloska
		if %errorlevel%==22 set litera=c &set gloska=spolgloska
		if %errorlevel%==23 set litera=v &set gloska=spolgloska
		if %errorlevel%==24 set litera=b &set gloska=spolgloska
		if %errorlevel%==25 set litera=n &set gloska=spolgloska
		if %errorlevel%==26 set litera=m &set gloska=spolgloska
		if %errorlevel%==27 goto literalista &set gloska=
		if %errorlevel%==28 goto desktop &set gloska=
		
		%wbat% box "Litera: %litera%(%gloska%)" OK
		if %errorlevel%==1 goto litera
		goto literanext
		
		:literalista
		%wbat% box @core\system.dll:literalista
		if %errorlevel%==1 goto literanext
		goto literalista
		
		:: /// PAINT \\\ ::
		:paint1
		cls
		set pcuboid=0
		set kolor=white
		set grubosc=1,1
		color 07
		goto paint
		:paint
		cls
		
		%wbat% fill 1,1 (25,1) (on white)
		%wbat% fill 25,1 (1,80) (on white)
		%wbat% fill 1,1 (1,80) (on white)
		%wbat% fill 1,80 (25,1) (on white)
		
		%wbat% text 1,9 "Paint"
		%wbat% text 1,1 "X" (white on blue)
		
		:paintstart
			if %pcuboid%==1 goto oncuboid
		for /F "tokens=1,2,3" %%W in ('"%mouse%"') do set /A "c=%%W,x=%%Y,y=%%X" > nul
			if %y%==0 goto paintmenu
			if %x%==0 goto paintmenu
			if %y%==24 goto paintmenu
			if %x%==79 goto paintmenu
				set /A y=%y%+1
				set /A x=%x%+1
		%wbat% fill %y%,%x% (%grubosc%) (on %kolor%)
		
		:paintmenu
			if %x%==0 (if %y%==0 (goto paintoptions ))
		goto paintstart
		
		:paintoptions
		%wbat% box @core\system.dll:paintoptions
		if %errorlevel%==1 goto paint
		if %errorlevel%==2 goto desktop
		if %errorlevel%==3 goto opcjemalowania
		if %errorlevel%==4 goto paintstart
		goto paintoptions
		
		:opcjemalowania
		%wbat% box @core\system.dll:opcjemalowania
		if %errorlevel%==1 goto paintcolorselector
		if %errorlevel%==2 goto paintsize
		:: __________________________________________________________
		if %errorlevel%==3 goto paintcuboid_notavailable
		:: __________________________________________________________
		if %errorlevel%==4 goto paintstart
		goto opcjemalowania
		
		:paintcolorselector
		%wbat% box @core\system.dll:paintcolorselector
		if %errorlevel%==1 set kolor=black &goto paintstart
		if %errorlevel%==2 set kolor=+black &goto paintstart
		if %errorlevel%==3 set kolor=blue &goto paintstart
		if %errorlevel%==4 set kolor=+blue &goto paintstart
		if %errorlevel%==5 set kolor=green &goto paintstart
		if %errorlevel%==6 set kolor=+green &goto paintstart
		if %errorlevel%==7 set kolor=cyan &goto paintstart
		if %errorlevel%==8 set kolor=+cyan &goto paintstart
		if %errorlevel%==9 set kolor=red &goto paintstart
		if %errorlevel%==10 set kolor=+red &goto paintstart
		if %errorlevel%==11 set kolor=violet &goto paintstart
		if %errorlevel%==12 set kolor=+violet &goto paintstart
		if %errorlevel%==13 set kolor=yellow &goto paintstart
		if %errorlevel%==14 set kolor=+yellow &goto paintstart
		if %errorlevel%==15 set kolor=white &goto paintstart
		if %errorlevel%==16 set kolor=+white &goto paintstart
		if %errorlevel%==17 goto opcjemalowania
		if %errorlevel%==18 goto paintstart
		goto paintcolorselector
		
		:paintsize
		%wbat% box @core\system.dll:paintsize
		if %errorlevel%==1 set grubosc=1,1 &goto paintstart
		if %errorlevel%==2 set grubosc=2,2 &goto paintstart
		if %errorlevel%==3 set grubosc=3,3 &goto paintstart
		if %errorlevel%==4 set grubosc=4,4 &goto paintstart
		if %errorlevel%==5 set grubosc=5,5 &goto paintstart
		if %errorlevel%==6 set grubosc=6,6 &goto paintstart
		if %errorlevel%==7 set grubosc=7,7 &goto paintstart
		if %errorlevel%==8 set grubosc=8,8 &goto paintstart
		if %errorlevel%==9 set grubosc=9,9 &goto paintstart
		if %errorlevel%==10 goto opcjemalowania
		if %errorlevel%==11 goto paintstart
		goto paintsize
		
		:paintcuboid
		%wbat% box @core\system.dll:paintcuboid
		if %errorlevel%==1 set pcuboid=1 &goto paintstart
		if %errorlevel%==3 set pcuboid=0 &goto paintstart
		if %errorlevel%==4 goto opcjemalowania
		if %errorlevel%==5 goto paintstart
		goto paintcuboid
		
		:paintcuboid_notavailable
		%wbat% box @core\system.dll:paintcuboid_notavailable
		if %errorlevel%==1 goto opcjemalowania
		goto paintcuboid_notavailable
		
		::  __________________________________________________________
		:oncuboid
		
		:: /// CUBOID POS1 \\\ ::
		for /F "tokens=1,2,3" %%W in ('"%mouse%"') do set /A "c=%%W,x=%%Y,y=%%X" > nul
			if %y%==0 goto paintmenu
			if %x%==0 goto paintmenu
			if %y%==24 goto paintmenu
			if %x%==79 goto paintmenu
				set /A y=%y%+1
				set /A x=%x%+1
					set ycub1=%y%
					set xcub1=%x%
				
		:: /// CUBOID POS2 \\\ ::
				for /F "tokens=1,2,3" %%W in ('"%mouse%"') do set /A "c=%%W,x=%%Y,y=%%X" > nul
			if %y%==0 goto paintmenu
			if %x%==0 goto paintmenu
			if %y%==24 goto paintmenu
			if %x%==79 goto paintmenu
				set /A y=%y%+1
				set /A x=%x%+1
					set ycub2=%y%
					set xcub2=%x%
					
				:: /// CALCULATE CUBOID POSITIONS \\\ ::
					set ycub2c=%ycub1%+%ycub2%
					set xcub2c=%xcub1%+%xcub2%
						set ycub2=%windowy%-%ycub2c%
						set xcub2=%windowx%-%xcub2c%
				
		%wbat% fill %ycub1%,%xcub1% (%ycub2%,%xcub2%) (on white)
		goto oncuboid
		:: __________________________________________________________
		
		:: /// SPACEBAR \\\ ::
		:spacebar
		call "core\spacebar.bat"
		goto desktop
		
		:: /// CMD \\\ ::
		:oscmd
		cls
		%drawdesktop%
		
		%wbat% box "Program wymaga do˜wiadczonej wiedzy od u¾ytkownika." OK, Wr¢†
		if %errorlevel%==1 goto oscmdok
		if %errorlevel%==2 goto desktop
		goto oscmd
		:oscmdok
		cls
		color 07
		%cocolor% 10 "Wiersz polecenia - CMD"
		echo.
		%cocolor% %dcolor% "  Wpisz "  07 ".done" %dcolor% ", by powr¢ci†."
		echo. &echo.
		:cmdinsert
		set /P "cmdtxt="
		if %cmdtxt%==.done goto desktop
		%cmdtxt%
		goto cmdinsert
		
		:: __________________________________________________________
		:: /// GRAPHIZER \\\ ::
		:graphizer
		cls
		%drawdesktop%
		
		%wbat% box "Program zostanie uruchomiony w osobnym oknie." OK, Wr¢†
		if %errorlevel%==1 goto graphizerok
		if %errorlevel%==2 goto desktop
		goto graphizer
		:graphizerok
		start /MAX graphizer_launch.bat
		ping localhost -n 1 > nul
		goto desktop
		
		:graphizer_notavailable
		cls
		%drawdesktop%
		
		%wbat% box @core\system.dll:graphizer_notavailable
		if %errorlevel%==1 goto desktop
		goto paintcuboid_notavailable
		:: __________________________________________________________
		
		:: /// STOPER \\\ ::
		:stoper
		color 07
		cls
		echo.
			set czas=0
			set stodl=%time%
		:stoperpetla
		cls
		echo.
		echo  Start: %stodl%
		echo  Uplynelo: %czas%s
		echo.
		echo  [ESC] - Anuluj
		%wait% 1 27
		if %errorlevel%==27 goto stoperend
		set /A czas+=1
		goto stoperpetla
		:stoperend
		echo.
		echo  Koniec: %time%
		pause > nul
		goto desktop
		