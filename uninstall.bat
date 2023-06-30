@echo off
setlocal enabledelayedexpansion

REM Uninstall Script to Remove Current Directory from PATH

REM Check if running with administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%0' -Verb RunAs"
    exit /b
)

rem Set the directory of the uninstall.bat file
set "uninstall_dir=%~dp0dirts"

rem Remove the uninstall_dir from the PATH variable
set "new_path="
for %%I in ("%PATH:;=" "%") do (
    if /I not "%%~I"=="%uninstall_dir%" (
        if defined new_path (
            set "new_path=!new_path!;%%~I"
        ) else (
            set "new_path=%%~I"
        )
    )
)

rem Update the PATH variable with the new_path
if defined new_path (
    setx PATH "!new_path!" /M
) else (
    setx PATH "" /M
)

echo Uninstallation complete. Please restart any open command prompt windows.
