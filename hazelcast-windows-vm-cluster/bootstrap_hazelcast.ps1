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

$hazelcastjob = Start-Job -Name "Hazelcast" -ScriptBlock {Set-Location "C:\Temp\hazelcast"; mvn exec:java 2>&1 >> "C:\Temp\hazelcast\hazelcast-member.log"}