@echo off
REM EpochFilterPro Launcher for Windows
REM This batch file runs the application locally with all dependencies

setlocal enabledelayedexpansion

echo =========================================
echo   EpochFilterPro - Starting Application
echo =========================================
echo.

REM Check if Node.js is installed
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is not installed!
    echo Please run install.bat first to set up the application.
    pause
    exit /b 1
)

REM Check if node_modules exists
if not exist "node_modules\" (
    echo [INFO] First time setup detected. Installing dependencies...
    call npm install
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to install dependencies
        pause
        exit /b 1
    )
)

REM Check if .env file exists
if not exist ".env" (
    echo [WARNING] No .env file found. Creating default configuration...
    (
        echo # AI API Keys - Add your keys here
        echo GROQ_API_KEY=
        echo OPENAI_API_KEY=
        echo.
        echo # Server Configuration
        echo PORT=5000
        echo NODE_ENV=production
        echo.
        echo # Database ^(Optional^)
        echo DATABASE_URL=
    ) > .env
    echo.
    echo [IMPORTANT] Please add your API keys to the .env file
    echo Opening .env file for editing...
    notepad .env
)

REM Set environment variables
set NODE_ENV=production
set PORT=5000

REM Start the application
echo.
echo Starting EpochFilterPro on http://localhost:5000
echo.
echo Press Ctrl+C to stop the server
echo.

REM Check if we should use the built version or dev version
if exist "dist\index.js" (
    echo Running production build...
    node dist\index.js
) else (
    echo Running development server...
    call npx tsx server/index.ts
)

pause