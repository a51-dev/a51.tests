@echo off

@REM echo THIS FILE RUN BACKUP.
@REM echo CREATED BY DARIO PASSARIELLO.
@REM echo[

@REM goto :start

@REM This file permit to run BackUp as Zip file (using 7z) for the APP.
@REM Please don't change anything without authorization.
@REM In case needs help please call the back-end department.
@REM You need to install 7z free software before using this batch

@REM :start

@REM :choice
@REM set /P c=Are you sure you want to continue( [Y]/N )? Y
@REM if /I "%c%" EQU "" goto :yes
@REM if /I "%c%" EQU "y" goto :yes
@REM if /I "%c%" EQU "Y" goto :yes
@REM if /I "%c%" EQU "N" goto :no
@REM goto :choice

@REM :yes

cd ../..
pushd %~dp0..\..\
set THIS_DIR=%CD%
popd

for /f "tokens=3,2,4 delims=/- " %%x in ("%date%") do set d=%%z%%x%%y
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set datetime=%%I
set logtime=%datetime:~8,6%
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined tmpDate set tmpDate=%%x
set data=%tmpDate:~0,4%%tmpDate:~4,2%%tmpDate:~6,2%

cls
echo %THIS_DIR%

"%THIS_DIR%\.dev\exe\7z.exe" a -tzip %THIS_DIR%\.backup\%data%.%logtime%.zip %THIS_DIR% -xr!node_modules -xr!.backup -xr!.git
attrib +h %THIS_DIR%\.backup
echo Zip created into %THIS_DIR%\.backup!
@REM pause
@REM exit

:no
@REM exit
