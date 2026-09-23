@echo off
chcp 65001 >nul
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\Update-DawsonOaksTranslation.ps1" -GameDir "%~dp0"
echo.
pause
