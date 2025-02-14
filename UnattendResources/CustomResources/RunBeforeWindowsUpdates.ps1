function Write-HostLog {
    <#
    .SYNOPSIS
     Uses KVP to communicate to the Hyper-V host the status of the various stages
     of the imaging generation. This feature works only if the VM where this script
     runs is spawned on Hyper-V and the 'Data Exchange' (aka Key Value Pair Exchange)
     is enabled for the instance. On KVM / ESXi / baremetal, this method is NOOP.
    #>
    Param($Stage = "Default",
          $StageLog
    )

    $KVPOutgoingRegistryKey = "HKLM://SOFTWARE/Microsoft/Virtual Machine/Auto"
    if ($Stage -and $StageLog -and (Test-Path $KVPOutgoingRegistryKey)) {
        Set-ItemProperty $KVPOutgoingRegistryKey -Name "ImageGenerationLog-${Stage}" `
            -Value $StageLog -ErrorAction SilentlyContinue
    }
}

Write-HostLog ">>>>>" "RunBeforeWindowsUpdates.ps1============start!"

echo "RunBeforeWindowsUpdates.ps1============"
# 获取网卡的接口索引 ================== 第2次重启（不需要重启）
$interfaceIndex = (Get-NetAdapter | Where-Object { $_.Name -eq "以太网" }).ifIndex
# 配置静态 IP 地址
New-NetIPAddress -InterfaceIndex $interfaceIndex -IPAddress 172.28.188.188 -PrefixLength 24 -DefaultGateway 172.28.188.1
# 配置 DNS 服务器
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses 8.8.8.8, 8.8.4.4
#Restart-Computer

Write-HostLog "<<<" "RunBeforeWindowsUpdates.ps1============finish!"