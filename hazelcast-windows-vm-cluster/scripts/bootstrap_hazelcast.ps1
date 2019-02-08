param (
    [string]$clusterName,
    [string]$hazelcastVersion,
    [string]$subscriptionId,
    [string]$aadClientId,
    [string]$aadClientSecret,
    [string]$aadTenantId,
    [string]$groupName,
    [string]$clusterTag,
    [string]$clusterPort,
    [string]$user,
    [string]$userPassword
)

. .\install_hazelcast.ps1
refreshenv

# Openning the port of hazelcast member
netsh advfirewall firewall add rule name="Hazelcast Member" dir=in action=allow protocol=TCP localport=$clusterPort

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-ExecutionPolicy Unrestricted -Command "cd C:\Temp\hazelcast; mvn exec:java 2>&1 >> "C:\Temp\hazelcast\hazelcast-member.log""'
$trigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName 'Hazelcast' -User $user -Password $userPassword -Description "Hazelcast Member" -RunLevel Highest
(Get-ScheduledTask -TaskName 'Hazelcast').State
while ((Get-ScheduledTask -TaskName 'Hazelcast').State  -ne 'Ready') {
    Write-Host "Registring scheduled task..."
}
Write-Host "ScheduledTask registered."
Start-ScheduledTask -TaskName 'Hazelcast'
(Get-ScheduledTask -TaskName 'Hazelcast').State
while ((Get-ScheduledTask -TaskName 'Hazelcast').State  -ne 'Running') {
    Write-Host "Waiting on scheduled task..."
}
Write-Host "ScheduledTask started."