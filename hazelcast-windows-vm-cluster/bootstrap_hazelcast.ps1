param (
    [string]$clusterName,
    [string]$clusterPassword,
    [string]$subscriptionId,
    [string]$aadClientId,
    [string]$aadClientSecret,
    [string]$aadTenantId,
    [string]$groupName,
    [string]$clusterTag
)

. .\install_hazelcast.ps1
refreshenv

$mvnbuild = "C:\ProgramData\chocolatey\bin\mvn.exe"
$mvnargs = "exec:java --file C:\Temp\hazelcast\pom.xml"
$hazelcasttemp = "C:\Temp\hazelcast"

Start-Process -FilePath $mvnbuild -ArgumentList $mvnargs  -RedirectStandardOutput "$hazelcasttemp\hazelcast-standard.txt" -RedirectStandardError "$hazelcasttemp\hazelcast-error.txt" -NoNewWindow -PassThru