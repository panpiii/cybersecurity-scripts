function Show-HeaderTPa940 {
	Write-Output "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
	Write-Output "  Author: [Your Name]"
	Write-Output "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
}

function Get-PortListTPa940 {
    param (
        [string]$PortsFile
    )
    $data = Import-Csv $PortsFile
    $result = @()
    foreach ($entry in $data) {
        $server = $entry.server
        $ports = $entry.port -split ","  # Split the ports into an array
        $result += [PSCustomObject]@{
            Server = $server
            Ports  = $ports
        }
    }
    return $result
}

function Get-PortStatusTPa940 {
    param (
        [array]$Ports
    )
    $results = @() 
    foreach ($row in $Ports) {
        foreach ($port in $row.Ports) {
            $status = Test-NetConnection -ComputerName $row.Server -Port $port -InformationLevel Detailed
            $results += [PSCustomObject]@{
                Server = $row.Server
                Port   = $port
                Status = if ($status.TcpTestSucceeded) { "Open" } else { "Closed" }
            }
        }
    }
    return $results
}

function Get-CIMConfigTPa940 {
    param (
        [string]$CIMFile
    )
    $data = Get-Content $CIMFile | ConvertFrom-Json
    return $data
}

function Get-CIMInfoTPa940 {
    param (
        [array]$CIMInfo
    )
    $results = @()
    foreach ($info in $CIMInfo) {
        try {
            $cimInstance = Get-CimInstance -ClassName $info.Class
            $value = $cimInstance | Select-Object -ExpandProperty $info.Property | Select-Object -First 1

            if ($info.Info -eq "Disk") {
                $value = [math]::Round($value / 1GB, 1) 
            } elseif ($info.Info -eq "Memory") { 
                $value = [math]::Round($value / 1GB, 1)
            }

            $results += [PSCustomObject]@{
                Info = $info.Info
                Value = $value
            }
        } catch {
            Write-Warning "Error getting CIM information for: $($info.Info)"
            Write-Warning "Error message: $($_.Exception.Message)"
            $results += [PSCustomObject]@{
                Info = $info.Info
                Value = "N/A" 
            }
        }
    }
    return $results
}



