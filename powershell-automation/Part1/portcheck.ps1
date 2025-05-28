# Update PSModulePath
$env:PSModulePath += ";$(Get-Location)\Modules"

# Check if the module is loaded
if (!(Get-Module -Name Assign05_part1_TPa940)) {
    Import-Module ".\Modules\Assign05_part1_TPa940\Assign05_part1_TPa940.psm1"
}

# Show Header
Show-HeaderTPa940

# File Paths
$portsFile = ".\Data\server_port.csv"
$cimFile = ".\Data\server_cim.json"

# Process Ports
$ports = Get-PortListTPa940 -PortsFile $portsFile
$portStatus = Get-PortStatusTPa940 -Ports $ports

# Process CIM Config
$cimConfig = Get-CIMConfigTPa940 -CIMFile $cimFile
$cimInfo = Get-CIMInfoTPa940 -CIMInfo $cimConfig

# Display Port Status
Write-Output "`nChecking the localhost port status"
$portStatus | Format-Table -Property @{Name="Info";Expression={"Port: $($_.Port)"}}, @{Name="Value";Expression={"$($_.Status)"}}

# Display CIM Info
Write-Output "`nChecking the localhost's OS info"
$cimInfo | Format-Table -Property Info, Value

# Save Results to JSON 
$jsonOutput = @()

# port status
foreach ($status in $portStatus) {
    $jsonOutput += [PSCustomObject]@{
        Info  = "Port:$($status.Port)"
        Value = $status.Status
    }
}

# CIM Info
foreach ($info in $cimInfo) {
    $jsonOutput += [PSCustomObject]@{
        Info = $info.Info
        Value = $info.Value
    }
}

# Convert the array to JSON and save it
$jsonOutput | ConvertTo-Json -Depth 3 | Out-File "Assign05_part1_TPa940.json"


# Remove the Module
Remove-Module Assign05_part1_TPa940

