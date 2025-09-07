@echo off
REM ===============================================
REM   EpochFilterPro Standalone Launcher
REM   Optimized for Windows 11 x64
REM ===============================================

setlocal enabledelayedexpansion
cd /d "%~dp0"

REM Set console properties for better display
title EpochFilterPro - AI-Powered Last Epoch Filter Creator
color 0E
mode con: cols=100 lines=30

REM Display startup banner
echo.
echo    ███████╗██████╗  ██████╗  ██████╗██╗  ██╗
echo    ██╔════╝██╔══██╗██╔═══██╗██╔════╝██║  ██║
echo    █████╗  ██████╔╝██║   ██║██║     ███████║
echo    ██╔══╝  ██╔═══╝ ██║   ██║██║     ██╔══██║
echo    ███████╗██║     ╚██████╔╝╚██████╗██║  ██║
echo    ╚══════╝╚═╝      ╚═════╝  ╚═════╝╚═╝  ╚═╝
echo.
echo    ███████╗██╗██╗  ████████╗███████╗██████╗ 
echo    ██╔════╝██║██║  ╚══██╔══╝██╔════╝██╔══██╗
echo    █████╗  ██║██║     ██║   █████╗  ██████╔╝
echo    ██╔══╝  ██║██║     ██║   ██╔══╝  ██╔══██╗
echo    ██║     ██║███████╗██║   ███████╗██║  ██║
echo    ╚═╝     ╚═╝╚══════╝╚═╝   ╚══════╝╚═╝  ╚═╝
echo.
echo    ██████╗ ██████╗  ██████╗ 
echo    ██╔══██╗██╔══██╗██╔═══██╗
echo    ██████╔╝██████╔╝██║   ██║
echo    ██╔═══╝ ██╔══██╗██║   ██║
echo    ██║     ██║  ██║╚██████╔╝
echo    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ 
echo.
echo    AI-Powered Last Epoch Filter Creator
echo    Version 1.0 - Windows 11 x64 Edition
echo ===============================================
echo.

REM Check system requirements
echo [SYSTEM CHECK]
echo --------------

REM Check Windows version
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%VERSION%" geq "10.0" (
    echo [OK] Windows 10/11 detected
) else (
    echo [WARNING] Older Windows version detected. Windows 10/11 recommended.
)

REM Check architecture
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo [OK] 64-bit architecture detected
) else (
    echo [WARNING] 32-bit architecture detected. 64-bit recommended.
)

REM Check Node.js
where node >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('node -v') do set NODE_VERSION=%%i
    echo [OK] Node.js !NODE_VERSION! detected
) else (
    echo [INSTALLING] Node.js not found. Installing portable Node.js...
    
    REM Download portable Node.js if not present
    if not exist "node-portable\" (
        echo Downloading Node.js portable...
        powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://nodejs.org/dist/v20.11.0/node-v20.11.0-win-x64.zip' -OutFile 'node.zip'}"
        
        echo Extracting Node.js...
        powershell -Command "Expand-Archive -Path 'node.zip' -DestinationPath '.' -Force"
        move node-v20.11.0-win-x64 node-portable >nul
        del node.zip >nul
    )
    
    REM Use portable Node.js
    set PATH=%cd%\node-portable;%PATH%
    echo [OK] Using portable Node.js
)

echo.
echo [ENVIRONMENT SETUP]
echo -------------------

REM Check and create .env file if needed
if not exist ".env" (
    echo Creating configuration file...
    (
        echo # EpochFilterPro Configuration
        echo # ============================
        echo.
        echo # AI API Keys - Get yours at:
        echo # GROQ: https://console.groq.com
        echo # OpenAI: https://platform.openai.com
        echo.
        echo GROQ_API_KEY=
        echo OPENAI_API_KEY=
        echo.
        echo # Server Settings
        echo PORT=5000
        echo NODE_ENV=production
        echo.
        echo # Database ^(Optional - works without it^)
        echo DATABASE_URL=
        echo PGDATABASE=
        echo PGHOST=
        echo PGPASSWORD=
        echo PGPORT=
        echo PGUSER=
    ) > .env
    
    echo.
    echo ============================================
    echo  IMPORTANT: API Keys Required!
    echo ============================================
    echo.
    echo  To enable AI features, you need to add
    echo  your API keys to the .env file.
    echo.
    echo  Press any key to open the configuration...
    pause >nul
    notepad .env
    echo.
    echo  Configuration file opened. Please add your
    echo  API keys and save the file.
    echo.
    timeout /t 5 >nul
)

REM Check dependencies
if not exist "node_modules\" (
    echo.
    echo [INSTALLATION]
    echo -------------
    echo Installing application dependencies...
    echo This may take a few minutes on first run...
    echo.
    
    call npm install --production --silent
    
    if %errorlevel% neq 0 (
        echo.
        echo [ERROR] Failed to install dependencies
        echo Please check your internet connection and try again.
        pause
        exit /b 1
    )
    
    echo [OK] Dependencies installed successfully
)

REM Set production environment
set NODE_ENV=production
set PORT=5000

REM Clear screen for clean startup
cls

echo.
echo ===============================================
echo   EpochFilterPro is starting...
echo ===============================================
echo.
echo   Server:  http://localhost:5000
echo   Status:  Initializing...
echo.
echo   Press Ctrl+C to stop the server
echo ===============================================
echo.

REM Check if built version exists
if exist "dist\index.js" (
    echo Starting production server...
    start /b cmd /c "timeout /t 3 >nul && start http://localhost:5000"
    node dist\index.js
) else (
    echo Building and starting server...
    
    REM Build if necessary
    if not exist "client\dist\" (
        echo Building frontend...
        call npx vite build --silent
    )
    
    echo Starting server...
    start /b cmd /c "timeout /t 3 >nul && start http://localhost:5000"
    call npx tsx server/index.ts
)

REM If server stops, show message
echo.
echo ===============================================
echo   Server stopped
echo ===============================================
echo.
pause