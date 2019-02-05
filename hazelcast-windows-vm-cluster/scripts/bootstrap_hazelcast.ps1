param (
    [string]$clusterName,
    [string]$hazelcastVersion,
    [string]$subscriptionId,
    [string]$aadClientId,
    [string]$aadClientSecret,
    [string]$aadTenantId,
    [string]$groupName,
    [string]$clusterTag,
    [string]$clusterPort
)

. .\install_hazelcast.ps1
refreshenv

# Openning the port of hazelcast member
netsh advfirewall firewall add rule name="Hazelcast Member" dir=in action=allow protocol=TCP localport=$clusterPort

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-ExecutionPolicy Unrestricted -Command "cd C:\Temp\hazelcast; mvn exec:java 2>&1 >> "C:\Temp\hazelcast\hazelcast-member.log""'
$trigger =  New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Hazelcast" -Description "Hazelcast Member" -RunLevel Highest
Get-ScheduledTask -TaskName "Hazelcast"
Start-ScheduledTask -TaskName "Hazelcast"
Start-Sleep -Seconds 300
Get-ScheduledTask -TaskName "Hazelcast"