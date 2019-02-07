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

echo $user
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-ExecutionPolicy Unrestricted -Command "cd C:\Temp\hazelcast; mvn exec:java 2>&1 >> "C:\Temp\hazelcast\hazelcast-member.log""'
echo '1'
$trigger =  New-ScheduledTaskTrigger -AtStartup
echo '2'
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Hazelcast" -User $user -Password $userPassword -Description "Hazelcast Member" -RunLevel Highest
echo '3'
Get-ScheduledTask -TaskName "Hazelcast"
Start-ScheduledTask -TaskName "Hazelcast"
Start-Sleep -Seconds 300
Get-ScheduledTask -TaskName "Hazelcast"