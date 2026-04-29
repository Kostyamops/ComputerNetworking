@echo off
chcp 65001

echo 1 - DHCP
echo 2 - Static
set /p choice=Выбор:

if %choice%==1 (
 netsh interface ip set address "Ethernet" dhcp
 netsh interface ip set dns "Ethernet" dhcp
 echo Настройки получены автоматически
) else (
 set /p ip=IP:
 set /p mask=Mask:
 set /p gw=Gateway:
 set /p dns=DNS:

 netsh interface ip set address "Ethernet" static %ip% %mask% %gw%
 netsh interface ip set dns "Ethernet" static %dns%
 echo Статическая настройка применена
)
pause