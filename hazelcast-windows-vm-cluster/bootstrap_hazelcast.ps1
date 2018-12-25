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

java -version
mvn --version

$mvnbuild = "C:\ProgramData\chocolatey\bin\mvn.exe"
$mvnargs = "exec:java --file C:\Temp\hazelcast\pom.xml"

$proc1 = Start-Process -FilePath $mvnbuild -ArgumentList $mvnargs  -RedirectStandardOutput "C:\Temp\hazelcast\hazelcast.log" -RedirectStandardError " C:\Temp\hazelcast\hazelcast-error.log" -Wait -PassThru
$proc1.waitForExit()

Write-Out "Finished"