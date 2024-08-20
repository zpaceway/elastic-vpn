@echo off

:: Fetch the IP address from the Vagrant machine
for /f "tokens=*" %%i in ('vagrant ssh -c "hostname -I" ^| findstr /r /v "default\|Last\|connection"') do (
    set ip_address=%%i
    goto :afterloop
)

:afterloop
if "%ip_address%"=="" (
    echo Error: Unable to retrieve IP address.
    exit /b 1
)

echo %ip_address%
