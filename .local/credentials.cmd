@echo off

:: Check if a username is provided
if "%1"=="" (
    echo Error: No username provided.
    exit /b 1
)

:: Set the username variable
set username=%1

:: Ensure the clients directory exists
if not exist "clients" (
    mkdir "clients"
)

:: Run the Vagrant SSH command with the username and output the result to a file
vagrant ssh -c "/app/src/ovpn_credentials %username%" > "clients/%username%.ovpn"
