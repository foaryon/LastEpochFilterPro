@echo off
setlocal enabledelayedexpansion

REM EpochFilterPro Installation Script for Windows
REM This script installs all required dependencies and sets up the application

echo =========================================
echo   EpochFilterPro Installation Script
echo   Last Epoch AI Filter Generator
echo =========================================
echo.

REM Check if Node.js is installed
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is not installed!
    echo Please install Node.js v18 or higher from https://nodejs.org
    pause
    exit /b 1
)

REM Check Node.js version
for /f "tokens=*" %%i in ('node -v') do set NODE_VERSION=%%i
echo [OK] Node.js %NODE_VERSION% installed

REM Check if npm is installed
where npm >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] npm is not installed!
    echo Please install npm
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('npm -v') do set NPM_VERSION=%%i
echo [OK] npm %NPM_VERSION% installed

REM Install dependencies
echo.
echo Installing dependencies...
echo This may take a few minutes...
call npm install
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)
echo [OK] Dependencies installed successfully

REM Setup environment variables
echo.
echo Setting up environment...

if not exist .env (
    (
        echo # Database Configuration ^(PostgreSQL^)
        echo DATABASE_URL=
        echo PGDATABASE=
        echo PGHOST=
        echo PGPASSWORD=
        echo PGPORT=
        echo PGUSER=
        echo.
        echo # AI API Keys ^(Required for AI features^)
        echo GROQ_API_KEY=
        echo OPENAI_API_KEY=
        echo.
        echo # Server Configuration
        echo PORT=5000
        echo NODE_ENV=development
    ) > .env
    
    echo [OK] Created .env file
    echo.
    echo [IMPORTANT] API Keys Required
    echo Please add your API keys to the .env file:
    echo.
    echo 1. GROQ_API_KEY - Get from https://console.groq.com
    echo    ^(Required for ultra-fast AI filter generation^)
    echo.
    echo 2. OPENAI_API_KEY - Get from https://platform.openai.com
    echo    ^(Optional fallback for AI features^)
    echo.
    echo 3. DATABASE_URL - PostgreSQL connection string
    echo    ^(Optional - app works with in-memory storage^)
) else (
    echo [OK] .env file already exists
)

REM Try to build the application
echo.
echo Building the application...
call npm run build 2>nul
if %errorlevel% equ 0 (
    echo [OK] Application built successfully
) else (
    echo [WARNING] Build step skipped ^(development mode^)
)

echo.
echo =========================================
echo   Installation Complete!
echo =========================================
echo.
echo Next steps:
echo 1. Add your API keys to the .env file
echo 2. Run 'npm run dev' to start the development server
echo 3. Open http://localhost:5000 in your browser
echo.
echo For production deployment:
echo Run 'npm run build' then 'npm start'
echo.
echo Enjoy EpochFilterPro!
echo.
pause