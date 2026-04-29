@echo off
chcp 65001 >nul

:menu
set "c="
cls
echo 1 - DHCP
echo 2 - STATIC
set /p c="Выбор: "

echo.
netsh interface show interface
echo.
set "iface="
set /p iface="Имя интерфейса: "

if "%c%"=="1" goto dhcp
if "%c%"=="2" goto static
goto menu

:dhcp
netsh interface ip set address name="%iface%" source=dhcp
netsh interface ip set dnsservers name="%iface%" source=dhcp
echo OK.
pause
exit

:static
set "ip="
set "mask="
set "gw="
set "dns="
set /p ip="IP: "
set /p mask="Mask: "
set /p gw="Gateway: "
set /p dns="DNS: "

netsh interface ip set address name="%iface%" static %ip% %mask% %gw% 1
netsh interface ip set dnsservers name="%iface%" static address=%dns% validate=no

echo OK.
pause
exit
