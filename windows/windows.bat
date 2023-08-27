@echo off
setlocal enabledelayedexpansion

@REM version 0.0.5
echo Windows Server Manager

set "serverPath=replaceme"
set "configPath=replaceme"

echo Available commands: 'bebo start', 'bebo stop', 'bebo restart'.

if "%serverPath%"=="" (
    echo server path is not set or does not exist.
    pause
    exit /b
)

if "%configPath%"=="" (
    echo config path is not set or does not exist.
    pause
    exit /b
)

:main
set /p "command="

call :manageServer
goto main

:manageServer
if "%command%"=="bebo start" (
    call :startServer
    set "result=server started"
) else if "%command%"=="bebo stop" (
    call :stopServer
    set "result=server stopped"
) else if "%command%"=="bebo restart" (
    call :restartServer
    set "result=server restarted"
) else (
    set "result=unknown command"
)

if "!errorlevel!"=="0" (
    echo !result!.
) else (
    echo Failed to !result!.
)

exit /b

:startServer
start "" "%serverPath%" +exec %configPath%
exit /b

:stopServer
taskkill /f /im FXServer.exe
timeout /t 5 /nobreak > nul
exit /b

:restartServer
call :stopServer
call :startServer
exit /b