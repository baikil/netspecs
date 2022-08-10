:ini
@echo off
set "appn=NetSpecs"
set "appv=ALPHA"
if "%1" neq "" (
call :%1 %2 %3 %4 %5&echo %6 %7 %8 %9
REM if "%6" neq "" (if "%6" == "!" (%6 %7)else(echo %6&))
REM if "%7" neq "" (if "%6" neq "!" (echo %7))
REM if "%8" neq "" (if "%8" == "!" (%8 %9)else(echo %8))
REM if "%9" neq "" (if "%8" neq "!" (echo %9))
exit /b
)
:0 Menu
cls
title %appn% - Menu
echo %appn% v%appv%
echo [Menu]&echo.
echo 1. Ping
echo 2. About
echo 3. Exit
choice /cs /c 123456789T /n
goto %errorlevel%
:1 Ping
cls
title %appn% - Ping
echo %appn% v%appv%
echo [Ping]&echo.
set /p "np=Number of packets to send : "
call :ping
echo.&pause
goto 0
:2 About
cls
title %appn% - About
echo %appn% v%appv%
echo [About]&echo.
echo Author : Baikil
echo Github : https://github.com/baikil/netspecs
echo File location : %0
echo Description : %appn% is an app made to quickly get info on your current network. All from the ping (latency) to the connected devices that are on it (wip).
echo.&pause
goto 0
:3 Exit
echo.&choice /m "Are you sure that you want to exit"
if "%errorlevel%" == "1" exit
goto 0
::Functions::
:10 Test
cls
title %appn% - TEST MODE
echo %appn% v%appv%
echo [[92mTEST MODE[0m]&echo.
set /p "TM=NetSpecs "
call NetSpecs %TM%
echo.&pause
choice /m "Run another command"
if %errorlevel% == 1 goto 10
goto 0
:ping
if "%1" neq "" (set np=%1)
title %appn% - Ping(x%np%)   [1/2]&for /f "tokens=*" %%a in ('ping -n %np% -l 1 8.8.8.8^|find "    P"') do set "ping_pack=%%a"
title %appn% - Ping(x%np%)   [2/2]&for /f "tokens=*" %%a in ('ping -n %np% -l 1 8.8.8.8^|find "    M"') do set "ping_lat=%%a"
title %appn% - Ping(x%np%)   [Done]
set ping_lat_min=%ping_lat:~10,5%
set ping_lat_min=%ping_lat_min:,=%
set ping_lat_max=%ping_lat:~25,5%
set ping_lat_max=%ping_lat_max:,=%
set ping_lat_avg=%ping_lat:~-4%
set ping_lat_avg=%ping_lat_avg: =%
exit /b