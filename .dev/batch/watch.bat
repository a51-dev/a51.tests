cls
@echo off
setlocal

:begin


	cls

	echo [ DEPLOYMENT SYSTEM ]
	echo   2022 Dario Passariello
	echo --------------------------------------------------------------------

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
	echo %THIS_DIR%

	xcopy /s/e/h/v/k/y /EXCLUDE:%THIS_DIR%.dev\batch\exclude.txt %THIS_DIR% %PROJECT%
