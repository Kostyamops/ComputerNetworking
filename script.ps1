[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")

Get-NetAdapter | select Name, InterfaceDescription, Status, Speed | ft -AutoSize

$n = Read-Host "Enter Adapter Name"

$m = Read-Host "1 - DHCP, 2 - Static"

if ($m -eq "1") {
    Set-NetIPInterface -InterfaceAlias $n -DHCP Enabled
    Set-DnsClientServerAddress -InterfaceAlias $n -ResetServerAddresses
    Write-Host "OK: DHCP is ON"
} else {
    $ip = Read-Host "IP"
    $gw = Read-Host "Gateway"
    $dns = Read-Host "DNS"
    
    New-NetIPAddress -InterfaceAlias $n -IPAddress $ip -PrefixLength 24 -DefaultGateway $gw
    Set-DnsClientServerAddress -InterfaceAlias $n -ServerAddresses $dns
    Write-Host "OK: Static IP is set"
}
pause
