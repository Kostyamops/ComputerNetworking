[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Get-NetAdapter | select Name, InterfaceDescription, Status, Speed | ft -AutoSize

Write-Host "Adapter Name:"
$n = Read-Host

Write-Host "1 - DHCP, 2 - Static:"
$m = Read-Host

if ($m -eq "1") {
    Set-NetIPInterface -InterfaceAlias $n -DHCP Enabled
    Set-DnsClientServerAddress -InterfaceAlias $n -ResetServerAddresses
    Write-Host "OK: DHCP"
} else {
    Write-Host "IP:"
    $ip = Read-Host
    Write-Host "GW:"
    $gw = Read-Host
    Write-Host "DNS:"
    $dns = Read-Host

    Remove-NetIPAddress -InterfaceAlias $n -Confirm:$false -ErrorAction SilentlyContinue
    Remove-NetRoute -InterfaceAlias $n -Confirm:$false -ErrorAction SilentlyContinue
    
    New-NetIPAddress -InterfaceAlias $n -IPAddress $ip -PrefixLength 24 -DefaultGateway $gw
    Set-DnsClientServerAddress -InterfaceAlias $n -ServerAddresses $dns
    Write-Host "OK: Static"
}
pause
