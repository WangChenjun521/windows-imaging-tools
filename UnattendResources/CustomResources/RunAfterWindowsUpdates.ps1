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

Write-HostLog ">>>>>" "RunAfterWindowsUpdates.ps1============start!"


Write-HostLog "<<<" "RunAfterWindowsUpdates.ps1===============finish!"

