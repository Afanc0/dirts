@echo off

REM Configuration Script to Append Directory to PATH

REM Check if running with administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%0' -Verb RunAs"
    exit /b
)

REM Get the directory path of the script
set "scriptDir=%~dp0dirts"

REM Check if the script directory is already in PATH
powershell -Command "if ('$env:PATH' -split ';' | Select-String -CaseSensitive -SimpleMatch '%scriptDir%') { exit 0 } else { exit 1 }"
if %errorLevel% equ 0 (
    echo The directory is already added to PATH.
) else (
    REM Append the script directory to PATH
    powershell -Command "$env:PATH += ';%scriptDir%'; [Environment]::SetEnvironmentVariable('PATH', $env:PATH, 'Machine')"
    echo The directory has been appended to PATH.
)
