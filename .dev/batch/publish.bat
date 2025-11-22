cls
@echo off
setlocal

:begin

	cls

	echo [ DEPLOYMENT SYSTEM ]
	echo   2019 Dario Passariello
	echo --------------------------------------------------------------------
	echo;
	echo   1 -- Go in Production
	echo   2 -- exit
	echo;
	echo --------------------------------------------------------------------
	set /P rmFunc="Enter a choice: "
	echo --------------------------------------------------------------------

	for %%I in (1 2 x) do if #%rmFunc%==#%%I goto run%%I
	goto begin

:run1

	cd ../..
	pushd %~dp0..\..\
	set THIS_DIR = %cd%\dist\
	set PROJECT = X:\a51\tests
	popd

	for /f "tokens=3,2,4 delims=/- " %%x in ("%date%") do set d=%%z%%x%%y
	for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set datetime=%%I
	set logtime=%datetime:~8,6%
	for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined tmpDate set tmpDate=%%x
	set data=%tmpDate:~0,4%%tmpDate:~4,2%%tmpDate:~6,2%

	cls
	echo %PROJECT% : %THIS_DIR%

	xcopy /s/e/h/v/k/y /EXCLUDE:%THIS_DIR%.dev\batch\exclude.txt %THIS_DIR% %PROJECT%

	@REM Set DirName = %cd%\dist\
	Set DirName = %PROJECT%
	cd /d %Dirname%
	echo %Dirname%
	call npm i

	goto :EOF
	goto begin

:run2

	goto :EOF
	goto begin

	endlocal

	goto :EOF
