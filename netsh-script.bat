@echo off
chcp 65001

echo 1 DHCP
echo 2 Static
set /p c=

if %c%==1 (
 netsh interface ip set address "Ethernet" dhcp
 netsh interface ip set dns "Ethernet" dhcp
) else (
 set /p ip=
 set /p mask=
 set /p gw=
 set /p dns=

 netsh interface ip set address "Ethernet" static %ip% %mask% %gw%
 netsh interface ip set dns "Ethernet" static %dns%
)
pause
