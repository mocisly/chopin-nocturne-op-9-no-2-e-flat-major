@echo off
setlocal
cd /d "%~dp0"
where lilypond >nul 2>nul
if errorlevel 1 (
 echo LilyPond was not found on PATH. Install LilyPond 2.26.0.
 pause
 exit /b 1
)
if not exist "build" mkdir "build"
lilypond -o "build\chopin-nocturne-op-9-no-2-e-flat-major" "chopin-nocturne-op-9-no-2-e-flat-major.ly" > "build\compile.log" 2>&1
set RESULT=%ERRORLEVEL%
type "build\compile.log"
echo.
echo Output: build. Please review remaining diagnostics.
pause
exit /b %RESULT%
