echo "RunBeforeWindowsUpdates.ps1============"
# 获取网卡的接口索引 ================== 第2次重启（不需要重启）
$interfaceIndex = (Get-NetAdapter | Where-Object { $_.Name -eq "以太网" }).ifIndex
# 配置静态 IP 地址
New-NetIPAddress -InterfaceIndex $interfaceIndex -IPAddress 172.28.188.177 -PrefixLength 24 -DefaultGateway 172.28.188.1
# 配置 DNS 服务器
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses 8.8.8.8, 8.8.4.4
#Restart-Computer