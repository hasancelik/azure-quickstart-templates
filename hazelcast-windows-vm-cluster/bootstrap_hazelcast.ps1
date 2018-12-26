param (
    [string]$clusterName,
    [string]$clusterPassword,
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

$mvnbuild = "C:\ProgramData\chocolatey\bin\mvn.exe"
$mvnargs = "exec:java --file C:\Temp\hazelcast\pom.xml"
$hazelcasttemp = "C:\Temp\hazelcast"

Start-Process -FilePath $mvnbuild -ArgumentList $mvnargs  -RedirectStandardOutput "$hazelcasttemp\hazelcast-standard.txt" -RedirectStandardError "$hazelcasttemp\hazelcast-error.txt" -NoNewWindow -PassThru