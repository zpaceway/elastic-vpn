@echo off

:: Check if a username is provided
if "%1"=="" (
    echo Error: No username provided.
    exit /b 1
)

:: Set the username variable
set username=%1

:: Run the Vagrant SSH command with the username
vagrant ssh -c "/app/src/ovpn_client %username%"
