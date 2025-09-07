@echo off
echo =========================================
echo   Building EpochFilterPro for Windows
echo =========================================
echo.

REM Build the frontend
echo Building frontend...
call npm run build:client
if %errorlevel% neq 0 (
    echo [ERROR] Failed to build frontend
    pause
    exit /b 1
)

REM Build the backend
echo Building backend...
call npm run build:server
if %errorlevel% neq 0 (
    echo [ERROR] Failed to build backend
    pause
    exit /b 1
)

REM Build Electron app
echo Building Windows executable...
call npx electron-builder --win --x64
if %errorlevel% neq 0 (
    echo [ERROR] Failed to build executable
    pause
    exit /b 1
)

echo.
echo =========================================
echo   Build Complete!
echo =========================================
echo.
echo Executable created in: dist-electron\
echo.
echo Files created:
echo - EpochFilterPro-Setup-1.0.0.exe (Installer)
echo - EpochFilterPro-Portable-1.0.0.exe (Portable)
echo.
pause